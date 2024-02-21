# --------------------------------------------------------------------------------------------------------------
# Description : The purpose of this shell script is to get the org authenticate using secret url.
# Author : Kiranmoy Pradhan
# Date : 12/12/2023
# --------------------------------------------------------------------------------------------------------------
echo ${SECRET_URL_PATH} > ./CI_SFDX_URL.txt && 
sf org login sfdx-url --sfdx-url-file ./CI_SFDX_URL.txt --set-default --alias ${SOURCE_ORG_ALIAS}