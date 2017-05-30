# Plugin's routes
# See: http://guides.rubyonrails.org/routing.html

get '/auth/gitlab/callback', to: 'redmine_gitlab_omniauth#callback'
get '/auth/gitlab/failure', to: 'redmine_gitlab_omniauth#failure'
