# --------------------------------------------------------------------------------------------------------------
# Description : The purpose of this shell script is to make the package ready for deployment by validation.
# Author : Kiranmoy Pradhan
# Date : 12/12/2023
# --------------------------------------------------------------------------------------------------------------

echo "Delta Check-Only"
# Checking if any metadata changes are in package.xml
if grep -q '<types>' changed-sources/package/package.xml;
then
    # Initiating async deployment.
    sf project deploy start -o $SOURCE_ORG_ALIAS -x changed-sources/package/package.xml -l RunSpecifiedTests -t $(cat ./testclass/testclass.txt) --verbose --dry-run --async | tee ./DEPLOY_ORG.txt
    
    # Fetching Deploy Id from the output.
    VALIDATION_OUTPUT=$(cat ./DEPLOY_ORG.txt) 
    DEPLOYMENT_STRING=${VALIDATION_OUTPUT#*Deploy ID: }
    echo $DEPLOYMENT_STRING
    FINAL_DEPLOY_ID=${DEPLOYMENT_STRING:0:18}
    echo $FINAL_DEPLOY_ID

    # Watch the deployment for validation.
    sf project deploy resume --job-id $FINAL_DEPLOY_ID --coverage-formatters cobertura --junit --results-dir "pipeline-artifacts" --verbose

    DEPLOY_EXIT_CODE=${PIPESTATUS[0]}
    if [ $DEPLOY_EXIT_CODE != 0 ]
    then
        exit $DEPLOY_EXIT_CODE;
    fi
else
    echo "Empty package.xml file."
    exit 0
fi