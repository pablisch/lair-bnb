const logo = document.querySelector(".flair");
const title = document.querySelector(".logo");
const secret = document.querySelector(".secret");

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
  title.style.opacity = '0.1';
  title.style.transition = 'opacity 3s ease';
  secret.style.color = '#58be36';
  secret.style.transition = 'color 10s ease';
}

// APPLY full opacity
function opaque() {
  title.style.opacity = '1';
  title.style.transition = 'opacity 2s ease';
  secret.style.color = '#f5f4f4';
  secret.style.transition = 'color 1s ease';
}