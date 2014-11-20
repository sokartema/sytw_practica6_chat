$(document).ready(function(){
$("#entrar").click(function(){

  var data = {nickname: $('#nickname').val(), password: $('#password').val()}


$.ajax({

	url:'/chat',
	type: 'post',
  dataType: 'html',
  data: data,

	success: function(result){

		document.open();
    document.write(result);
    document.close();
	}



});


});

$("#anonimo").click(function(){


$.ajax({

  url:'/chat',
  type: 'post',
  dataType: 'html',

  success: function(result){

    document.open();
    document.write(result);
    document.close();
  }



});




});
});
