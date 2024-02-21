# --------------------------------------------------------------------------------------------------------------
# Description : The purpose of this shell script is to get the corresponding test class only for the changed 
#               apex classes so that it saves time during the deployment.
# Author : Kiranmoy Pradhan
# Date : 12/12/2023
# --------------------------------------------------------------------------------------------------------------

# updating the HOME to point to root as HOME is pointing to GIT and the extension is loaded at root directory
export HOME=/root

# Fetching origin and adding it to safe repository.
git config --global --add safe.directory "*"
git fetch origin "+refs/heads/*:refs/remotes/origin/*"

# Creating directory for storing the generated delta files
mkdir changed-sources
mkdir pipeline-artifacts
touch pipeline-artifacts/pmd-results.csv

# executing command to get the delta package validated.
sf sgd:source:delta --help
sf sgd:source:delta -a 56 --to HEAD --from origin/$BASE_BRANCH --output changed-sources/ -i manifest/mdapi/.sgdignore --generate-delta

# printing the output to the console.
echo "--- package.xml generated with added and modified metadata since $LAST_DEPLOYED_COMMIT in $BASE_BRANCH ---"
    cat changed-sources/package/package.xml
echo

echo "--- destructiveChanges.xml generated with deleted metadata since $LAST_DEPLOYED_COMMIT in $BASE_BRANCH ---"
    cat changed-sources/destructiveChanges/destructiveChanges.xml
echo