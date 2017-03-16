# dwylbot

![dwyl-heart-robot-logo](https://cloud.githubusercontent.com/assets/194400/23946011/a592b2a8-0970-11e7-83b2-29a336f9879d.png)
## "_GitHub Workflow Automation, Helpful Hints & Timely Tips_"
[![Build Status](https://travis-ci.org/dwyl/dwylbot.svg?branch=master)](https://travis-ci.org/dwyl/dwylbot)
[![codecov](https://codecov.io/gh/dwyl/dwylbot/branch/master/graph/badge.svg)](https://codecov.io/gh/dwyl/dwylbot)
[![Discuss](https://img.shields.io/badge/discuss-with%20us-brightgreen.svg?style=flat)](https://github.com/dwyl/dwylbot/issues "Discuss your ideas/suggestions with us!")


_**Automating** our **GitHub workflow** to `.reduce` the number of **clicks**
the **people** need to **perform** <br />
to get their work `done` and **help people communicate better**
with their co-workers._

## _Why_?

Learning a (_new_) Workflow is never _instantaneous_. <br />
We (_the people who already know the steps in our Workflow_)
_often_ need to _remind_ others who are new to it.

## _What_?

We use GitHub as our "single source of truth"
(_place to keep all our information
  so we don't lose anything important!_). <br />
We _also_ use GitHub to ***discuss*** ideas/features/improvements/questions,
***estimate*** the effort required to _implement_ an idea <br />
(_or "fix" an existing feature that is not working as expected_)
and then to ***track*** how much time a person spent on the task/feature.

We refer to this as our "Workflow".
The "job" of `dwylbot` is to help the humans learn & follow the Workflow.

If you have not yet read the following guides:

+ https://github.com/dwyl/github-reference
+ https://github.com/dwyl/contributing

The purpose of `dwylbot` will not be _clear_ to you.


## _How_?

This project is written in `Elixir` and uses a `Phoenix` web server
_tested_ by `Travis` and running on `Heroku`. <br />
If you are _new_ to any of these tools/technologies
you won't _understand_ some of the code
in this repo, so, please _read/learn_:

+ Elixir: https://github.com/dwyl/learn-elixir
+ Phoenix: https://github.com/dwyl/learn-phoenix-framework
+ Travis https://github.com/dwyl/learn-travis
+ Heroku: https://github.com/dwyl/heroku

> _**Note**: you don't need to be an "expert" in any of these things
to start understanding the project, but it helps to know the basics._

### Run The Project _Locally_!

The "_production_" version of `dwylbot` runs on Heroku,
but we _develop_ it locally and you can easily run it on your computer.

> _**Note**: only try to run this on your computer once
you've understood Elixir & Phoenix._

#### Clone the Repository (_to your personal computer_)

```
git clone git@github.com:dwyl/dwylbot.git && cd dwylbot
```

#### Define Local Environment Variables

> If you are new to "Environment Variables", please read:
[github.com/dwyl/**learn-environment-variables**](https://github.com/dwyl/learn-environment-variables)

To run the application on your localhost (_personal computer_)
create an `.env` file where you can define your environment variables.

`dwylbot/.env`:
```
export GITHUB_CLIENT_ID=FollowTheInstructionsToCreateAnAppOnGitHub
export GITHUB_CLIENT_SECRET=*******
export GITHUB_ACCESS_TOKEN=******
export DATABASE_URL=****
# SECRET_KEY_BASE is required for Auth Cookie:
export SECRET_KEY_BASE=MustBeA64ByteStringProbablyBestToGenerateUsingCryptoOrJustUseThisWithSomeRandomDigitsOnTheEnd1234567890
```
Then execute the command ```source .env``` which will create your environment variables

> _**Note**: This method only adds the environment variables **locally**
and **temporarily** <br />
so you need to start your server in the **same terminal**
where you ran the `source` command_.

#### Install Dependencies

```
mix deps.get && npm install
```

#### Confirm Everything is working

Run the tests:

```
mix test
```

#### Creat the Database (_if it does not already exist_)

```
mix ecto.create && mix ecto.migrate
```

#### Run the Server

```
mix phoenix.server
```
You should see:
```
[info] Running Dwylbot.Endpoint with Cowboy using http://localhost:4000
```

#### View the Project in your Web Browser

Open http://localhost:4000 in your web browser.

![dwylbot welcome](https://cloud.githubusercontent.com/assets/194400/23944236/04ae41b4-096a-11e7-986d-8bb0063fd95a.png)

Ok, so you know the Phoenix server is working.
That's nice, but what does it actually _do_...?

### _Understanding_ The Project

#### Routing

Given your Phoenix knowledge, you _know_ that the _first_ place to look
when you want to _understand_ <br />a Phoenix project is:
[`web/router.ex`](https://github.com/dwyl/dwylbot/blob/master/web/router.ex)

In this case we only have one (_interesting_) route: `/webhooks/create`


#### Tests



### Make a `cURL` Request to the `POST /webhooks/create`

Need an example GitHub Webhook request payload for this...
see: https://github.com/dwyl/dwylbot/issues/6#issuecomment-286387463

See: https://developer.github.com/webhooks/creating/
