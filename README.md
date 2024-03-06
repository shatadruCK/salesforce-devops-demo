# **Salesforce DX Project & CI/CD Setup**

Welcome to our Salesforce DX (SFDX) Project Boilerplate! This comprehensive starter project allows you to quickly set up a production-ready SFDX project and seamlessly integrate Continuous Integration/Continuous Deployment (CI/CD) processes. With just a few simple steps, you'll have a fully configured SFDX environment on your machine, ready for efficient Salesforce development.

**Table of Contents**
- [**Introduction**](#introduction)
- [**Key Features**](#key-features)
- [**Project Structure**](#project-structure)
- [**Setup Guide**](#setup-guide)

# **Introduction**

Salesforce DX (Developer Experience) revolutionizes the way developers build and manage Salesforce applications. It provides a modern development lifecycle that enhances collaboration, simplifies development tasks, and ensures the delivery of high-quality applications. 

Continuous Integration and Continuous Deployment (CI/CD) practices further amplify the benefits of Salesforce DX by automating the process of integrating code changes, running tests, and deploying updates to various environments.

**Salesforce DX Project**

A Salesforce DX project is a structured workspace that houses all the resources necessary for developing, testing, and deploying Salesforce applications. Key components of a Salesforce DX project include:

- **Source-Driven Development:** Salesforce DX embraces a source-driven development model, where the source code, configuration, and metadata are stored in version control systems such as Git.

- **Modular Architecture:** Projects are organized into modular components, such as apps, modules, and packages, facilitating collaboration among developers and enabling better code reuse.

- **Scratch Orgs:** Scratch orgs are ephemeral and disposable Salesforce environments that closely mimic production orgs. Developers can create, modify, and delete scratch orgs dynamically, enabling isolated development and testing of features.

- **CLI Commands:** The Salesforce DX CLI provides a powerful set of commands for managing Salesforce DX projects, including creating scratch orgs, deploying metadata, running tests, and more.

**CI/CD for Salesforce DX**

Continuous Integration (CI) and Continuous Deployment (CD) practices streamline the development and release process for Salesforce applications. CI/CD involves automating various stages of the development lifecycle, including:

- **Source Control Integration:** Developers commit code changes to version control systems, triggering CI pipelines.

- **Automated Testing:** CI pipelines automatically run unit tests, integration tests, and other types of tests to ensure code quality and functionality.

- **Deployment Automation:** CD pipelines deploy code changes to different environments, such as development, QA, UAT, and production, with minimal manual intervention.

- **Feedback Loop:** CI/CD pipelines provide real-time feedback on code changes, enabling developers to quickly identify and address issues.

By implementing CI/CD for Salesforce DX projects, organizations can accelerate development cycles, improve code quality, and deliver value to customers more efficiently.

In this guide, we will explore the setup and configuration of CI/CD pipelines for Salesforce DX projects, empowering teams to leverage the full potential of Salesforce DX and achieve greater agility in application development and delivery.

# **Key Features**

**Efficient Project Setup:**
It provides a streamlined process for setting up your SFDX project, ensuring rapid deployment and configuration.

**CI/CD Integration:**
Enjoy seamless integration of CI/CD processes into your SFDX project. This includes automated builds, unit testing, and deployment pipelines, facilitating a smooth and reliable development workflow.

**Salesforce Metadata Changes Deployment:**
Easily deploy changes to Salesforce metadata, including Apex classes, custom fields, objects, profiles, and permissions, using the CI/CD process. This ensures timely and consistent deployment of Salesforce configurations.

**Skuid Page Deployment:**
Seamlessly deploy Skuid pages to your Salesforce org, allowing for rapid development and customization of user interfaces.

**Data Deployment with SFDX Data Migration Utility (SFDMU):**
Leverage the power of the SFDX Data Migration Utility (SFDMU) to efficiently deploy data to your Salesforce org. This feature enables you to easily populate your org with test data or migrate data between environments.

**Static Code Anlysis:** Incorporated static code analysis using PMD as a key feature within the CI/CD pipeline, enabling automatic detection of code issues and ensuring adherence to coding standards, thereby enhancing code quality and maintainability.


# **Project Structure**

```
ck--salesforce--devops
├─ .eslintignore
├─ .forceignore
├─ .github
│  └─ workflows
│     ├─ auto-deployment.yml
│     ├─ deployment-workflow.yml
│     ├─ manual-deployment.yml
│     ├─ pr-validation-workflow.yml
│     └─ pr-validation.yml
├─ .gitignore
├─ .husky
│  └─ pre-commit
├─ .prettierignore
├─ .prettierrc
├─ .vscode
│  ├─ extensions.json
│  ├─ launch.json
│  ├─ settings.json
│  └─ tasks.json
├─ README.md
├─ cicd-utils
│  ├─ pmd-util
│  │  └─ pmd-rule
│  │     └─ pmdRules.xml
│  ├─ scripts-util
│  │  ├─ authenticateorg.sh
│  │  ├─ generatedeltapkg.sh
│  │  ├─ generatetestclass.sh
│  │  ├─ quickdeploy.sh
│  │  ├─ scanner.sh
│  │  ├─ sfdmu.sh
│  │  ├─ skuidpush.sh
│  │  └─ validateComponents.sh
│  ├─ sfdmu
│  │  ├─ firstrun
│  │  │  └─ export.json
│  │  └─ sfdmupull.sh
│  ├─ sgddelta-util
│  │  └─ .sgdignore
│  ├─ skuid-util
│  │  ├─ skuid-page
│  │  │  └─ skuidPages.txt
│  │  └─ skuidpull.sh
│  └─ testclass-util
│     ├─ allTestClasses.txt
│     └─ subsetOfAllTestClasses.txt
├─ config
│  └─ project-scratch-def.json
├─ force-app
│  └─ main
│     └─ default
├─ jest.config.js
├─ manifest
│  └─ package.xml
├─ package.json
├─ scripts
│  ├─ apex
│  │  └─ hello.apex
│  └─ soql
│     └─ account.soql
└─ sfdx-project.json

```

**Folder and File Details**

- **.eslintignore**: Specifies patterns to be ignored by ESLint.
  
- **.forceignore**: Lists files and directories to exclude when deploying Salesforce metadata.

- **.github**: Folder containing GitHub Actions workflows for automating CI/CD processes.

  - **workflows**: Subfolder containing YAML files defining different GitHub Actions workflows.

- **.gitignore**: Specifies intentionally untracked files to ignore in Git.

- **.husky**: Folder containing configuration for Husky, a Git hooks manager.

  - **pre-commit**: Folder containing pre-commit hook scripts.

- **.prettierignore**: Lists files to be ignored by Prettier code formatter.

- **.prettierrc**: Configuration file for Prettier code formatter.

- **.vscode**: Contains Visual Studio Code settings and configurations.

- **README.md**: Markdown file containing project documentation and instructions.

- **cicd-utils**: Folder containing utilities/scripts related to CI/CD processes.

  - **pmd-util**: Utilities for PMD (Programming Mistake Detector) rule configuration.

  - **scripts-util**: Scripts for various development and deployment tasks.

  - **sfdmu**: Salesforce Data Migration Utility scripts.

  - **sgddelta-util**: Utilities for Salesforce Get Delta operations in the CI/CD process.

  - **skuid-util**: Utilities for managing Skuid pages deployment using CI/CD.

  - **testclass-util**: Utilities for managing Apex test classes in CI/CD process.

- **config**: Contains configuration files for the project.

  - **project-scratch-def.json**: Definition file for Salesforce scratch org creation.

- **force-app**: Contains the source code and metadata for the Salesforce application.

- **jest.config.js**: Configuration file for Jest testing framework.

- **manifest**: Contains the package.xml file for retrieving metadata components.

- **package.json**: npm package configuration file.

- **scripts**: Contains sample Apex and SOQL scripts.

- **sfdx-project.json**: Configuration file for the Salesforce DX project.

This project structure encompasses various configuration files, utilities, and source code necessary for Salesforce development and CI/CD processes.

# **Setup Guide**

Please refer to [this](https://cloudkaptan.sharepoint.com/:f:/s/LearnShare2/ErEYkOJoX5ZKha-7E1WYwu0BkqlvMWgI7qSs-hJCE61Kuw?e=KFBad8) folder for the setup guide, ensuring that you use the latest version of the setup Guide. It also encompasses all the details regarding CI/CD setup and associated scripts.


