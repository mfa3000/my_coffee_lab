import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  connect() {
    this.boundAddLocation = this.addLocation.bind(this);
    this.initializeLocationFunctionality();
  }

  initializeLocationFunctionality() {
    this.addLocationButton = document.getElementById("add-location-btn");
    this.locationsContainer = document.getElementById("locations-container");

    if (this.addLocationButton && this.locationsContainer) {

      let newButton = this.addLocationButton.cloneNode(true);
      this.addLocationButton.replaceWith(newButton);
      this.addLocationButton = document.getElementById("add-location-btn");

      this.boundAddLocation = this.addLocation.bind(this);
      this.addLocationButton.addEventListener("click", this.boundAddLocation);
    }
  }

  addLocation() {

    let allLocationFields = this.locationsContainer.querySelectorAll(".location-fields");
    let lastLocationFields = allLocationFields[allLocationFields.length - 1];

    if (!lastLocationFields) {
      lastLocationFields = document.createElement("div");
      lastLocationFields.classList.add("location-fields", "grid", "grid-cols-2", "gap-4", "mt-4");
      lastLocationFields.innerHTML = `
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
      this.locationsContainer.appendChild(lastLocationFields);
    }

    const newFields = lastLocationFields.cloneNode(true);
    newFields.querySelector(".location-type").value = "";
    newFields.querySelector(".location-address").value = "";

    const index = this.locationsContainer.querySelectorAll(".location-fields").length;

    newFields.querySelector(".location-type").setAttribute(
      "name",
      `roastery[locations_attributes][${index}][location_type]`
    );
    newFields.querySelector(".location-address").setAttribute(
      "name",
      `roastery[locations_attributes][${index}][address]`
    );

    newFields.querySelectorAll(".remove-location-btn").forEach(button => button.remove());

    const removeButton = document.createElement("button");
    removeButton.type = "button";
    removeButton.textContent = "Remove";
    removeButton.classList.add("remove-location-btn", "bg-red-500", "text-white", "px-3", "py-1", "rounded", "ml-2");

    newFields.appendChild(removeButton);
    this.locationsContainer.appendChild(newFields);

  }
}
