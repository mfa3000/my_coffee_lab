 // Import and register all your controllers from the importmap via controllers/**/*_controller
import { application } from "controllers/application";
import { eagerLoadControllersFrom } from "@hotwired/stimulus-loading";

eagerLoadControllersFrom("controllers", application);

// filters + search

document.addEventListener("DOMContentLoaded", function() {
  const toggleButton = document.getElementById("toggle-filters");
  const filterOptions = document.getElementById("filter-options");
  const resetFiltersLink = document.getElementById("reset-filters");
  const filterFields = document.querySelectorAll('.filter-options select');
  const searchInput = document.querySelector(".search-input");

  if (filterOptions) {
    filterOptions.style.display = "none"; // Masquer au départ pour éviter un état incohérent
  }

  if (toggleButton && filterOptions) {
    toggleButton.addEventListener("click", function() {
      const currentDisplay = window.getComputedStyle(filterOptions).display;
      filterOptions.style.display = currentDisplay === "none" ? "block" : "none";
    });
  }

  filterFields.forEach(function(field) {
    field.addEventListener("change", function() {
      resetFiltersLink.style.display = 'inline-block';
    });
  });

  if (resetFiltersLink) {
    resetFiltersLink.addEventListener('click', function(event) {
      event.preventDefault();

      filterFields.forEach(function(field) {
        field.value = '';
      });

      resetFiltersLink.style.display = 'none';
      filterOptions.style.display = "block";
    });
  }

  if (searchInput) {
    searchInput.addEventListener('input', function() {
      if (searchInput.value === '') {
        resetFiltersLink.style.display = 'none';
        filterFields.forEach(function(field) {
          field.value = '';
        });
      }
    });
  }
});
