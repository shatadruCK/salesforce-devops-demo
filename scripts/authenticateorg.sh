# CK_LOGO=$(cat scripts/cklogo.txt)
# echo ${SECRET_URL_PATH} > ./CI_SFDX_URL.txt && 
# sfdx force:auth:sfdxurl:store -f ./CI_SFDX_URL.txt -a ${SOURCE_ORG_ALIAS} -d

authorizeorgjwt(){
    local Cyan='\033[1;36m'
    local Red='\033[1;31m'
    echo -e "${Cyan}------------------------------------------------------------------------------------------------------------"
    echo -e "${Cyan}|                                             Authorizing Org                                              |"
    echo -e "${Cyan}------------------------------------------------------------------------------------------------------------"

    # Authenticating org using JWT
    sf org login jwt --client-id "${CLIENT_ID}" --jwt-key-file "${SECURE_FILE}" --username "${USERNAME}" --alias "${ORG_ALIAS}" --instance-url "${INSTANCE_URL}"
}

# Initiate Auhorization
authorizeorgjwt
