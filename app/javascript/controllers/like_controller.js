import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["icon", "count"];
  static values = { id: Number, beanId: Number, liked: Boolean };

  async toggle(event) {
    event.preventDefault();

    const method = this.likedValue ? "DELETE" : "POST";
    const response = await fetch(`/beans/${this.beanIdValue}/bean_comment_votes?bean_comment_id=${this.idValue}`, {
      method: method,
      headers: {
        "X-CSRF-Token": document.querySelector("meta[name='csrf-token']").content,
        "Accept": "application/json"
      }
    });

    if (response.ok) {
      const data = await response.json();
      this.likedValue = data.liked;
      this.iconTarget.textContent = data.liked ? "❤️" : "🤍";
      this.countTarget.textContent = data.count;
    }
  }
}
