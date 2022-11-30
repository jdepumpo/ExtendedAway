import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="task-done"
export default class extends Controller {
  connect() {
    console.log('hello');
  }

  changeDone(event) {
    console.log(event.target.checked);
  }
}
