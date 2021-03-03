require_relative './app/loader'

use Rack::Reloader
use Rack::Static, urls: ['/assets'], root: 'public'
# use Rack::Static, urls: ['/node_modules'], root: './'
use Rack::Session::Cookie, #key: 'rack.session',
                           path: '/',
                           expire_after: 2592000 #,
                           #secret: 'change_me',
                           #old_secret: 'also_change_me'

run Middlewares::Racker