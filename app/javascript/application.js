// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "popper"
import "bootstrap"
import "queue_items"

document.addEventListener('turbo:load', function() {
  const toastMessage = document.querySelector('.toast');
  if (toastMessage) {
    const toast = new bootstrap.Toast(toastMessage);
    toast.show();
  }
});

if ('serviceWorker' in navigator) {
  window.addEventListener('load', () => {
    navigator.serviceWorker.register('/service-worker.js')
      .then((registration) => {
        console.log('Service Worker registered:', registration);
      })
      .catch((error) => {
        console.log('Service Worker registration failed:', error);
      });
  });
}