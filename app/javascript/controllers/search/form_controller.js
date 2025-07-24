import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="search--form"
class FormController extends Controller {
  // which inputs are we connecting?
  static targets = ["input", "form"]

  connect() {
    this.timer = null
  }

  fetchResults() {
    clearTimeout(this.timer)
    
    this.timer = setTimeout(async () => {
      const url = new URL(this.formTarget.action)
      const formData = new FormData(this.formTarget)
      
      // Append form data to URL (GET request)
      url.search = new URLSearchParams(formData)
      
      console.log(`now searching: ${url.search}`);

      try {
        const response = await fetch(url, {
          method: "GET",
          headers: {
            "X-Requested-With": "XMLHttpRequest",
            "Accept": "text/javascript"
          }
        });

        if (!response.ok) throw new Error("Network response was not ok")

        const js = await response.text();
        eval(js);
      } catch (error) {
        console.error("Fetch error:", error)
      }
    }, 300) // Debounce time
  }
}

export default FormController;
