window.addEventListener('DOMContentLoaded', ()=>{
  const button = document.getElementById('js');
  const outerFrame = document.getElementById('outer-frame');
  const modal = document.getElementById('modal');
  const close = document.getElementsByClassName('close');

    button.addEventListener("click", function() {
      outerFrame.style.display = 'block';
    });

    for(let i=0; i<close.length; i++){ 
      close[i].addEventListener('click', function() {
        outerFrame.style.display = 'none';
      });
    }

    outerFrame.addEventListener('click', function(e) {
      outerFrame.style.display = 'none';
    });

    modal.addEventListener('click', function(e) {
      event.stopPropagation()
    });
});
