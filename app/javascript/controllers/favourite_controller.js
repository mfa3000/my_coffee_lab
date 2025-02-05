import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  toggle(event) {
    event.preventDefault();

    let button = event.currentTarget;
    let icon = button.querySelector("i.fa-heart");

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
        icon.classList.add("text-danger");
        button.dataset.turboMethod = "delete";
      } else {
        icon.classList.remove("text-danger");
        button.dataset.turboMethod = "post";
      }
      let countElement = document.querySelector(`#favourites-count-${elementId}`);
      if (countElement) {
        countElement.textContent = data.favourites_count;
      }

    })
    .catch(error => console.error("❌ Erreur :", error))
  }
}
