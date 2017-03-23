# dwylbot

![dwyl-heart-robot-logo](https://cloud.githubusercontent.com/assets/194400/23946011/a592b2a8-0970-11e7-83b2-29a336f9879d.png)
## "_GitHub Workflow Automation, Helpful Hints & Timely Tips_"
[![Build Status](https://travis-ci.org/dwyl/dwylbot.svg?branch=master)](https://travis-ci.org/dwyl/dwylbot)
[![codecov](https://codecov.io/gh/dwyl/dwylbot/branch/master/graph/badge.svg)](https://codecov.io/gh/dwyl/dwylbot)
[![Discuss](https://img.shields.io/badge/discuss-with%20us-brightgreen.svg?style=flat)](https://github.com/dwyl/dwylbot/issues "Discuss your ideas/suggestions with us!")

_**Automating** our **GitHub workflow** to `.reduce` the number of **clicks**
the **people** need to **perform** <br />
to get their work `done` and **help everyone communicate better**
with team members_. <br />

## _Prerequisite to Understanding `dwylbot`_

The purpose of `dwylbot` will remain _unclear_
if you have not read the following:

+ [github.com/dwyl/**github-reference**](https://github.com/dwyl/github-reference)
+ [github.com/dwyl/**contributing**](https://github.com/dwyl/contributing)

Please read them and come back!


## _Why_?

dwyl's Workflow is
a **_carefully crafted_ sequence of steps**
designed to ensure everyone in the team
can communicate and see the status of work.<br />

Learning the Workflow is never _instantaneous_.
At the start of a project the more _experienced_ people in the team
end up having to do a bit of "_workflow mentoring_". e.g: <br />

> "_You missed a step in the workflow which means
the team is unaware of state/progress on this feature..._" <br />
> "_Please remember to refer to the GitHub issue
in your commit messages so it is clear what each commit is for._" <br />
> "_Please apply the `awaiting-review` label
when you want someone to review your work..._" <br />
> "_Please only assign a Pull Request for review
once all the tests have passed on CI..._" <br />
> For a **list** of these common scenarios see:
https://github.com/dwyl/dwylbot/issues/5

`dwylbot` ***automates*** giving "***workflow related feedback***"
which ***saves everyone time***!


## _What_?

We use GitHub as our
["_single source of truth_"](https://en.wikipedia.org/wiki/Single_source_of_truth)
(_one place to keep all our information
  so we don't lose anything important!_). <br />
We _also_ use GitHub to ***discuss*** questions/ideas/features/improvements,
***estimate*** the effort required to _implement_ an idea <br />
(_or "fix" an existing feature that is not working as expected_)
and then to ***track*** the ***progress*** while the work is being done and
***record*** how much ***time*** a person spent on the task/feature.
We refer to this as our "Workflow".

`dwylbot` helps the humans learn & follow the Workflow
so we ***communicate better*** and ***get more done***!

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
but we _develop_ it locally and you can _easily_ run it on your computer.

> _**Note**: **only** `try` to run this on your computer once
you've understood Elixir & Phoenix._

#### Clone the Repository

Clone the GitHub repo _to your personal computer_:

```
git clone git@github.com:dwyl/dwylbot.git && cd dwylbot
```

#### Create an Application on GitHub

If you don't already have a GitHub application with valid
keys you can use to run this project on your localhost,
please follow these instructions:
https://github.com/dwyl/hapi-auth-github/blob/master/GITHUB-APP-STEP-BY-STEP-GUIDE.md

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


#### Tests!


### Make a `cURL` Request to the `POST /webhooks/create`

Need an example GitHub Webhook request payload for this...
see: https://github.com/dwyl/dwylbot/issues/6#issuecomment-286387463

See: https://developer.github.com/webhooks/creating/


## tl;dr


on the team knows _exactly_ what is going on
at all times without having to _ask_.

With our GitHub-based Workflow,
we _successfully_ avoid the need for "***project status update meetings***":
![status updates](https://cloud.githubusercontent.com/assets/194400/24032230/cc734b34-0ade-11e7-9a02-33aa0c832085.png)


Anyone who has _never_ worked in a "_really_ big" company where
people have [_meetings about having meetings_](https://www.google.co.uk/search?q=meetings+about+meetings&tbm=isch)
<br />
Can feel like
"_there are **too many steps** to **get work done**..._".<br />
To those people we say: "_you have **Three Options**:_"
1. Get a job at a "_Fortune 500 Company_"
(_that has been around for 30+ years and claims to be "agile"_) <br />
 `.then` come back chat about getting work done in teams;
 _We will give you a shoulder to cry on! <br />
 we promise not to say "**I told you so**"
 when you tell us we were "**so right**"..._
2. Get a job in a small company
(_fewer than 10 people all co-located in the same office_)
where no "_process_" is required because they "_just get stuff done!_"
Stay with that company long enough to _feel_ the "_growing pains_" of
_not_ having a clearly defined workflow. <br />
`.then` try to _retrospectively_ apply a workflow and teach your colleagues
how to cooperate effectively.
3. _Trust_ those of us who _have_ ***felt the pain*** of working in (_multiple_)
horribly complex companies and have _crafted_ a Workflow that ensures
the highest level of team communication/productivity.


Organizations _regularly_ approach us
to teach dwyl's Workflow to their team(s).
We have done many workshops to that end. <br />
Sadly, delivering in-person training does not scale.
So we decided to _automate_ our Workflow with `dwylbot`.
