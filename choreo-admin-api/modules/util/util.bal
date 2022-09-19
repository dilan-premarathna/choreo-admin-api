// Copyright (c) 2022, WSO2 Inc. (http://www.wso2.com). All Rights Reserved.
//
// This software is the property of WSO2 Inc. and its suppliers, if any.
// Dissemination of any information or reproduction of any material contained
// herein in any form is strictly forbidden, unless permitted by WSO2 expressly.
// You may not alter or remove any copyright or other notice from copies of this content.

import ballerina/log;
import ballerina/time;
import ballerina/os;

public isolated function dateFromTimestamp(string timeStamp) returns string {
    string date = "";
    int|error utcTime = int:fromString(timeStamp.substring(0, 10));
    if utcTime is int {
        date = time:utcToString([utcTime, 0]);
    } else {
        log:printError("Error in date conversion ", Time_Stamp = timeStamp, 'error = utcTime);
    }
    return date;
}

# Returns an env variable from the given key
#
# + envKey - the key for the env variable
# + defaultVal - the default value (int) to return if that is not set
# + return - returns the env variable or default value if not set
public function readFromEnvVar(string envKey, string defaultVal) returns string {
    string envVarStr = os:getEnv(envKey);
    log:printDebug("Read environment variable", (), (), {"key": envKey, "value": envVarStr});
    if envVarStr != "" {
        return envVarStr;
    }
    log:printDebug("Get default value instead of environment variable", (), (), {
        "key": envKey,
        "value": envVarStr,
        "default_value": defaultVal
    });
    return defaultVal;
}
