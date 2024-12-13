document.addEventListener('DOMContentLoaded', () => {
  const toggleButtons = document.querySelectorAll('.button.toggle');
  toggleButtons.forEach((button) => {
    button.addEventListener('click', () => {
      button.classList.toggle('checked');
    });
  });
});
