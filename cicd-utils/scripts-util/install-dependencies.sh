
# Function to install Salesforce CLI and required plugins
installPackages() {
    echo "------------------------------------------------------------------------------------------------------------"
    echo "|                              Installing Salesforce CLI and Plugins                                       |"
    echo "------------------------------------------------------------------------------------------------------------"

        sudo npm install @salesforce/cli@2.130.9 --global --silent --no-fund --no-audit
        echo 'y' | sf plugins install sfdx-git-delta@6.31.0
        sf plugins install code-analyzer@5.11.1
}

# Initiate installation of Salesforce CLI and Plugins
installPackages