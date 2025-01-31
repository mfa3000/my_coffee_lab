// Import and register all your controllers from the importmap via controllers/**/*_controller
import { application } from "./application";
import { eagerLoadControllersFrom } from "@hotwired/stimulus-loading";
import FavouriteController from "controllers/favourite_controller";
import LocationController from "./location_controller";
import RoasterySearchController from "./roastery_search_controller";

eagerLoadControllersFrom("controllers", application);
