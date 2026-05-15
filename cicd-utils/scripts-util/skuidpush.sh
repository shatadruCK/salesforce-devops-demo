#fetch the current commit to remote
git fetch origin "+refs/heads/*:refs/remotes/origin/*"

#Install skuid sfdx plugin
echo 'y' | sfdx plugins:install skuid-sfdx

#getting a list of skuid pages with changes.
SPECIFIED_SKUID_PAGES=$(git diff HEAD origin/$BASE_BRANCH --name-only skuidpages)

#Iterating through all the changes in skuidpages folder to get the changes
for i in $SPECIFIED_SKUID_PAGES
do
    # echo "Inside For loop $i has extnsion ${i#*.}"
    # if [ "${i: -4}" == ".xml" ] 
    if [ "${i#*.}" = "xml" ]
    then
        echo "This page $i has some recent changes."
        sfdx skuid:page:push --page $i -u $SOURCE_ORG_ALIAS
    fi
done