// Manage toggle effect on .toggle buttons
console.log('common.js loaded');

document.addEventListener('DOMContentLoaded', () => {
  const toggleButtons = document.querySelectorAll('.button.toggle');
  console.log(toggleButtons);

  toggleButtons.forEach((button) => {
    console.log(button);

    button.addEventListener('click', () => {
      console.log('click');

      button.classList.toggle('active');
    });
  });
});
