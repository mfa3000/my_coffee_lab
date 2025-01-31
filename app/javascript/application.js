// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"
import "@popperjs/core"
import "bootstrap"


import { application } from "./controllers/application"
import FavouriteController from "controllers/favourite_controller";

application.register("favourite", FavouriteController);
