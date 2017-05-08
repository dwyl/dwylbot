# Why

We are using Github OAuth to authenticate the user in the dwylbot application.
This allow the application to use the users Github account to create/delete webhooks on the selected repositories. This also allow dwylbot to use the users Github account to create comments on issues, this help dwylbot not being blocked by the Github API limit on the number of requests

# Implementation

It's a good idea to refresh your memory with the OAuth flow. You can read a good description on the [digitalocean tutorial](https://www.digitalocean.com/community/tutorials/an-introduction-to-oauth-2) and on the [Github web application flow section](https://developer.github.com/v3/oauth/#web-application-flow). The main flow is:
1. The user click on the authorise link (signup link)
2. The application receive an authorization code from the API service (Github)
3. The application request a token by sending back the authorization code to the API service
4. The application receive the token

We are using [ueberauth](https://github.com/ueberauth/ueberauth) and [ueberauth_github](https://github.com/ueberauth/ueberauth_github) which simplify the Implementation of the OAuth2 flow.

 Install the dependencies in mix.exs:
```
# mix.exs

defp deps do
  [{:phoenix, "~> 1.2.1"},
   ...
   {:ueberauth, "~> 0.4"},
   {:ueberauth_github, "~> 0.4.1"}
  ]
end
```

```
# mix.exs

def application do
  [mod: {Dwylbot, []},
   applications: [:phoenix, :phoenix_pubsub, :phoenix_html, :cowboy, :logger, :gettext,
                  :phoenix_ecto, :postgrex, :tentacat, :ueberauth, :ueberauth_github]]
end
```

and run ```mix deps.get``` in your terminal to downaload the packages.


# References

- github.com/jruts/playwith_phoenix
- https://www.digitalocean.com/community/tutorials/an-introduction-to-oauth-2
- https://developer.github.com/v3/oauth/#web-application-flow
- https://github.com/ueberauth/ueberauth_github
- https://github.com/ueberauth/ueberauth
