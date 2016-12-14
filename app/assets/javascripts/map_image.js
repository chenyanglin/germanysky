
//---admin assign map
$(document).on('click','#map_assign', function () {
    // localStorage.setItem("map_show", 1);
    // window.location.reload();
    if ($('#admin_account_select').val() == "")
      alert('請選擇帳號!');
    else{
    update_map_owner();
    alert('指派完成!');
    }
});

  function update_map_owner(){
    var position_id = $('#position_select').val();
    var account_id = $('#admin_account_select').val();
    var request = "/maps/assign_map_to_account";

      var aj = $.ajax({
          async: false,
          url: request,
          type: 'post',
          data:{
             position_id: position_id,
             account_id: account_id
           },
          dataType: 'json'
        }).success(function (data) {
          window.location.reload();
        }).fail(function (data) {
             console.log('AJAX request has FAILED');
        });
  };
//---assign_onload

function reload_beacons() {
  var request = "/javascripts/refresh_beacons"; //access controller of interest
  var d = new Date();
  var n = d.getTime();
  var aj = $.ajax({
        url: request,
        type: 'get',
        update_time: $(this).serialize(),
        dataType: 'json'
    }).success(function (update_time) {
        if (update_time == 1){
          //window.location.href = "http://localhost:3000/beacons";
          window.location.reload();
          //alert(update_time);
        }
    }).fail(function (update_time) {
         console.log('AJAX request has FAILED');
    });
};

$(document).on('click','#show_uuid', function () {
    localStorage.setItem("map_show", 1);
    window.location.reload();
});
$(document).on('click','#hide_uuid', function () {
    localStorage.setItem("map_show", 0);
    window.location.reload();
});
//---選擇區域
$(document).on('change','#area_select', function () {
    area_to_county();
});
function area_to_county() { 
    var area_id = $('#area_select').val();
    var request = "/maps/county_get?area_id="+ area_id;
    var aj = $.ajax({
        url: request,
        type: 'get',
        data: $(this).serialize(),
        dataType: 'json'
    }).done(function (data) {
         change_county_select(data);
    }).fail(function (data) {
         console.log('AJAX request has FAILED');
    });
};
function change_county_select(data) { 
    $("#county_select").empty();//remove all previous majors
    if(data.length != 0){
        for(i = 0;i<data.length;i++){ 
            $("#county_select").append(//add in an option for each major
                $("<option></option>").attr("value", data[i].id).text(data[i].county_name)
        );}
    }
    county_to_position();
};
//---

//---選擇縣市
$(document).on('change','#county_select', function () {
    county_to_position();
});

function county_to_position() { 
    var county_id = $('#county_select').val();
    var request = "/positions/position_get?county_id="+ county_id;
    var aj = $.ajax({
        url: request,
        type: 'get',
        data: $(this).serialize(),
        dataType: 'json'
    }).done(function (data) {
         change_position_select(data);
    }).fail(function (data) {
         console.log('AJAX request has FAILED');
    });
};
function change_position_select(data) { 
    $("#position_select").empty();//remove all previous majors
    if(data.length != 0){
        for(i = 0;i<data.length;i++){ 
          var request = "/maps/get_map_size?position_id="+ data[i].id;
          $.get(request, function(data) {
            $("#position_select").append(//add in an option for each major
                $("<option></option>").attr("value", data.text_id).text(data.text_name+"  （平面圖總數:"+data.mapsize+"）")
        );
          });
                    

        //   var aj = $.ajax({
        //     url: request,
        //     type: 'get',
        //     data2: $(this).serialize(),
        //     dataType: 'json'
        //   }).done(function (data2) {
        //     console.log('123'+data2);
        //     $("#position_select").append(//add in an option for each major
        //         $("<option></option>").attr("value", data[i].id).text(data[i].position_name+'123')
        // );
        //   }).fail(function (data2) {
        //     console.log('AJAX request has FAILED');
        //     $("#position_select").append(//add in an option for each major
        //         $("<option></option>").attr("value", data[i].id).text(data[i].position_name)
        // );
        // });
        //     $("#position_select").append(//add in an option for each major
        //         $("<option></option>").attr("value", data[i].id).text(data[i].position_name)
        // );

          }
    }
    // position_to_map();
    // position_to_assign_map();
};
//---

//---選擇位置
$(document).on('change','#position_select', function () {
    position_to_map();
    position_to_assign_map();
});

function position_to_map() { 
    var position_id = $('#position_select').val();
    var request = "/maps/map_get?position_id="+ position_id;
    var aj = $.ajax({
        url: request,
        type: 'get',
        data: $(this).serialize()
    }).success(function (data) {
         // alert('qq');
    }).fail(function (data) {
         console.log('AJAX request has FAILED');
    });
};

//---assigned maps pop out
function position_to_assign_map() { 
    var position_id = $('#position_select').val();
    var request = "/maps/assigned_map_get?position_id="+ position_id;
    var aj = $.ajax({
        url: request,
        type: 'get',
        data: $(this).serialize()
    }).success(function (data) {
         // alert('qq');
    }).fail(function (data) {
         console.log('AJAX request has FAILED');
    });
};
// function change_maps(data) { 
//     $("#position_select").empty();//remove all previous majors
//     if(data.length != 0){
//         for(i = 0;i<data.length;i++){ 
//             $("#position_select").append(//add in an option for each major
//                 $("<option></option>").attr("value", data[i].id).text(data[i].position_name)
//         );}
//     }
// };