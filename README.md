# Ledger EOS (Integration Repo)

[![CircleCI](https://circleci.com/gh/ZondaX/ledger-eos.svg?style=svg)](https://circleci.com/gh/ZondaX/ledger-eos) [![License](https://img.shields.io/badge/License-Apache%202.0-blue.svg)](https://opensource.org/licenses/Apache-2.0)

This project wraps the Ledger Nano S app for EOS and provides continuous integration via CircleCI.

An artifact (zip) containing a compiled app will be created for each commit.

**WARNING: Remember to use this ONLY in a ledger without funds and only for testing purposes.**

## Installing

### Getting the package

Click in the following link

https://circleci.com/api/v1.1/project/github/eosnewyork/ledger-eos/latest/artifacts

This will return something similar to:

```json
[ {
  "path" : "root/project/pkgapp.zip",
  "pretty_path" : "root/project/pkgapp.zip",
  "node_index" : 0,
  "url" : "https://15-173824944-gh.circle-artifacts.com/0/root/project/pkgapp.zip"
} ]
```

Download the zip file from the URL you get back.

### Running the script

1. Unzip the file
2. You will find a bash script called `loadapp.sh`
3. Connect your ledger and enter the password
4. Run the script
   - Because the app is a development build and it has not been signed by ledger, it will tell you that the app is not trusted
   - NEVER INSTALL THIS APP IN A LEDGER WITH FUNDS. USE A TEST LEDGER FOR DEVELOPMENT PURPOSES 
   - accept and install

**The app will be named EosDemo with version 0.0.0. This is intentional**
