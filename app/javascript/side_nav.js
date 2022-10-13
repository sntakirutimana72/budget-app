window.addEventListener('DOMContentLoaded', () => {
  document.body.querySelector('.options-btn').addEventListener('click', function() {
    this.querySelector('.side-nav').classList.toggle('hidden')
  })
})
