$(document).ready(function(){
$("#entrar").click(function(){

  var nickname = {'nickname': $('#nickname').val()}


$.ajax({

	url:'/chat',
	type: 'post',
  dataType: 'html',
  data: nickname,

	success: function(result){

		$("#intro").html(result);
	}



});


});

$("#anonimo").click(function(){


$.ajax({

  url:'/chat',
  type: 'post',
  dataType: 'html',

  success: function(result){

    $("#intro").html(result);
  }



});




});
});
