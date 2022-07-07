require_relative './app/loader'

use Rack::Reloader
use Rack::Session::Cookie, key: 'rack.session',
                           path: '/',
                           expire_after: Constants::ONE_MONTH,
                           secret: 'change_me',
                           old_secret: 'also_change_me'
use Rack::Static, urls: ['/assets'], root: 'public'
use Middleware::AuthMiddleware

run CodebreakerRack
