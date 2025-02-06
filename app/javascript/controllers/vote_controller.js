import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  toggle(event) {
    event.preventDefault();

    let button = event.currentTarget;
    let commentId = this.element.dataset.beanCommentId || this.element.dataset.roasteryCommentId;

    if (!commentId) {
      console.error("❌ Comment ID is missing! Check your HTML data attributes.");
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
      this.updateButton(button, data.liked);
      this.updateVotesCount(commentId, data.votes_count);
    })
    .catch(error => console.error("Error:", error));
  }

  updateButton(button, liked) {
    if (liked) {
      button.innerText = "❤️";
      button.classList.remove();
      button.classList.add();
      button.dataset.turboMethod = "delete";
    } else {
      button.innerText = "🤍";
      button.classList.remove();
      button.classList.add();
      button.dataset.turboMethod = "post";
    }
  }

  updateVotesCount(commentId, count) {
    const votesCountElement = document.getElementById(`votes-count-${commentId}`);
    if (votesCountElement) {
      votesCountElement.textContent = count;
    }
  }
}
