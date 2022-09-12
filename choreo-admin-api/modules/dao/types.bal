public type SubscriptionDBRecord record {
    string org_id;
    string org_handle;
    string tier_id;
    string stripe_subscription_item_id?;
    string billing_date;
    string status;
    string is_paid;
    string step_quota;
    string created_at;
    string name;
};

public type Organization record {
    string orgUUID = "";
    string orgHandle = "";
};

public type Subscription record {
    Organization organization = {};
    string billingDate = "";
    string createdDate = "";
    string paidCustomer = "";
    string status = "";
    string stepQuota = "";
    string TierName = "";
};

public type UpdateSubscripionTier record {
    string stepQuota;
    string tierName;
};
