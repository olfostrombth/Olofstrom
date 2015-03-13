// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require jquery-ui
//= require autocomplete-rails

//= require jquery-ui/sortable
//= require jquery-ui/effect-highlight

//= require foundation
//= require jquery.turbolinks
//= require ckeditor/init

//= require best_in_place
//= require best_in_place.jquery-ui
//= require_tree .



$(function(){ 

	var btn = false;

	$(document).foundation(); 

	// Archivement badges show
	
	$(".arch-toggle").click(function(){
		$(".arch").slideToggle("slow");
	});
	$(".fed").click(function(){
		$(".fed-toggle").slideToggle("slow");
	});

	$(".add-mod-btn2").click(function(){
		$(".feeed").slideToggle("slow");
	});

	// MOBIL MENY JS
	$(".mobile-menu-btn").click(function(){
		if(btn){
			$(".mobile-menu-btn").animate({left: '0'}, 500);
			btn=false;
		}else{
			$(".mobile-menu-btn").animate({left: '85%'}, 500);
			btn=true
		}
        $(".sidebar").animate({width: 'toggle' }, 500);
        

    });



	//$(".fisk").click(function(){
	//	$(".sidebar").animate({left: '500px'});
		//var sideWidth = $(".sidebar").css("width");
		


});


