const comparaisonInfos = document.querySelector('#comparaison-infos')
const btnDifferentInfos = document.querySelector('#different-infos')
const btnSameInfo = document.querySelector('#same-infos')
const differentInfosDiv = document.querySelector('#different-infos-div')
const sameInfosDiv = document.querySelector('#same-infos-div')
const btnVerifSiret = document.querySelector('.btn-verifsiret')

function hideAllInfosDiv(){
  comparaisonInfos.classList.add("d-none")
}

function displayDifferentInfosDiv(){
  differentInfosDiv.classList.remove("d-none")
  differentInfosDiv.scrollIntoView()
  sameInfosDiv.classList.add("d-none")
}

function displaySameInfosDiv() {
  sameInfosDiv.classList.remove("d-none")
  sameInfosDiv.scrollIntoView()
  differentInfosDiv.classList.add("d-none")
}

btnDifferentInfos.addEventListener('click', displayDifferentInfosDiv)
btnSameInfo.addEventListener('click', displaySameInfosDiv)
// btnVerifSiret.addEventListener('click', hideAllInfosDiv)

const content = document.querySelector(".card_grey p")
.innerHTML == ""