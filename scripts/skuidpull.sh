SPECIFIED_SKUID_PAGES=$(cat skuidpages/skuidpages.txt) &&  for i in $SPECIFIED_SKUID_PAGES
do
    echo "Pulled $i page"
    sfdx skuid:page:pull --page $i
done