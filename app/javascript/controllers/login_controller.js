import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect() {
    const signUpButton = document.getElementById('signUp');
    const signInButton = document.getElementById('signIn');
    const login_container = document.getElementById('login_container');
    const signInForm = document.querySelector('.sign-in-container');
    const signInMessage = document.getElementById("signInMessage");
    const signUpMessage = document.getElementById("signUpMessage");


    signUpButton.addEventListener('click', () => {
      login_container.classList.add("right-panel-active");
      signInForm.classList.add("d-none");
      signUpMessage.classList.add("d-none");
      signInMessage.classList.remove("d-none");
    });

    signInButton.addEventListener('click', () => {
      login_container.classList.remove("right-panel-active");
      signInForm.classList.remove("d-none");
      signInMessage.classList.add("d-none");
      signUpMessage.classList.remove("d-none");
    });
  }

}
