// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"
import "@popperjs/core"
import "bootstrap"

import { application } from "./controllers/application";

document.addEventListener("DOMContentLoaded", function () {
  const addLocationButton = document.getElementById("add-location-btn");
  const locationsContainer = document.getElementById("locations-container");

  if (addLocationButton && locationsContainer) {
    addLocationButton.addEventListener("click", function () {

      const firstLocationFields = locationsContainer.querySelector(".location-fields");
      if (!firstLocationFields) return;

      const newFields = firstLocationFields.cloneNode(true);

      newFields.querySelector(".location-type").value = "";
      newFields.querySelector(".location-address").value = "";

      const index = locationsContainer.children.length;

      newFields.querySelector(".location-type").setAttribute(
        "name",
        `roastery[locations_attributes][${index}][location_type]`
      );
      newFields.querySelector(".location-address").setAttribute(
        "name",
        `roastery[locations_attributes][${index}][address]`
      );

      locationsContainer.appendChild(newFields);
    });
  }
});
