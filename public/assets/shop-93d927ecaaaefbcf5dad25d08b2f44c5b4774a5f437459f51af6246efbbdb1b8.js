$(document).ready(function(){$("body").fadeIn(400),$(".thumbnail").mouseenter(function(){$(this).children(".zoomTool").fadeIn()}),$(".thumbnail").mouseleave(function(){$(this).children(".zoomTool").fadeOut()}),$(window).scroll(function(){$(this).scrollTop()>200?$(".gotop").fadeIn(200):$(".gotop").fadeOut(200)}),$(".gotop").click(function(o){o.preventDefault(),$.scrollTo("#gototop",1500,{easing:"easeOutCubic"})})});