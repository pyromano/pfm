import { Controller } from "@hotwired/stimulus"
import flatpickr from "flatpickr";

export default class extends Controller {
  static targets = ["picker"]
  static values = {mode: String}

  initialize() {
    flatpickr(this.pickerTarget, {
      "mode": this.modeValue,
    });
  }
}
