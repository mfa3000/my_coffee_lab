import { Controller } from "@hotwired/stimulus"

export default class extends Controller {

  connect() {
    console.log("Vote controller connected");
  }

  toggle(event) {
    event.preventDefault();
    console.log("Clicked");
  }

  test() {
    console.log("Test button");
  }
}
