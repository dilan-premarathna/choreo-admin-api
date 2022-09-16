import choreo_admin_api.util;

configurable string CHOERO_SYS_ORG_ID = "bea92b4f-545a-4624-95b0-dde815a06af0";
public configurable string choreoJwtIssuer = util:readFromEnvVar("CHOREO_JWT_ISSUER",
        "https://sts.preview-dv.choreo.dev:443/oauth2/token");
public string choreoJwtAudience = util:readFromEnvVar("CHOREO_JWT_AUDIENCE", "Wxqy0liCfLBsdpXOhkcxZz6uLPka");
public string choreoJwtJwksUrl = util:readFromEnvVar("CHOREO_JWT_JWKS_URL",
        "https://sts.preview-dv.choreo.dev/oauth2/jwks");
