import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  toggle(event) {
    event.preventDefault();

    let button = event.currentTarget;
    let roasteryId = this.element.dataset.roasteryId;
    let url = button.getAttribute("href");
    let method = button.dataset.turboMethod || button.getAttribute("data-method");

    if (!roasteryId) {
      console.error("❌ Roastery ID is missing! Check show.html.erb.");
      return;
    }

    fetch(url, {
      method: method.toUpperCase(),
      headers: {
        "X-CSRF-Token": document.querySelector("[name='csrf-token']").content,
        "Accept": "application/json"
      }
    })
    .then(response => {
      if (!response.ok) throw new Error("Network response was not ok");
      return response.json();
    })
    .then(data => {
      if (data.favorited) {
        button.innerText = "Unfavourite";
        button.classList.remove("btn-primary");
        button.classList.add("btn-danger");
        button.dataset.turboMethod = "delete";
      } else {
        button.innerText = "Favourite";
        button.classList.remove("btn-danger");
        button.classList.add("btn-primary");
        button.dataset.turboMethod = "post";
      }
    })
    .catch(error => console.error("Error:", error));
  }
}
