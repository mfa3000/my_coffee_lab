import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["icon", "count"]
  static values = { id: Number, beanId: Number, voted: Boolean }

  toggle(event) {
    event.preventDefault();
console.log("Clicked")
    const commentId = this.idValue;
    const beanId = this.beanIdValue;
    const voted = this.votedValue;
    let button = event.currentTarget;
    let url = button.getAttribute("href");
    console.log(url)
    let method = button.dataset.turboMethod || button.getAttribute("data-method");
    const body = voted ? null : JSON.stringify({ vote: true });

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
      this.votedValue = !voted;
      this.iconTarget.textContent = voted ? "🤍" : "❤️";
      this.countTarget.textContent = data.votes_count;
    })
    .catch(error => console.error("Error:", error));
  }
}
