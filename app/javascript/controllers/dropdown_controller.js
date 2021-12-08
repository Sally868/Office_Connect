// Visit The Stimulus Handbook for more details
// https://stimulusjs.org/handbook/introduction

// This example controller works with specially annotated HTML like:

import { Controller } from 'stimulus'

export default class extends Controller {
  static targets = ['menu', 'button']
  static values = { open: Boolean }

  connect() {
    console.log('dropdown controller')
    this.hide()
  }

  toggle() {
    this.openValue ? this.hide() : this.show()
  }

  show() {
    this.menuTarget.classList.remove("hidden")
    this.openValue = true
  }

  hide() {
    this.menuTarget.classList.add("hidden")
    this.openValue = false
  }
}
