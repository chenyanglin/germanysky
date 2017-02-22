$(document).ready(function() {
    $("body").fadeIn(400);


/* Home page item price animation */
$('.thumbnail').mouseenter(function() {
   $(this).children('.zoomTool').fadeIn();
});

$('.thumbnail').mouseleave(function() {
	$(this).children('.zoomTool').fadeOut();
});

// Show/Hide Sticky "Go to top" button
	$(window).scroll(function(){
		if($(this).scrollTop()>200){
			$(".gotop").fadeIn(200);
		}
		else{
			$(".gotop").fadeOut(200);
		}
	});
// Scroll Page to Top when clicked on "go to top" button
	$(".gotop").click(function(event){
		event.preventDefault();

		$.scrollTo('#gototop', 1500, {
        	easing: 'easeOutCubic'
        });
	});

});
$(document).on('click','#subscription', function () {
	email = document.getElementById("newsletter_email").value;
	if (email =="")
		{alert("請輸入郵件喔喔喔");}
	else{
    var request = "/consoles/subscription?email="+email;
    var aj = $.ajax({
        url: request,
        type: 'get',
        data: $(this).serialize(),
        dataType: 'text'
    }).done(function (data) {
     if (data="success"){
      alert( "訂閱成功");
  		}else{
  			alert("訂閱失敗");
  		}

    }).fail(function (data) {
      alert("此email已訂閱");
    });
	}
    });