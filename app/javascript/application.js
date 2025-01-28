// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"
import "@popperjs/core"
import "bootstrap"

document.addEventListener("DOMContentLoaded", function () {
  const addLocationButton = document.getElementById("add_location");
  if (addLocationButton) {
    addLocationButton.addEventListener("click", function () {
      const locationsDiv = document.getElementById("locations");
      const lastLocationFields = locationsDiv.lastElementChild;

      const newFields = lastLocationFields.cloneNode(true);

      newFields.querySelectorAll("input").forEach((input) => {
        input.value = "";
      });

      newFields.querySelectorAll("select").forEach((select) => {
        select.value = "";
      });

      locationsDiv.appendChild(newFields);
    });
  }
});
