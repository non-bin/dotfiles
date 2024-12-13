document.addEventListener('DOMContentLoaded', () => {
  const toggleButtons = document.querySelectorAll('.button.toggle');
  toggleButtons.forEach((button) => {
    button.addEventListener('mouseDown', () => {
      button.classList.toggle('checked');
    });
  });
});
