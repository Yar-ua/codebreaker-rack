require_relative './app/racker'

use Rack::Reloader
use Rack::Static, urls: ['/assets'], root: 'public'
# use Rack::Session::Cookie, key: 'rack.session',
#                            domain: 'foo.com',
#                            path: '/',
#                            expire_after: 2592000,
#                            secret: 'change_me',
#                            old_secret: 'also_change_me'

run Middlewares::Racker