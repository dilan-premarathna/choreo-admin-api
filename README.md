# choreo-admin-api
Choreo Admin API provides the admin functionalities of Choreo

## Prerequisites
- Ballerina SwanLake 2201.0.5
- MSSQL Database

## Developer Guide
This section explains the required steps for running and testing this service locally. First clone this repository and get into the root directory. Here onwards the root directory will be referred as `CHOREO_ADMIN_API_HOME`.

### Database Initialization
1. Download the [`choreo_app_db`](https://github.com/wso2-enterprise/choreo-control-plane/blob/main/databases/scripts/choreo_app_db_mssql.sql) and [`choreo_subscriptions_db`](https://github.com/wso2-enterprise/choreo-control-plane/blob/main/databases/scripts/choreo_subscriptions_db_mssql.sql) database schemas.
2. Then replace the `create user` section at the top of the file with the following code segment in `choreo_app_db` and `choreo_subscriptions_db` respectively.
```
IF NOT EXISTS(SELECT * FROM sys.databases WHERE name = 'choreo_app_db')
    BEGIN
        CREATE DATABASE choreo_app_db;
    END
GO
```
```
IF NOT EXISTS(SELECT * FROM sys.databases WHERE name = 'choreo_subscriptions_db')
    BEGIN
        CREATE DATABASE choreo_subscriptions_db;
    END
GO
```
3. Execute the following command to create the database and tables.
```
sqlcmd -S <database host name> -U <database user name> -P <database password> -i choreo_app_db_mssql.sql
```
```
sqlcmd -S <database host name> -U <database user name> -P <database password> -i choreo_subscriptions_db_mssql.sql
```
4. Populate the `choreo_app_db` database with following commands.

Add an organization to the table.
```
INSERT INTO [organization] (uuid, name, handle, created_at, updated_at) VALUES ('<Your Org UUID>', '<Your Org Name>', '<Your Org Handle>', '2022-08-22 00:00:00.000', '2022-08-22 00:00:00.000');
```
Get the `id` from the `organization` table and execute the following command to add admin role.
```
INSERT INTO [role] (display_name, handle, description, organization_id, default_role, created_by, updated_by, created_at, updated_at) VALUES ('Admin', 'admin', 'Organization admin role', '<Added Organization ID>', 1, '<Added Organization ID>', '<Added Organization ID>', '2022-08-22 00:00:00.000', '2022-08-22 00:00:00.000');
```
Add new user.
```
INSERT INTO [user] (idp_id, is_anonymous, is_enterprise, created_at, updated_at) VALUES ('<Your IDP ID>', 0, 0, '2022-08-22 00:00:00.000', '2022-08-22 00:00:00.000');
```
Get the `role id` from role table & `user id` from the [user] table and add role-member mapping.
```
INSERT INTO role_member_mapping (role_id, user_id, created_at, updated_at) VALUES ('<role id>', '<user id>', '2022-08-22 00:00:00.000', '2022-08-22 00:00:00.000');
```
5. Populate the `choreo_subscriptions_db` database with following commands.

```
INSERT INTO choreo_subscriptions_db.dbo.tier (id,name,description,is_paid,created_at,is_internal) VALUES
	 (N'01ebea3a-7735-10be-b3c0-ba95f991e877',N'Free',N'Free tier to tryout choreo',0,1627639797657,0),
	 (N'01ebea43-be76-1d7a-b410-2d1b873c57af',N'Pay As You Go',N'Tier for paid users',1,1627639797657,0),
	 (N'01ec1f84-ce3d-122e-ac9b-f10c95fd72da',N'Enterprise',N'Tier for enterprise users',1,1627639797657,1);	 
GO

INSERT INTO choreo_subscriptions_db.dbo.subscription (id,org_id,org_handle,tier_id,billing_date,status,is_paid,step_quota) VALUES
	 (N'0000060f-569d-4394-b689-4624b9a31b5b',N'73aaf255-ea0e-4b53-b91c-ff2d2a1bd8cb',N'jhondoe',N'01ebea3a-7735-10be-b3c0-ba95f991e877',1627639797657,N'ACTIVE',0,5000),
	 (N'00151c87-07c0-48b5-ad68-103b1f6f1a90',N'96c958c9-1205-487d-a32a-c4dd14d0c898',N'jackbob',N'01ec1f84-ce3d-122e-ac9b-f10c95fd72da',1627639797657,N'ACTIVE',1,1000000);

GO
```

### Running unit Tests
In order to run the unit tests execute the following command from `CHOREO_ADMIN_API_HOME`.
```
bal test
```

### Build Locally
In order to build the service execute the following command from `CHOREO_ADMIN_API_HOME`.
```
bal build
```

### Running Locally
#### Secret Configurations
The credential for the MSSQL Server is not provided via the config file to avoid keeping them there in plain text format.
Hence, you have to set the following two environment variable keys to set the password of MSSQL Server.

```
export CHOREO_DB_PASSWORD=<MSSQL Server Password>
export CHOREO_APP_DB_PASSWORD=<MSSQL Server Password>
```

#### Run
After completing the above configurations you can start the service with one of the following commands.
```
java -jar <path to jar file>
```
#### Test

In order to invoke the service you will need to obtain a valid jwt token. For this login to the Choero Console, open the browser developer console and check the network trace. From the network trace you can obtain a token from a browser request. 

- Following request will return the subscription details of the organized that was added in step 5 above. 
```
curl 'http://localhost:9090/org/subscription/73aaf255-ea0e-4b53-b91c-ff2d2a1bd8cb' -H 'x-forwarded-authorization: Bearer <token>'
```
A successful invocation will result in the following response by the service
```
{
    "organization": {
        "orgUUID": "73aaf255-ea0e-4b53-b91c-ff2d2a1bd8cb",
        "orgHandle": "jhondoe"
    },
    "billingDate": "2021-07-30T10:09:57Z",
    "createdDate": "2022-09-20T13:55:59Z",
    "paidCustomer": "false",
    "status": "ACTIVE",
    "stepQuota": "5000",
    "tierName": "Free"
}
```

- Following request will update the subscription details of the organization from a Free tier to the Enterprise tier.
```
curl -X PUT 'http://localhost:9090/org/subscription/73aaf255-ea0e-4b53-b91c-ff2d2a1bd8cb' -H 'x-forwarded-authorization: Bearer <token>' -H 'Content-Type: application/json' \
-d '{
"stepQuota":"1000000",
"tierName":"Enterprise"
}'
```
A successful invocation will result in the following response by the service
```
{
    "organization": {
        "orgUUID": "73aaf255-ea0e-4b53-b91c-ff2d2a1bd8cb",
        "orgHandle": "jhondoe"
    },
    "billingDate": "2021-07-30T10:09:57Z",
    "createdDate": "2022-09-20T13:55:59Z",
    "paidCustomer": "true",
    "status": "ACTIVE",
    "stepQuota": "1000000",
    "tierName": "Enterprise"
}
```

## Health Checks

Following endpoints can be used for the health check purposes in subscription service.

```sh
curl http://localhost:9093/readiness
curl http://localhost:9093/liveness
