import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="gods"
export default class extends Controller {
  static targets = ["mythology"]

  update() {
    const mythologyId = this.mythologyTarget.value
    fetch(`/stories/update_gods?mythology_id=${mythologyId}`, {
      headers: {
        Accept: "text/vnd.turbo-stream.html"
      }
    })
    .then(response => response.text())
    .then(html => Turbo.renderStreamMessage(html))
  }
}
