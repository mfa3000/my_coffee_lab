import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  connect() {
    this.type = this.element.dataset.ratingType; // "roastery" or "bean"
    this.itemId = this.element.dataset.ratingId;
    this.userRating = parseInt(this.element.dataset.ratingUserRating, 10) || 0;
    this.stars = this.element.querySelectorAll(".star");
    this.message = this.element.querySelector(".rating-message");
    this.averageRatingDisplay = document.getElementById(`average-rating-${this.itemId}`);

    this.updateStarUI();
  }

  async submitRating(event) {
    const rating = event.target.dataset.ratingValue;
    const url = this.type === "roastery"
      ? `/roasteries/${this.itemId}/roastery_reviews`
      : `/beans/${this.itemId}/bean_reviews`;

    try {
      const response = await fetch(url, {
        method: "POST",
        headers: {
          "X-CSRF-Token": document.querySelector("meta[name='csrf-token']").content,
          "Content-Type": "application/json",
          "Accept": "application/json"
        },
        body: JSON.stringify({ [`${this.type}_review`]: { rating: rating } })
      });

      const data = await response.json();
      if (data.success) {
        this.userRating = rating;
        this.updateStarUI();
        this.message.textContent = "Rating saved!";
        this.message.classList.remove("hidden");
        if (this.averageRatingDisplay) {
          this.averageRatingDisplay.textContent = data.average_rating;
        }
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
