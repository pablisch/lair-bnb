const logo = document.querySelector(".flair");
const title = document.querySelector(".logo");
const nav = document.querySelector(".nav");
const body = document.querySelector(".body");
const secret = document.querySelector(".secret");
const black_ring = document.querySelector(".black_ring");
const red_ring = document.querySelector(".red_ring");
const yellow_ring = document.querySelector(".yellow_ring");
const panels = document.querySelector(".panels");
const spaces = document.querySelector(".space");
const dates = document.querySelector(".date_picker");


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
  secret.style.color = '#ffc400';
  secret.style.transition = 'color 7s ease';
  black_ring.style.opacity = '1';
  black_ring.style.transition = 'opacity 3s ease';
  red_ring.style.opacity = '1';
  red_ring.style.transition = 'opacity 6s ease';
  yellow_ring.style.opacity = '1';
  yellow_ring.style.transition = 'opacity 9s ease';
  nav.style.background = '#000';
  nav.style.transition = 'background 10s ease';
  body.style.background = '#0b0b0b';
  body.style.transition = 'background 7s ease';
  panels.style.opacity = '0';
  panels.style.transition = 'opacity 3s ease';
  spaces.style.opacity = '0';
  spaces.style.transition = 'opacity 3s ease';
  dates.style.opacity = '0';
  dates.style.transition = 'opacity 3s ease';
}

// APPLY full opacity
function opaque() {
  title.style.opacity = '1';
  title.style.transition = 'opacity 2s ease';
  secret.style.color = '#f5f4f4';
  secret.style.transition = 'color 1s ease';
  black_ring.style.opacity = '0';
  black_ring.style.transition = 'opacity 9s ease';
  red_ring.style.opacity = '0';
  red_ring.style.transition = 'opacity 16s ease';
  yellow_ring.style.opacity = '0';
  yellow_ring.style.transition = 'opacity 12s ease';
  nav.style.background = '#fff';
  nav.style.transition = 'background 3s ease';
  body.style.background = '#f5f4f4';
  body.style.transition = 'background 10s ease';
  panels.style.opacity = '1';
  panels.style.transition = 'opacity 2s ease';
  spaces.style.opacity = '0.5';
  spaces.style.transition = 'opacity 10s ease';
  dates.style.opacity = '1';
  dates.style.transition = 'opacity 2s ease';
}

