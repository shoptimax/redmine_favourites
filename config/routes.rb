# Plugin's routes
# See: http://guides.rubyonrails.org/routing.html

get 'like', :to => 'like#like'
get 'unlike', :to => 'like#unlike'
post 'like', :to => 'like#like'
post 'unlike', :to => 'like#unlike'
