#!/bin/bash

#
# run powershell tests from bash for powershell core on linux or mac
# use the results to update the readme.md
#
clear
echo "Executing unit tests..."
pwsh ./run-tests.ps1 >test-results.txt
echo "Updating Readme..."
pwsh ./update-readme.ps1
echo "Complete!"