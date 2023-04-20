const logo = document.querySelector(".logo");

// Listen for logo mouseover - set opacity low
logo.addEventListener('mouseover', logoHoverOn => {
  fade();
})

// Listen for logo mouseOUT - set full opacity
logo.addEventListener('mouseout', logoHoverOFF => {
  opaque();
})

// APPLY low opacity
function fade() {
  logo.style.opacity = '0.2';
  logo.style.transition = 'opacity 3s ease';
}

// APPLY full opacity
function opaque() {
  logo.style.opacity = '1';
  logo.style.transition = 'opacity 2s ease';
}