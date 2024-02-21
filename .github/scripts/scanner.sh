# --------------------------------------------------------------------------------------------------------------
# Description : The purpose of this shell script is to get the pmd executed for code quality validation
# Author : Kiranmoy Pradhan
# Date : 12/12/2023
# --------------------------------------------------------------------------------------------------------------

# Executing Scanner command to get the violations tracked.
sf scanner:run --engine "pmd" --format csv --pmdconfig "pmd-util/pmdRules.xml" --outfile "pipeline-artifacts/pmd-results.csv" --target changed-sources/force-app/main --normalize-severity
# show pmd result content
cat pipeline-artifacts/pmd-results.csv