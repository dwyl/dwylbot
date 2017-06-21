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

We've devised a set of rules and actions to respond to these problems, they look like this:

| Category      | Rule                                                                               | dwylbot comments                                                                                                                                                                                                                                                                                                      | Labels changed                                                                   |
|---------------|------------------------------------------------------------------------------------|-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|----------------------------------------------------------------------------------|
| Pull Requests | "awaiting-review" and a merge conflict, [#64](https://github.com/dwyl/dwylbot/issues/64)                                        | :warning: @username, the pull request has a **merge conflict**., Please resolve the conflict and reassign when ready :+1:, Thanks!                                                                                                                                                                                    | remove "awaiting-review" and replace with "merge-conflicts". @username assigned. |
|               | "awaiting-review" with no assignees                                                | :warning: @username, the pull request is in "awaiting-review" but doesn't have a correct assignee. Please assign someone to review the pull request, thanks.                                                                                                                                                          | -                                                                                |
|               | Must have a description, [#98](https://github.com/dwyl/dwylbot/issues/98)                                                       | :stop_sign: @#{login}, the pull request has no **description!**, Please add more details to help us understand the context of the pull request, Please read our [Contribution guide](https://github.com/dwyl/contributing#notes-on-creating-good-pull-requests) on how to create a good pull request, Thanks! :heart: | -                                                                                |
|               | If a PR has a reviewer, must have "awaiting-review" label and reviewer as assignee | -                                                                                                                                                                                                                                                                                                                     | reviewer added as assignee, "awaiting-review" label added.                       |
|               |                                                                                    |                                                                                                                                                                                                                                                                                                                       |                                                                                  |
| Issues        | Must have a description, [#76](https://github.com/dwyl/dwylbot/issues/76)                                                       | :warning: @username, this issue has no description. Please add a description to help others understand the context of this issue.                                                                                                                                                                                     | -                                                                                |
|               | "in-progress" label with no assignee, [#7](https://github.com/dwyl/dwylbot/issues/7)                                           | @username the `in-progress` label has been added to this issue **without an Assignee**. dwylbot has automatically assigned you.                                                                                                                                                                                       | @username assigned to issue.                                                     |
|               | "in progress" label with assignee removed, [#71](https://github.com/dwyl/dwylbot/issues/71)                                     | :warning: @username the assignee for this issue has been removed with the `in-progress` label still attached. Please remove the `in-progress` label if this issue is no longer being worked on or assign a user to this issue if it is still in progress.                                                             | -                                                                                |
|               | "in-progress" label with no time estimate, [#61](https://github.com/dwyl/dwylbot/issues/61)                                     | @username the `in-progress` label has been added to this issue **without a time estimation**. Please add a time estimation to this issue before applying the `in-progress` label.                                                                                                                                     | -                                                                                |

> For a **list** of rules we're still implementing check out:
https://github.com/dwyl/dwylbot/issues/5

`dwylbot` ***automates*** giving "***workflow related feedback***"
which ***saves everyone time***!


## _What_?

We use GitHub as our
["_single source of truth_"](https://en.wikipedia.org/wiki/Single_source_of_truth)
(_one place to keep all our information
  so we don't lose anything important!_). <br />
We _also_ use GitHub to ***discuss*** questions/ideas/features/improvements,
***estimate*** the effort required to _implement_ an idea (_or "fix" an existing feature that is not working as expected_) and then to ***track*** the ***progress*** while the work is being done and
***record*** how much ***time*** a person spent on the task/feature.<br />
We refer to this as our "workflow".

`dwylbot` helps the humans learn & follow the workflow
so we ***communicate better*** and ***get more done***!

## _Install_

To install and manage _dwylbot_ on your repositories:

- visit the _[dwylbot home page](https://dwylbot.herokuapp.com/)_ or you can directly access the _dwylbot_ installation page: https://github.com/apps/dwylbot
- click on "Manage dwylbot installations". This will open the _dwylbot_ github app page.
  ![configure-dwylbot](https://user-images.githubusercontent.com/6057298/27295764-fadffbb2-5515-11e7-85fb-dc267e462c15.png)

- click ```configure``` to select the organisations where you want dwylbot to operate
  ![configure-orgs](https://user-images.githubusercontent.com/6057298/27295790-0e296884-5516-11e7-9840-6e41c153e67c.png)

- you can install _dwylbot_ on all the repositories of the organisation or you can select specific repositories
  ![select-repos](https://user-images.githubusercontent.com/6057298/27295823-2971c898-5516-11e7-88e0-6e37e7acd5ba.png)

- click ```install```. _dwylbot_ is now installed :tada: Just use Github as normal and _dwylbot_ will help enhance your team's workflow.



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

#### Create a GitHub Application

If you don't already have a GitHub application with valid
keys you can use to run this project on your localhost,
please follow these instructions: https://developer.github.com/apps

#### Define Local Environment Variables

> If you are new to "Environment Variables", please read:
[github.com/dwyl/**learn-environment-variables**](https://github.com/dwyl/learn-environment-variables)

To run the application on your localhost (_personal computer_)
create an `.env` file where you can define your environment variables.

`dwylbot/.env`:
```
export GITHUB_CLIENT_ID=FollowTheInstructionsToCreateAnAppOnGitHub
export GITHUB_CLIENT_SECRET=*******
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

In this case we only have one (_interesting_) route: `/event/new`


#### Tests!


### Make a `cURL` Request to the `POST /event/new`

Need an example GitHub Webhook request payload for this...
see: https://github.com/dwyl/dwylbot/issues/6#issuecomment-286387463

See: https://developer.github.com/webhooks/creating/


## tl;dr


on the team no one knows _exactly_ what is going on
at all times without having to _ask_.

With our GitHub-based Workflow,
we _successfully_ avoid the need for "***project status update meetings***":
![status updates](https://cloud.githubusercontent.com/assets/194400/24032230/cc734b34-0ade-11e7-9a02-33aa0c832085.png)


For anyone who has _never_ worked in a "_really_ big" company where
people have [_meetings about having meetings_](https://www.google.co.uk/search?q=meetings+about+meetings&tbm=isch) and it
can feel like "_there are **too many steps** to **get work done**..._".<br />
To those people we say: "_you have **three options**:_"
1. Get a job at a "_Fortune 500 Company_"
(_that has been around for 30+ years and claims to be "agile"_) <br />
 `.then` come back chat about getting work done in teams;
 _we will give you a shoulder to cry on! <br />
 We promise not to say "**I told you so**"
 when you tell us we were "**so right**"..._
2. Get a job in a small company
(_fewer than 10 people all co-located in the same office_)
where no "_process_" is required because they "_just get stuff done!_"
Stay with that company long enough to _feel_ the "_growing pains_" of
_not_ having a clearly defined workflow. <br />
`.then` try to _retrospectively_ apply a workflow and teach your colleagues
how to cooperate effectively.
3. _Trust_ those of us who _have_ ***felt the pain*** of working in (_multiple_)
horribly complex companies and have _crafted_ a workflow that ensures
the highest level of team communication/productivity.


Organizations _regularly_ approach us
to teach dwyl's workflow to their team(s).
We have done many workshops to that end. <br />
Sadly, delivering in-person training does not scale.
So we decided to _automate_ our workflow with `dwylbot`.
