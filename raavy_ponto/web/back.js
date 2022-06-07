//$(".container").hide();

window.addEventListener("message", function (event) {
  var job = false;
  var service

  if (event.data.mostre != undefined) {
    let states = event.data.mostre;

    if (states) {
      $(".container").show();
    } else {
      $(".container").hide();
    }
    if (states.hide) {
      sendData("fechar2", "fechar2");
    }
  }
  //console.log(job);

  $(".entra").click(function () {
    job = true;
    $.post("http://raavy_ponto/changejob", JSON.stringify({ teste: job }));
  });
  $(".sair").click(function () {
    job = false;
    $.post("http://raavy_ponto/changejob", JSON.stringify({ teste: job }));
  });

  $(".name").text(event.data.nome);
  $(".sobrenome").text(""+event.data.sobrenome);

  service = event.data.testee

  if(service){
    $('.srv').text("Em Serviço");
  }if(service == false){
    $('.srv').text("Fora de Serviço");
  }

});

document.onkeyup = function (data) {
  if (data.which == 27) {
    console.log("vc clicou esc");
    if ($(".container").fadeIn()) {
      sendData("fechar2", "fechar2");
      $.post("http://raavy_ponto/state", JSON.stringify({ page: false }));
      $(".container").hide();
    }
  }
};

function sendData(name, data) {
  $.post(
    "http://raavy_ponto/changejob" + name,
    JSON.stringify(data),
    function (datab) {
      if (datab != "ok") {
        console.log(datab);
      }
    }
  );
}
