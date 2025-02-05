import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  toggle(event) {
    event.preventDefault();

    let button = event.currentTarget;
    let icon = button.querySelector("i.fa-heart");
    let isHeart = icon !=null;

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
      let newMethod = data.favorited ? "delete" : "post";
      button.dataset.turboMethod = newMethod;
      button.setAttribute("data-turbo-method", newMethod);
      button.setAttribute("href", `/beans/${elementId}/favourite_bean`);

      if (isHeart) {
        icon.classList.toggle("text-danger", data.favorited);
        icon.classList.toggle("text-secondary", !data.favorited);
      } else {
        button.innerText = data.favorited ? "Unfavourite" : "Favourite";
        button.classList.toggle("btn-primary", !data.favorited);
        button.classList.toggle("btn-danger", data.favorited);
      }

      let countElement = document.querySelector(`#favourites-count-${elementId}`);
      if (countElement) {
        countElement.textContent = data.favourites_count;
      }
    })
    .catch(error => console.error("❌ Error:", error));
  }
}
