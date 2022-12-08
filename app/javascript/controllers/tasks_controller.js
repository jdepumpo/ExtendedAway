import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="controller"
export default class extends Controller {

  static targets = ["card"]

  showTrip(event) {
    const selectedCard = event.currentTarget

    this.cardTargets.forEach(card => {
      if (card === selectedCard) {
        card.classList.add("active")
     }
      else {
        card.classList.remove("active")
      }
    });
  }
}
