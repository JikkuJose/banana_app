# Banana App

Web app to learn Facebook login for web apps.


## Instructions

* Create a Facebook app using their [developer portal](developer_portal).
* Clone project and `cd` into the project directory
* Run `rake setup`
* Populate the generated `.env` using data from the created Facebook app.
* Choose a domain name (like) 'bapp.local' and point it to `127.0.0.0` in `/etc/hosts`
* List the same domain in settings of the Facebook app created.
* Run `bundle exec shotgun`
* View the app in browser via the URL: `http://bapp.local:9393/`

[developer_portal]: https://developers.facebook.com/apps/

## Prerequisites

Ruby version higher than 2.0.0
