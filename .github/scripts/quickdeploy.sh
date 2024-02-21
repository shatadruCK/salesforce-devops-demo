# --------------------------------------------------------------------------------------------------------------
# Description : The purpose of this shell script is to initiate quick deployment of an already validated 
#               package.
# Author : Kiranmoy Pradhan
# Date : 12/12/2023
# --------------------------------------------------------------------------------------------------------------

if [ -f DEPLOY_ORG.txt ]
then
    if grep -q '<name>ApexClass</name>' changed-sources/package/package.xml;
    then 
        VALIDATION_OUTPUT=$(cat ./DEPLOY_ORG.txt) 
        DEPLOYMENT_STRING=${VALIDATION_OUTPUT#*Deploy ID: }
        echo $DEPLOYMENT_STRING
        FINAL_DEPLOY_ID=${DEPLOYMENT_STRING:0:18}
        echo $FINAL_DEPLOY_ID
        sf project deploy quick -i $FINAL_DEPLOY_ID -o $SOURCE_ORG_ALIAS
    else
        sf project deploy start -o $SOURCE_ORG_ALIAS -x changed-sources/package/package.xml
    fi
fi