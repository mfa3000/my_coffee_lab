import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  connect() {

    this.type = this.element.dataset.ratingType;
    this.itemId = this.element.dataset.ratingId;
    this.userRating = parseInt(this.element.dataset.ratingUserRating, 10) || 0;
    this.stars = Array.from(this.element.querySelectorAll(".star"));
    this.message = this.element.querySelector(".rating-message");
    this.averageRatingDisplay = document.getElementById(`average-rating-${this.itemId}`);

    this.bindEvents();
    this.updateStarUI();
  }

  bindEvents() {
    this.stars.forEach(star => {
      star.addEventListener("click", (event) => this.submitRating(event));
    });
  }

  async submitRating(event) {
    const rating = parseInt(event.currentTarget.dataset.ratingValue, 10);
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
      console.error("❌ Error submitting rating:", error);
      this.message.textContent = "Failed to submit rating.";
    }
  }

  updateStarUI() {

    this.element.setAttribute("data-rating-user-rating", this.userRating);

    this.stars.forEach(star => {
      const starValue = parseInt(star.dataset.ratingValue, 10);

      if (starValue <= this.userRating) {
        star.style.color = "#333D29";
      } else {
        star.style.color = "#F4F4F4";
      }

    });

  }
}
