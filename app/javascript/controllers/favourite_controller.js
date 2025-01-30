import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  toggle(event) {
    event.preventDefault();

    let button = event.currentTarget;

    let elementId = this.element.dataset.beanId || this.element.dataset.roasteryId;

    if (!elementId) {
      console.error("❌ Element ID is missing! Check show.html.erb for bean_id or roastery_id.");
      return;
    }

    let url = button.getAttribute("href");
    let method = button.dataset.turboMethod || button.getAttribute("data-method");

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
