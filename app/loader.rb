require 'bundler/setup'
require 'pry'
require 'delegate'
require 'rack'
require 'codebreaker'
require 'erb'
require 'haml'
require 'yaml'

require_relative './helpers/session_helper'

require_relative './models/stats'
require_relative './models/database'
require_relative './models/web_game'
require_relative './models/router'

require_relative './controller/base_controller'
require_relative './controller/app_controller'

require_relative './middleware/auth_middleware'
require_relative './codebreaker_rack'
