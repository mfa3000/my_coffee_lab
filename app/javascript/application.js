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

document.addEventListener("DOMContentLoaded", function () {
  const searchInput = document.getElementById("roastery-search");
  const dropdown = document.getElementById("roastery-dropdown");

  if (searchInput && dropdown) {
    searchInput.addEventListener("input", function () {
      const query = searchInput.value;

      dropdown.innerHTML = "";

      // If the search is empty, do nothing
      if (query.trim() === "") return;

      // Send an AJAX request to the server
      fetch(`/roasteries/search?query=${encodeURIComponent(query)}`, {
        headers: { Accept: "application/json" },
      })
        .then((response) => response.json())
        .then((roasteries) => {
          roasteries.forEach((roastery) => {
            const option = document.createElement("option");
            option.value = roastery.id;
            option.textContent = roastery.name;
            dropdown.appendChild(option);
          });
        })
        .catch((error) => {
          console.error("Error fetching roasteries:", error);
        });
    });
  }
});
