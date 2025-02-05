import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="voting"
export default class extends Controller {
  connect() {
    console.log("Voting controller connected")
  }

  toggle(event) {
    event.preventDefault();
    console.log("Clicked")
  }
}
