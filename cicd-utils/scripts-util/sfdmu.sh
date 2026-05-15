cd sfdmu/firstrun
sfdx plugins:install sfdmu
if [ "$SOURCE_ORG_ALIAS" = "Production" ]; 
then
    echo "Migrating to Production environment"
    echo $PRODUCTION_DOMAIN | sfdx sfdmu:run --sourceusername csvfile --targetusername $SOURCE_ORG_ALIAS
else
    yes y  | sfdx sfdmu:run --sourceusername csvfile --targetusername $SOURCE_ORG_ALIAS
fi