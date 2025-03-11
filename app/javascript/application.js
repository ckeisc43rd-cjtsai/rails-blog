// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
//import "@hotwired/turbo-rails"
//import Rails from "@rails/ujs";
//import "controllers"

function copyCode(button) {
  // Find the code block within the same container
  const codeBlock = button.parentElement.querySelector('.highlight');
  const text = codeBlock.innerText;
  navigator.clipboard.writeText(text).then(() => {
    // Give user feedback: change button text to "Copied!" then revert after 2 seconds
    button.textContent = "Copied!";
    setTimeout(() => {
      button.textContent = "Copy";
    }, 2000);
  }).catch(err => {
    console.error('Failed to copy: ', err);
  });
}

// Expose the function to the window (if needed)
window.copyCode = copyCode;

window.myFunction = function() {
  console.log("myFunction was called!");
};
//Rails.start();
