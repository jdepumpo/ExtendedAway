import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="controller"
export default class extends Controller {

  connect() {
    const option = document.getElementById('option');
    options.addEventListener('click', () => {
      option.add("active");
    });
  }
}
