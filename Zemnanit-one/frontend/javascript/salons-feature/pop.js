document.addEventListener('DOMContentLoaded', function() {
    var openFormButton = document.getElementById('openForm');
    var closeFormButton = document.getElementById('closeForm');
    var overlay = document.querySelector('.overlay');
  
    openFormButton.addEventListener('click', function() {
      overlay.style.display = 'block';
    });
  
    closeFormButton.addEventListener('click', function() {
      overlay.style.display = 'none';
    });
  });