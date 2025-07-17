import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="search"
export default class extends Controller {
  // which inputs are we connecting?
  static targets = ["input", "form"]

  connect() {
    this.timer = null
  }

  fetchResults() {
    clearTimeout(this.timer)
    
    this.timer = setTimeout(() => {
      const url = new URL(this.formTarget.action)
      const formData = new FormData(this.formTarget)
      
      // Append form data to URL (GET request)
      url.search = new URLSearchParams(formData)
      
      console.log(`now searching: ${url.search}`);
      fetch(url, {
        method: "GET",
        headers: {
          "X-Requested-With": "XMLHttpRequest",
          "Accept": "text/javascript"
        }
      }).then(response => {
          if (!response.ok) throw new Error("Network response was not ok")
          return response.text()
        }).then(js => {
          eval(js) // Executes your index.js.erb
        }).catch(error => {
          console.error("Fetch error:", error)
        })
    }, 300) // Debounce time
  }
}
