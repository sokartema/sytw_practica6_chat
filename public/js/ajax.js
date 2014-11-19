$(document).ready(function(){
$("#entrar").click(function(){

  var data = {nickname: $('#nickname').val(), password: $('#password').val()}


$.ajax({

	url:'/chat',
	type: 'post',
  dataType: 'html',
  data: data,

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
