import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  initialize() {}
  connect() {}
  toggleForm(event) {
    console.log("Hello from toggleform");
    event.preventDefault();
    event.stopPropagation();
    const formID = event.currentTarget.dataset.commentsFormParam;
    const commentBodyID = event.currentTarget.dataset.commentsBodyParam;
    const form = document.getElementById(formID);
    form.classList.toggle("d-none");
    form.classList.toggle("mt-3");
    const commentBody = document.getElementById(commentBodyID);
    commentBody.classList.toggle("d-none");
  }
}
