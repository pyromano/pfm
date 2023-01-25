import { Controller } from "@hotwired/stimulus"
import { get } from "@rails/request.js"

export default class extends Controller {
  change(event) {
    let dir_id = event.target.selectedOptions[0].value
    get(`/categories/${dir_id}/money_flow`, {
      responseKind: "turbo-stream"
    })
  }
}
