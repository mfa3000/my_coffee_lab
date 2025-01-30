import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  connect() {
    this.roasteryId = this.element.dataset.ratingRoasteryId;
    this.userRating = parseInt(this.element.dataset.ratingUserRating, 10) || 0;
    this.stars = this.element.querySelectorAll(".star");
    this.message = document.getElementById("rating-message");

    this.updateStarUI();
  }

  async submitRating(event) {
    const rating = event.target.dataset.ratingValue;

    try {
      const response = await fetch(`/roasteries/${this.roasteryId}/roastery_reviews`, {
        method: "POST",
        headers: {
          "X-CSRF-Token": document.querySelector("meta[name='csrf-token']").content,
          "Content-Type": "application/json",
          "Accept": "application/json"
        },
        body: JSON.stringify({ roastery_review: { rating: rating } })
      });

      const data = await response.json();
      if (data.success) {
        this.userRating = rating;
        this.updateStarUI();
        this.message.textContent = "Rating saved!";
        this.message.classList.remove("hidden");
        document.getElementById("average-rating").textContent = data.average_rating;
      } else {
        this.message.textContent = "Error saving rating.";
      }
    } catch (error) {
      console.error("Error submitting rating:", error);
      this.message.textContent = "Failed to submit rating.";
    }
  }

  updateStarUI() {
    this.stars.forEach(star => {
      const starValue = parseInt(star.dataset.ratingValue, 10);
      if (starValue <= this.userRating) {
        star.classList.add("text-yellow-500");
      } else {
        star.classList.remove("text-yellow-500");
      }
    });
  }
}
