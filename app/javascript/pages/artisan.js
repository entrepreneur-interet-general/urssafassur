const btnDifferentInfos = document.querySelector('#different-infos');
const btnSameInfo = document.querySelector('#same-infos');
const differentInfosDiv = document.querySelector('#different-infos-div');

function displayDifferentInfosDiv(event){
  differentInfosDiv.classList.remove("d-none")
  differentInfosDiv.scrollIntoView();
}

function hideDifferentInfosDiv(event){
  differentInfosDiv.classList.add("d-none");
}

btnDifferentInfos.addEventListener('click', displayDifferentInfosDiv);
btnSameInfo.addEventListener('click', hideDifferentInfosDiv);
