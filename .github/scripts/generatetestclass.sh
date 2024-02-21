# --------------------------------------------------------------------------------------------------------------
# Description : The purpose of this shell script is to get the corresponding test class only for the changed 
#               apex classes so that it saves time during the deployment.
# Author : Kiranmoy Pradhan
# Date : 12/12/2023
# --------------------------------------------------------------------------------------------------------------

git config --global --add safe.directory '*'
testclass=""

# getting the list of changed apex classes so that we can get the corresponding test class for the same
SPECIFIED_APEX_CLASSES=$(git diff HEAD origin/$BASE_BRANCH --name-only force-app/main/default/classes)
SPECIFIED_APEX_CLASSES+=" "$(git diff HEAD origin/$BASE_BRANCH --name-only force-app/main/default/triggers)

echo Apex Class / Trigger" || ======> || "Corresponding Test Class

# Iterating through the list to get the test class name as per CSV.
for className in $SPECIFIED_APEX_CLASSES
do   
    # Removing prefixes and postfixes from the name so that we can get corresponding test class
    className=${className#*force-app/main/default/classes/}
    className=${className#*force-app/main/default/triggers/}
    className=${className%%.*}
    
    # Iterating through test class CSV to get the key value.
    for row in $(cat testclass/testclass.txt)
    do 
        # Fetching the Key value pair from the rows of CSV.
        value=${row#*,}
        key=${row%,*}
        if [[ $key == $className && ( $testclass != *" $value "* || $testclass != *" $value"* || $testclass != *"$value "* ) ]]
        then
            echo $key" || ======> || "$value
            testclass+=" $value"
        fi
    done
done

# Posting the csv to the txt file so that they can be utilized in the deployment.
echo ${testclass#*,} > testclass/testclass.txt
