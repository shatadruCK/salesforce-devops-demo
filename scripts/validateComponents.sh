
function validateComponent() {
  echo "---------------------------------------------------------------------------------------------------"
  echo "|                                      Component Validation                                       |"
  echo "---------------------------------------------------------------------------------------------------"

  TARGET_ORG_ALIAS="${ORG_ALIAS}"
  PACKAGE_XML="delta-package/package/package.xml"
  TEST_CLASS_FILE="manifest/testclass/testclass.txt"
  RESULT_FILE="./DEPLOY_ORG.txt"

  if grep -q '<types>'  $PACKAGE_XML
  then
    if grep -q '<name>ApexClass</name>' $PACKAGE_XML; then
          # Initiating async deployment with RunSpecifiedTests.
          sf project deploy start -o $TARGET_ORG_ALIAS -x $PACKAGE_XML -l RunSpecifiedTests -t $(cat $TEST_CLASS_FILE) --verbose --dry-run --async --ignore-conflicts | tee $RESULT_FILE 
      else
          # Initiating async deployment without specifying test classes.
          sf project deploy start -o $TARGET_ORG_ALIAS -x $PACKAGE_XML --verbose --dry-run --async --ignore-conflicts | tee $RESULT_FILE
      fi

            # Fetching Deploy Id from the output.
        VALIDATION_OUTPUT=$(cat $deployOrgFilePath) 
        DEPLOYMENT_STRING=${VALIDATION_OUTPUT#*Deploy ID: }
        echo $DEPLOYMENT_STRING
        FINAL_DEPLOY_ID=${DEPLOYMENT_STRING:0:18}
        echo $FINAL_DEPLOY_ID

        # Monitor the async validation job and generate coverage and test reports
        sf project deploy resume --job-id $FINAL_DEPLOY_ID --coverage-formatters cobertura --junit --results-dir "pipeline-artifacts" --verbose

        # Fail the pipeline if validation was unsuccessful
        DEPLOY_EXIT_CODE=${PIPESTATUS[0]}
        if [ $DEPLOY_EXIT_CODE != 0 ]; then
            exit $DEPLOY_EXIT_CODE;
        fi
    else
        echo "Empty package.xml file."
        exit 0
    fi
}

validateComponent
