import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["locationsContainer"];

  connect() {
    console.log("LocationController connected!");
}

  addLocation(event) {
    event.preventDefault();

    this.locationsContainer = this.locationsContainerTarget;

    let allLocationFields = this.locationsContainer.querySelectorAll(".location-fields");
    let lastLocationFields = allLocationFields[allLocationFields.length - 1];

    const newFields = lastLocationFields.cloneNode(true);

    newFields.querySelector(".location-type").value = "";
    newFields.querySelector(".location-address").value = "";

    const index = allLocationFields.length;
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

    removeButton.setAttribute("data-action", "click->location#removeLocation");

    newFields.appendChild(removeButton);
    this.locationsContainer.appendChild(newFields);
  }

  removeLocation(event) {
    event.preventDefault();

    const locationFields = event.target.closest(".location-fields");

    const destroyField = locationFields.querySelector(".location-destroy");
    if (destroyField) {
      destroyField.value = "1";
    }

    locationFields.style.display = "none";
  }
}
