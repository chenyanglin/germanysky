//---admin assign beacon
$(document).on('click','#beacon_assign', function () {
    // localStorage.setItem("map_show", 1);
    // window.location.reload();
    update_beacon_owner();
    alert('修改完成!');
});

  function update_beacon_owner(){
    var position_id = $('#position_select').val();
    var major = $('#beacon_major').val();
    var minor_s = $('#beacon_minor_s').val();
    var minor_e = $('#beacon_minor_e').val();
    var account_id = $('#admin_account_select').val();
    var request = "/beacons/assign_beacon_to_account";

      var aj = $.ajax({
          url: request,
          type: 'post',
          data:{
             position_id: position_id,
             major: major,
             minor_s: minor_s,
             minor_e: minor_e,
             account_id: account_id
           },
          dataType: 'json'
        }).success(function (data) {
        }).fail(function (data) {
             console.log('AJAX request has FAILED');
        });
  };

//--- beacon new/edit
$(document).on('change','#brand_select', function () {
    brand_to_major();
});
function brand_to_major() {
    var brand_id = $('#brand_select').val();
    var request = "/brands/major_get?brand_id="+ brand_id;
    var aj = $.ajax({
        url: request,
        type: 'get',
        data: $(this).serialize(),
        dataType: 'json'
    }).done(function (data) {
         change_major(data);
    }).fail(function (data) {
         console.log('AJAX request has FAILED');
    });
};
function change_major(data) {
  // alert(data);
    if(data.length != 0){
        $('#beacon_major').val(data.major);
        document.getElementById("beacon_major").readOnly = true;
        // $('#beacon_major').readonly = false;
    }
    if (data == '0') {
        document.getElementById("beacon_major").readOnly = false;
    }
};

//--- beacon search
$(document).on('click','#beacon_search', function () {
    beacon_search();
});

function beacon_search(){
	var category_id = $('#index_category_select').val();
    var locate_id = $('#index_locate_select').val();
    var brand_id = $('#index_brand_select').val();
    var account_id = $('#index_account_select').val();
    var power = $('#index_beacon_power').val();
    var request = "/beacons/beacons_search?category_id=" + category_id +
    '&locate_id=' + locate_id +
    '&brand_id=' + brand_id +
    '&account_id=' + account_id +
    '&power=' + power;
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
