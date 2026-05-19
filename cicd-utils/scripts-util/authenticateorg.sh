authorizeorgjwt(){
    local Cyan='\033[1;36m'
    local Red='\033[1;31m'
    echo -e "${Cyan}------------------------------------------------------------------------------------------------------------"
    echo -e "${Cyan}|                                             Authorizing Org                                              |"
    echo -e "${Cyan}------------------------------------------------------------------------------------------------------------"

    # Authenticating org using JWT
    sf org login jwt --client-id "${CLIENT_ID}" --jwt-key-file "${SECURE_FILE}" --username "${USERNAME}" --alias "${AUTH_ORG_ALIAS}" --instance-url "${INSTANCE_URL}"
}

# Initiate Auhorization
authorizeorgjwt