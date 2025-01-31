import { Controller } from "@hotwired/stimulus";

// Connects to data-controller="vote"
export default class extends Controller {
  static targets = ["upvote", "downvote", "score"]; // Defines the upvote, downvote, and score elements as targets

  async toggle(event) {
    event.preventDefault(); // Prevents the default link behavior (avoids full-page reload)

    let button = event.currentTarget; // Gets the button that was clicked
    let url = button.getAttribute("href"); // Retrieves the API endpoint URL from the button
    let method = button.dataset.turboMethod || button.getAttribute("data-method"); // Gets the HTTP method (PATCH)

    try {
      // Sends an HTTP request to the server to process the vote
      const response = await fetch(url, {
        method: method.toUpperCase(), // Ensures the method is uppercase (PATCH)
        headers: {
          "X-CSRF-Token": document.querySelector("[name='csrf-token']").content, // Adds CSRF token for security
          "Accept": "application/json" // Tells the server we expect a JSON response
        }
      });

      if (!response.ok) throw new Error("Network response was not ok"); // Throws an error if the request fails

      const data = await response.json(); // Parses the JSON response from the server
      this.updateUI(data); // Calls the function to update the UI based on the server response
    } catch (error) {
      console.error("Error:", error); // Logs any errors to the console
    }
  }

  updateUI(data) {
    if (this.hasScoreTarget) {
      this.scoreTarget.innerText = data.score; // Updates the displayed vote count
    }

    if (this.hasUpvoteTarget && this.hasDownvoteTarget) {
      if (data.voted === "upvote") {
        this.upvoteTarget.innerText = "⬆️"; // Shows an active upvote
        this.downvoteTarget.innerText = "⬇️"; // Shows default downvote
      } else if (data.voted === "downvote") {
        this.upvoteTarget.innerText = "⬆️"; // Shows default upvote
        this.downvoteTarget.innerText = "⬇️"; // Shows an active downvote
      } else {
        this.upvoteTarget.innerText = "⬆️"; // Default state: both buttons are arrows
        this.downvoteTarget.innerText = "⬇️";
      }
    }
  }
}
