# redmine_gitlab_omniauth
request omniauth from redmine to gitlab as provider.  

## usage 
install this plugin to your redmine, and set gitlab info

1. clone this repository to your redmine plugin folder
2. restart redmine
3. fill gitlab info in plugin congiguration page

now, you can see gitlab auth button in login page.  
this create user record when you login with gitlab auth as new redmine user.

## testing
```bash
bundle exec rake redmine:plugins:test
```

see rake task for details
