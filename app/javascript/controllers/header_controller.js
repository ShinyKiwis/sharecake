import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["modal"]

  toggle() {
    const modalTargetDisplay = this.modalTarget.style.display || "none"
    console.log(modalTargetDisplay)
    if(modalTargetDisplay === "none") {
      this.modalTarget.style.display = "block"
    }else{
      this.modalTarget.style.display = "none"
    }
  }
}