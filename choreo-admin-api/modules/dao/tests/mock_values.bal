import ballerina/sql;

// Copyright (c) 2022, WSO2 Inc. (http://www.wso2.com). All Rights Reserved.
//
// This software is the property of WSO2 Inc. and its suppliers, if any.
// Dissemination of any information or reproduction of any material contained
// herein in any form is strictly forbidden, unless permitted by WSO2 expressly.
// You may not alter or remove any copyright or other notice from copies of this content.

string uuidMock = "3ac78213-9cd9-b96a-d98cbb16d4cc";
string handleMock = "choreotestorg";
string billingDateMock = "2021-07-30T10:09:57Z";
string billingDateTimestampMock = "1627639797657";
string createdAtMock = "2022-04-29T06:30:00Z";
string createdAtTimestampMock = "1651213800794";
string isPaidMock = "true";
string statusMock = "ACTIVE";
string stepQuotaMock = "1000000";
string tierNameMock = "Enterprise";
string tierIdMock = "3ac78213-9cd9-b96a-d98cbb16d4cc";

public Subscription mockSubscription = {
    organization: {
        orgUUID: uuidMock,
        orgHandle: handleMock
    },
    billingDate: billingDateMock,
    createdDate: createdAtMock,
    paidCustomer: isPaidMock,
    status: statusMock,
    stepQuota: stepQuotaMock,
    tierName: tierNameMock
};

SubscriptionDBRecord subscriptionDAOStream = {
    org_id: uuidMock,
    org_handle: handleMock,
    billing_date: billingDateTimestampMock,
    status: statusMock,
    is_paid: isPaidMock,
    step_quota: stepQuotaMock,
    created_at: createdAtTimestampMock,
    name: tierNameMock,
    tier_id: tierIdMock
};

function mockedSubscriptionDAO() returns SubscriptionDBRecord {

    SubscriptionDBRecord subscriptionDAOStream = {
        org_id: uuidMock,
        org_handle: handleMock,
        billing_date: billingDateTimestampMock,
        status: statusMock,
        is_paid: isPaidMock,
        step_quota: stepQuotaMock,
        created_at: createdAtTimestampMock,
        name: tierNameMock,
        tier_id: tierIdMock
    };
    return subscriptionDAOStream;
}

function mockedUpdateTierResult() returns sql:ExecutionResult {
    sql:ExecutionResult result = {
        affectedRowCount: 1,
        lastInsertId: null
    };
    return result;
}
