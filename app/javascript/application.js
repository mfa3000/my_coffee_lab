// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"
import "@popperjs/core"
import "bootstrap"

import { application } from "./controllers/application"

document.addEventListener("turbo:load", function () {
  initializeLocationFunctionality();
  initializeRoasterySearch();
});

// Location Fields
function initializeLocationFunctionality() {
  const addLocationButton = document.getElementById("add-location-btn");
  const locationsContainer = document.getElementById("locations-container");

  if (addLocationButton && locationsContainer) {
    addLocationButton.addEventListener("click", function () {
      let firstLocationFields = locationsContainer.querySelector(".location-fields");

      if (!firstLocationFields) {
        firstLocationFields = document.createElement("div");
        firstLocationFields.classList.add("location-fields", "grid", "grid-cols-2", "gap-4", "mt-4");
        firstLocationFields.innerHTML = `
          <div>
            <label>Location Type *</label>
            <select name="roastery[locations_attributes][0][location_type]" class="form-input location-type">
              <option value="">Select a Type</option>
              <option value="Cafe">Cafe</option>
              <option value="Roastery and Cafe">Roastery and Cafe</option>
              <option value="Warehouse">Warehouse</option>
            </select>
          </div>
          <div>
            <label>Address *</label>
            <input type="text" name="roastery[locations_attributes][0][address]" class="form-input location-address" required>
          </div>
        `;
        locationsContainer.appendChild(firstLocationFields);
      }

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

      const destroyInput = newFields.querySelector(".location-destroy");
      if (destroyInput) {
        destroyInput.value = "0";
      }

      newFields.querySelectorAll(".remove-location-btn").forEach(button => button.remove());

      const removeButton = document.createElement("button");
      removeButton.type = "button";
      removeButton.textContent = "Remove";
      removeButton.classList.add("remove-location-btn", "bg-red-500", "text-white", "px-3", "py-1", "rounded", "ml-2");

      newFields.appendChild(removeButton);
      locationsContainer.appendChild(newFields);
    });
  }

  document.addEventListener("click", function (event) {
    if (event.target.classList.contains("remove-location-btn")) {
      event.preventDefault();
      const locationField = event.target.closest(".location-fields");

      if (locationField) {
        const destroyInput = locationField.querySelector(".location-destroy");
        if (destroyInput) {
          destroyInput.value = "1";
        }
        locationField.style.display = "none";
      }
    }
  });
}

// Roastery Search
function initializeRoasterySearch() {
  const searchInput = document.getElementById("roastery-search");
  const dropdown = document.getElementById("roastery-dropdown");

  if (searchInput && dropdown) {
    searchInput.addEventListener("input", function () {
      const query = searchInput.value;

      dropdown.innerHTML = "";

      if (query.trim() === "") return;

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
}
