//---task - locate_id dropdown select

/*$(document).on('change','#task_locate_id_dropdown', function () {//change majors when user changes school
   var request = "/javascripts/task_id_to_maps?task_id=" //access controller of interest
        + $('#task_id').text();
    var aj = $.ajax({
        url: request,
        type: 'get',
        data: $(this).serialize()
    }).success(function (data) {
         task_change_maps(data);//modify the majors' dropdown
    }).fail(function (data) {
         console.log('AJAX request has FAILED');
    });
    
});
function task_change_maps(data) { 
    $("#task_map_id_dropdown").empty();//remove all previous majors
    if(data.length > 0){
	    for(i = 0; i<data.length; i++){ 
	        $("#task_map_id_dropdown").append(//add in an option for each major
	            $("<option></option>").attr("id", data[i].id).text(data[i].title)
	        );
	    }
	}
};*/

$(document).on('change','#task_locate_id_dropdown', function () {
    task_locate_id_to_beacons();
});
function task_locate_id_to_beacons() { 
    var task_id = $('#task_locate_id_dropdown').val();
    var request = "/javascripts/locate_id_to_beacons?locate_id="+ task_id;
    var aj = $.ajax({
        url: request,
        type: 'get',
        data: $(this).serialize()
    }).done(function (data) {
         task_change_beacons(data);//modify the majors' dropdown
         //refresh_assigned_beacons(task_id);
    }).fail(function (data) {
         console.log('AJAX request has FAILED');
    });
};
function task_change_beacons(data) { 
    $("#task_beacon_uuid_dropdown").empty();//remove all previous majors
    if(data.length != 0){
        for(i = 0;i<data.length;i++){ 
            $("#task_beacon_uuid_dropdown").append(//add in an option for each major
                $("<option></option>").attr("value", data[i].beacon_uuid).text(data[i].brand_name+' - '+data[i].beacon_uuid)
            );
        }
        $("#task_beacons").show();
    }
    else{
        $("#task_beacons").hide();
    }
};
function task_locate_id_to_assigned_beacons(task_id) {
   var request = "/javascripts/refresh_assigned_maps?task_id=" + task_id;

    var aj = $.ajax({
        async: false,
        url: request,
        type: 'get',
        data: $(this).serialize(),
        dataType: 'json'
    }).success(function (data) {
        $("#items_grid").html("<%= escape_javascript(render partial: 'tasks/partial/partial_assigned_maps', locals: { :taskmaps: @taskmaps } ) %>");
        //refresh_assigned_beacons(task_id)
    }).fail(function (data) {
         console.log('AJAX request has FAILED');
    });
    
};
function refresh_assigned_beacons(task_id) {
   var request = "/javascripts/refresh_assigned_beacons?task_id=" + task_id;

    var aj = $.ajax({
        async: false,
        url: request,
        type: 'get',
        data: $(this).serialize(),
        dataType: 'json'
    }).success(function (data) {
        $("#partial_assigned_beacons").html("<%= escape_javascript(render partial: 'tasks/partial/refresh_assigned_beacons', locals: { :taskmaps: @taskmaps } ) %>");
        //refresh_assigned_beacons(task_id)
    }).fail(function (data) {
         console.log('AJAX request has FAILED');
    });
    
};


//---task - brand_id dropdown select

$(document).on('change','#task_brand_id_dropdown', function () {//change majors when user changes school
   var request = "/javascripts/brand_id_to_beacons?brand_id=" //access controller of interest
        + $('#task_brand_id_dropdown').val() + '&locate_id=' + $('#task_locate_id_dropdown').val();

    var aj = $.ajax({
        url: request,
        type: 'get',
        data: $(this).serialize()
    }).done(function (data) {
         task_change_beacons(data);//modify the majors' dropdown
    }).fail(function (data) {
         console.log('AJAX request has FAILED');
    });
});
