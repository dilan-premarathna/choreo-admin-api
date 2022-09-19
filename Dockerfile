# -------------------------------------------------------------------------------------
#
# Copyright (c) 2022, WSO2 Inc. (http://www.wso2.com). All Rights Reserved.
#
# This software is the property of WSO2 Inc. and its suppliers, if any.
# Dissemination of any information or reproduction of any material contained
# herein in any form is strictly forbidden, unless permitted by WSO2 expressly.
# You may not alter or remove any copyright or other notice from copies of this content.
#
# --------------------------------------------------------------------------------------

FROM ballerina/ballerina:2201.0.5 AS ballerina-builder
USER root
ADD . /src
WORKDIR /src

RUN bal build choreo-admin-api

FROM adoptopenjdk/openjdk11:jre-11.0.15_10-alpine
WORKDIR /home/ballerina

LABEL maintainer="dev@ballerina.io"

RUN addgroup troupe \
    && adduser -S -s /bin/bash -g 'ballerina' -G troupe -D ballerina \
    && apk add --update --no-cache bash \
    && chown -R ballerina:troupe /opt/java/openjdk/bin/java \
    && rm -rf /var/cache/apk/*

COPY --from=ballerina-builder /src/choreo-admin-api/target/bin/choreo_admin_api.jar /home/ballerina
RUN chown ballerina /home/ballerina/choreo_admin_api.jar

EXPOSE 9090
EXPOSE 9093
USER ballerina

CMD java -XX:InitialRAMPercentage=50.0 -XX:+UseContainerSupport -XX:MinRAMPercentage=75.0 -XX:MaxRAMPercentage=75.0 -jar choreo_admin_api.jar \
    || cat ballerina-internal.log