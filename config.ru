require './config/environment'

use Rack::MethodOverride
use CategoriesController
use CausesController
use UsersController
run ApplicationController