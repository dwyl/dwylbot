# dwylbot

![dwyl-heart-robot-logo](https://cloud.githubusercontent.com/assets/194400/23946011/a592b2a8-0970-11e7-83b2-29a336f9879d.png)
## "_GitHub Workflow Automation, Helpful Hints & Timely Tips_"
[![Build Status](https://travis-ci.org/dwyl/dwylbot.svg?branch=master)](https://travis-ci.org/dwyl/dwylbot)
[![codecov](https://codecov.io/gh/dwyl/dwylbot/branch/master/graph/badge.svg)](https://codecov.io/gh/dwyl/dwylbot)
[![Discuss](https://img.shields.io/badge/discuss-with%20us-brightgreen.svg?style=flat)](https://github.com/dwyl/dwylbot/issues "Discuss your ideas/suggestions with us!")

**We are currently updating the documentation and the Readme of this project. All the open PRs will be reviewed soon. However if you have any questions or want to contribute to `dwylbot` don't hesitate to open a new issue!**

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
|               | "awaiting-review" with no assignees or reviewers                                         | :warning: @username, the pull request is in "awaiting-review" but doesn't have a reviewer or correct assignee. Please assign someone to review the pull request, thanks.                                                                                                                                                          | -                                                                                |
|               | Must have a description, [#98](https://github.com/dwyl/dwylbot/issues/98)                                                       | :stop_sign: @#{login}, the pull request has no **description!**, Please add more details to help us understand the context of the pull request, Please read our [Contribution guide](https://github.com/dwyl/contributing#notes-on-creating-good-pull-requests) on how to create a good pull request, Thanks! :heart: | -                                                                                |
|               | If a PR has a reviewer, must have "awaiting-review" label and reviewer as assignee |                                                                                                     :wave: @#{login}, you have requested a review for this pull request so we have taken the liberty of assigning the reviewers :tada:. Have a great day :sunny: and keep up the good work :computer: :clap:                                                                                                                                                                                                                | reviewer added as assignee, "awaiting-review" label added.                       |
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

You might want to run your own instance of `dwylbot` on your machine
to see how it can help you with your workflow.
You might also like to help us and add new rules to `dwylbot` (check our contribution guide: https://github.com/dwyl/contributing)!
The "_production_" version of `dwylbot` runs on Heroku,
but we _develop_ it locally and you can _easily_ run it on your computer
and tinker the code as much as you'd like.

You will need to:

- Create a new Github application.
- Run a `dwylbot` server on your machine.

You'll need to have installed [Elixir](https://elixir-lang.org/install.html), [Phoenix](https://hexdocs.pm/phoenix/installation.html), and [ngrok](https://ngrok.com/download) if you haven't already.

> _**Note**: **only** `try` to run this on your computer once
you've understood Elixir & Phoenix._

#### Create a GitHub application

The role of the Github application is to send notifications
when events occur on your repositories.
For example you can get a notification when new issues or pull requests are open.
In our case the Github application keep up to date `dwylbot` with any events happening on your repositories.

- Access the [new application settings page](https://github.com/settings/apps/new) on your Github account:
  Settings -> Developer settings -> Github Apps -> New Github App

  ![new Github app](https://user-images.githubusercontent.com/6057298/34667319-75439af0-f460-11e7-8ae5-a9f52944b364.png)


- Github App name: The name of the app; must be unique, so can't be "dwylbot" as that's taken!
- Descriptions: A short description of the app; "My dwylbot app"
- Homepage URL: The website of the app: "https://dwyl.com/"
- User authorization callback URL: Redirect url after user authentication e.g."http://localhost:4000/auth/github/callback". This is not needed for dwylbot so this field can be left empty.
- Setup URL: Redirect the user to this url after installation, not needed for `dwylbot`
- Webhook URL: URL where post requests from Github are sent to. The endpoint is ```/event/new```, however Github won't be able to send requests to ```http://localhost:4000/event/new``` as this url is only accessible by your own machine. To expose publicly your `localhost` server you can use `ngrok`. **Remember to update this value after you have a running dwylbot server on your machine!**

    Install [ngrok](https://ngrok.com). If you have homebrew, you can do this by running `brew cask install ngrok`

    Then in your terminal enter `ngrok http 4000` to generate an SSH between your localhost:4000 and ngrok.io. Copy the ngrok url that appears in your terminal to the Github app configuration; "http://bf541ce5.ngrok.io/event/new"

    > _NOTE: you will need to update the webhook URL everytime you disconnect/connect to ngrok because a different URL is generated everytime._

    You can read more about webhooks and ngrok at https://developer.github.com/webhooks/configuring/
- Define the access rights for the application on the permmission section. **Change "issues" and "pull requests" to "Read & Write"**
  ![Github App permissions](https://user-images.githubusercontent.com/6057298/34676734-beddd8b8-f485-11e7-8b5d-e899faa95ae6.png)

- Select which events ```dwylbot``` will be notified on. **Check "issues", "issue comment" and "pull request"**
  ![Github App events](https://user-images.githubusercontent.com/6057298/34676896-48ab5ade-f486-11e7-89e9-5ebe921de802.png)

  >_Check the list of rules already implemented by dwylbot to see which permissions and notifications you want to select._

- Webhook secret: This token can be used to make sure that the requests received by `dwylbot` are from Github; `dwylbot` doesn't use this token at the moment so you can keep this field empty (see https://developer.github.com/webhooks/securing/)

- You can decide to allow other users to install the Github Application or to limit the app on your account only:
  ![Github app install scope](https://user-images.githubusercontent.com/6057298/34677046-cf874e96-f486-11e7-9f60-912f3ec2809b.png)

  You can now click on "Create Github App"!

- Create a private key: This key is used to identify specific `dwylbot` installations

  ![Github App private key](https://user-images.githubusercontent.com/6057298/34678365-d9d73dd0-f48a-11e7-8d1b-cfbfa11bbcc9.png)

  The downloaded file contains the private key.
  Copy this key in your environment variables, see the next section.


You can also read the Github guide on how to create a new Github App at https://developer.github.com/apps/building-github-apps/creating-a-github-app/

#### Run a `dwylbot` server

The `dwylbot` server will receive events from Github, filter and identify this events and when necessary send actions to Github (comment on issues, change labels on issues, ...)

- Clone the repository _to your personal computer_:
  ```
  git clone git@github.com:dwyl/dwylbot.git && cd dwylbot
  ```
- Define the local environment variables:

  > If you are new to "Environment Variables", please read:
  [github.com/dwyl/**learn-environment-variables**](https://github.com/dwyl/learn-environment-variables)

  To run the application on your localhost (_personal computer_)
  create an `.env` file where you can define your environment variables.

  `dwylbot/.env`:
  ```
  export GITHUB_APP_ID=1111
  export GITHUB_APP_NAME=myGithubApp
  export PRIVATE_APP_KEY="-----BEGIN RSA PRIVATE KEY-----private key generated by Github when the Github app is created"
  # SECRET_KEY_BASE is required for Auth Cookie:
  export SECRET_KEY_BASE=MustBeA64ByteStringProbablyBestToGenerateUsingCryptoOrJustUseThisWithSomeRandomDigitsOnTheEnd1234567890
  ```
  You can find the value of ```GITHUB_APP_ID``` and ```GITHUB_APP_NAME``` in the `About` and `Basic information` sections.
  The private key is the key generated when you've crated the Gitub app.
  You can generate a new secrete key base with ```mix phoenix.gen.secret```.

  Then execute the command ```source .env``` which will create your environment variables

  > _**Note**: This method only adds the environment variables **locally**
  and **temporarily** <br />
  so you need to start your server in the **same terminal**
  where you ran the `source` command_.

- Install dependencies:

  ```
  mix deps.get && npm install
  ```

- Confirm everything is working by running the tests:

  ```
  mix test
  ```

- Create the Database (_if it does not already exist_)

  ```
  mix ecto.create && mix ecto.migrate
  ```

- Run the Server

  ```
  mix phoenix.server
  ```
  You should see:
  ```
  [info] Running Dwylbot.Endpoint with Cowboy using http://localhost:4000
  ```

- Now that your server is running you can update the `webhook url` in your app config:
  - run ```ngrok http 4000``` in a new terminal

    ![ngrok](https://user-images.githubusercontent.com/6057298/34685179-73b6d71c-f49f-11e7-8dab-abfc64c9e938.png)
  - copy and save the url into your Github App config with ```/event/new``` for endpoint

- View the Project in your Web Browser

Open http://localhost:4000 in your web browser.

![dwylbot welcome](https://user-images.githubusercontent.com/6057298/34680750-c8f33710-f491-11e7-993d-28d664473cbc.png)

From the welcome page you can now manage the installations of and select the repositories where you want `dwylbot` active on.

If you have managed to install successfully your new Github App on one of your repositories,
you can quickly test your dwylbot server by creating for example a new issue without a description.
A new `dwylbot` comment on the issue should warn you to add a description!

Ok, so you know the Phoenix server is working.
That's nice, but what does it actually _do_...?

#### Deploy on Heroku

dwylbot is automatically deploy on Heroku each time a pull request is merged on master.
If you update the version of Erlang, Elixir or Phoenix on the project,
you might also need to update the buildpack on Heroku:
![update buildpack](https://user-images.githubusercontent.com/6057298/36139754-b220a98e-1096-11e8-86dd-366f9eacac27.png)

The ```elixir_buildpack.config``` config file allow you to update the versions of Erlang and Elixir.
You can find more information about Heroku deploy here:
- https://hexdocs.pm/phoenix/heroku.html
- https://github.com/HashNuke/heroku-buildpack-elixir

### _Understanding_ The Project

#### Routing

Given your Phoenix knowledge, you _know_ that the _first_ place to look
when you want to _understand_ <br />a Phoenix project is:
[`web/router.ex`](https://github.com/dwyl/dwylbot/blob/master/web/router.ex)

In this case we only have one (_interesting_) route: `/event/new`

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
