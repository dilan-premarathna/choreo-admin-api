string uuidMock = "3ac78213-9cd9-b96a-d98cbb16d4cc";
string handleMock = "choreotestorg";
string billingDateMock = "2021-07-30T10:09:57Z";
string createdAtMock = "2022-04-29T06:30:00Z";
string isPaidMock = "true";
string statusMock = "ACTIVE";
string stepQuotaMock = "1000000";
string tierNameMock = "Enterprise";

public json mockSubscription = {
    "organization": {
        "orgUUID": uuidMock,
        "orgHandle": handleMock
    },
    "billingDate": billingDateMock,
    "createdDate": createdAtMock,
    "paidCustomer": isPaidMock,
    "status": statusMock,
    "stepQuota": stepQuotaMock,
    "TierName": tierNameMock
};
