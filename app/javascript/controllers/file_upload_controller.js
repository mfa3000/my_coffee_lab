import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["input", "fileName", "preview"]

  connect() {
    this.fileNameTarget.textContent = "No file chosen";
  }

  initialize() {
    this.inputTarget.addEventListener('change', (event) => this.showFile(event));
  }

  showFile(event) {
    const file = event.target.files[0];
    if (file) {
      this.fileNameTarget.textContent = file.name;

      // Show preview if it's an image
      if (file.type.startsWith("image/")) {
        const reader = new FileReader();
        reader.onload = (e) => {
          this.previewTarget.innerHTML = `<img src="${e.target.result}" class="preview-image"/>`;
        };
        reader.readAsDataURL(file);
      }
    }
  }
}
