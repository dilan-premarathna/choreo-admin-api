import ballerina/sql;
import ballerinax/java.jdbc;
import choreo_admin_api.util;

public final jdbc:Client dbClient = check createJdbcClient();

public isolated function getOrgSubsctiptionDetails(string orgID) returns json|error {

    sql:ParameterizedQuery stepUsageQuery = `SELECT subscription.org_id,subscription.org_handle,
        subscription.billing_date,subscription.created_at,subscription.is_paid,subscription.status, 
        subscription.step_quota, tier.name  FROM subscription INNER JOIN tier ON subscription.tier_id=tier.id 
        WHERE org_id=${orgID.trim()}`;
    SubscriptionDBRecord subscriptionDBRecord = check dbClient->queryRow(stepUsageQuery);

    string billing_date = util:dateFromTimestamp(subscriptionDBRecord.billing_date);
    string created_at = util:dateFromTimestamp(subscriptionDBRecord.created_at);

    Subscription subscription = {
        organization: {
            orgUUID: subscriptionDBRecord.org_id,
            orgHandle: subscriptionDBRecord.org_handle
        },
        billingDate: billing_date,
        createdDate: created_at,
        paidCustomer: subscriptionDBRecord.is_paid,
        status: subscriptionDBRecord.status,
        stepQuota: subscriptionDBRecord.step_quota,
        TierName: subscriptionDBRecord.name
    };
    return subscription.toJson();
}

public isolated function updateTier(string orgID, UpdateSubscripionTier subscription) returns int|error {
    int isPaid = 1;

    string[] choreoSubPlan = ["Free", "Pay As You Go", "Enterprise"];

    if choreoSubPlan.indexOf(subscription.tierName) == () {
        return error("Invalid Tier");
    }
    if subscription.tierName == "Free" {
        isPaid = 0;
    }
    sql:ParameterizedQuery updateQuery = `UPDATE subscription SET tier_id=(SELECT id FROM tier WHERE name
        =${subscription.tierName} ORDER BY id OFFSET 0 ROWS FETCH NEXT 1 ROWS ONLY),is_paid=${isPaid},
        step_quota=${subscription.stepQuota} WHERE org_id=${orgID.trim()}`;
    sql:ExecutionResult|sql:Error executionResult = dbClient->execute(updateQuery);

    if (executionResult is sql:Error) {
        return error("Error during update operation");
    } else {
        if (executionResult.affectedRowCount == 0) { // no rows affected
            return -1;
        }
        return 0;
    }

}

function createJdbcClient() returns jdbc:Client|error {
    jdbc:Client|sql:Error jdbcClient = check new (url = CONN_STR,
        user = CHOREO_DB_USERNAME, password = CHOREO_DB_PASSWORD, connectionPool = {maxOpenConnections: 50},
        options = {properties: {"useSSL": true}});
    return jdbcClient;
}
