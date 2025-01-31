import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  connect() {
    this.initializeRoasterySearch();
  }

  initializeRoasterySearch() {
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
}
