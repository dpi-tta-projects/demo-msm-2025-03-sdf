import { Controller } from "@hotwired/stimulus"
import { Modal } from "bootstrap"

// Connects to data-controller="search--modal"
export default class extends Controller {
  static targets = ["label"]

  connect() {
    this.isMac = navigator.platform.toUpperCase().includes("MAC")
    this.updateHotkeyLabel()

    this.handleKeydown = this.handleKeydown.bind(this)
    document.addEventListener("keydown", this.handleKeydown)
  }

  disconnect() {
    document.removeEventListener("keydown", this.handleKeydown)
  }

  updateHotkeyLabel() {
    if (this.hasLabelTarget) {
      this.labelTarget.textContent = this.isMac ? "⌘K" : "Ctrl+K"
    }
  }

  handleKeydown(event) {
    const isHotkey = this.isMac
      ? event.metaKey && event.key.toLowerCase() === "k"
      : event.ctrlKey && event.key.toLowerCase() === "k"

    if (isHotkey) {
      event.preventDefault()
      this.toggleModal()
    }
  }

  toggleModal() {
    const modalElement = document.getElementById("searchModal")
    if (!modalElement) return

    const modal = Modal.getInstance(modalElement) || new Modal(modalElement)

    const isVisible = modalElement.classList.contains("show")

    if (isVisible) {
      modal.hide()
    } else {
      modal.show()
    }
  }
}
