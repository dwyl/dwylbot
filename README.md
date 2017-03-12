# dwylbot

[![Build Status](https://travis-ci.org/dwyl/dwylbot.svg?branch=master)](https://travis-ci.org/dwyl/dwylbot)
[![codecov](https://codecov.io/gh/dwyl/dwylbot/branch/master/graph/badge.svg)](https://codecov.io/gh/dwyl/dwylbot)
[![Join the chat at https://gitter.im/dwyl/dwylbot](https://badges.gitter.im/dwyl/dwylbot.svg)](https://gitter.im/dwyl/dwylbot?utm_source=badge&utm_medium=badge&utm_campaign=pr-badge&utm_content=badge)

Automating our processes

# Run it

## Define your environment variables

To run the application on localhost you can create a .env file where you can define your environment variables

.env:
```
export GITHUB_ACCESS_TOKEN=******
export DATABASE_URL=****
```
Then execute the command ```source .env``` which will create your environment variables
**This method only add localy and temporarly the environment variables so you need to start your server on the same terminal where you runned the source command**
