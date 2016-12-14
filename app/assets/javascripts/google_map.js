//---new

function beacon_get(position_id){
    //var position_id = $('#position_id').text();
    var request = "/maps/google_map_beacon_get?position_id=" + position_id;
    //var locate_id = $('#locate_id').text();
    var aj = $.ajax({
      // async: false,
      url: request,
      type: 'get',
      beacons: $(this).serialize(),
      dataType: 'json'
    }).success(function (beacons) {
      beacon_insert(beacons);
    }).fail(function (beacons) {
         console.log('AJAX request has FAILED');
    });
  };
  function beacon_insert(beacons){
    markers.length = 0;
    // alert(beacons.length);
    for(var i=0;i<beacons.length;i++){
      var marker = new google.maps.Marker({
        position: beacons[i],
        map: map
      });
      uuid = '<div id="infowindow">'+ beacons[i].uuid + '</div>';
      var infowindow = new google.maps.InfoWindow({
          content: uuid
        });
      infowindow.open(map, marker);
    };
  };

//---old
function bearingsort(a,b) {
      return (a.bearing - b.bearing);
    }

function location_get(){
    var locate_id = $('#locate_id').text();
    var request = "/locates/location_get?locate_id=" + locate_id;

    var aj = $.ajax({
      async: false,
      url: request,
      type: 'get',
      locations: $(this).serialize(),
      dataType: 'json'
    }).success(function (locations) {
      location_insert(locations);
    }).fail(function (locations) {
         console.log('AJAX request has FAILED');
    });
  };
  function location_insert(locations){
    location_point.length = 0;
    for(var i=0;i<locations.length;i++){
      // location_point.push(locations[i]);
      location_point.push(new google.maps.LatLng(locations[i].lat, locations[i].lng));
      // alert(location_point[i]);
      // new google.maps.LatLng(location_point[i].lat, location_point[i].lng)
    };
  };

  function Ini_location_get(){
    var locate_id = $('#locate_id').text();
    var request = "/locates/location_get?locate_id=" + locate_id;
    var aj = $.ajax({
      async: false,
      url: request,
      type: 'get',
      locations: $(this).serialize(),
      dataType: 'json'
    }).success(function (locations) {
      Ini_location_insert(locations);
    }).fail(function (locations) {
         console.log('AJAX request has FAILED');
    });
  };
  function Ini_location_insert(locations){
    for(var i=0;i<locations.length;i++){
      Ini_addMarker(locations[i]);
    }
  };

  function Ini_addMarker(location) {
      var path = poly.getPath();
      path.push(location);
      var marker = new google.maps.Marker({
        position: location,
        lat: location.lat,
        lng: location.lng,
        title: '#' + path.getLength(),
        map: map,
        draggable: true
      });
      markers.push(marker);

      google.maps.event.addListener(marker, 'click', function() {
        marker.setMap(null);
        for (var i = 0, I = markers.length; i < I && markers[i] != marker; ++i);
          markers.splice(i, 1);
          path.removeAt(i);
        }
      );

      google.maps.event.addListener(marker, 'dragend', function() {
        for (var i = 0, I = markers.length; i < I && markers[i] != marker; ++i);
          path.setAt(i, marker.getPosition());
        }
      );
    }


  $(document).on('click','#locate_save', function () {
      //alert('qq');
      location_add();
  });
  function location_add(){
    var locate_id = $('#locate_id').text();
    var request = "/locates/location_del?locate_id=" + locate_id;

    var aj = $.ajax({
      async: false,
      url: request,
      type: 'get',
      dataType: 'json'
    }).success(function (beacondata) {
      async: true;
    }).fail(function (beacondata) {
         console.log('AJAX request has FAILED');
    });

    request = "/locates/location_save";
    for (var i = 0; i < markers.length; i++) {
      var aj = $.ajax({
          url: request,
          type: 'post',
          data:{
             locate_id: locate_id,
             longitude: markers[i].lng,
             latitude: markers[i].lat
           },
          dataType: 'json'
        }).success(function (beacondata) {
        }).fail(function (beacondata) {
             console.log('AJAX request has FAILED');
        });
    }
  };

    function addMarker_point(location) {

      var marker = new google.maps.Marker({
        position: location,
        map: map
        // draggable: true
      });
      // markers.push(marker);
    }

    // Adds a marker to the map and push to the array.
    function addMarker(location) {
      var path = poly.getPath();
      path.push(location);
      var marker = new google.maps.Marker({
        position: location,
        lat: location.lat(),
        lng: location.lng(),
        // title: '#' + path.getLength(),
        map: map,
        draggable: true
      });
      markers.push(marker);

      var bound = new google.maps.LatLngBounds();
        for (i = 0; i < markers.length; i++) {
          bound.extend(markers[i]);
        }
        var center = bound.getCenter();
        map.setCenter(center);

      google.maps.event.addListener(marker, 'click', function() {
        marker.setMap(null);
        for (var i = 0, I = markers.length; i < I && markers[i] != marker; ++i);
          markers.splice(i, 1);
          path.removeAt(i);
        }
      );

      google.maps.event.addListener(marker, 'dragend', function() {
        for (var i = 0, I = markers.length; i < I && markers[i] != marker; ++i);
          path.setAt(i, marker.getPosition());
        }
      );
    }

    // Sets the map on all markers in the array.
    function setMapOnAll(map) {
      for (var i = 0; i < markers.length; i++) {
        markers[i].setMap(map);
      }
    }

    // Removes the markers from the map, but keeps them in the array.
    function clearMarkers() {
      setMapOnAll(null);
    }

    // Shows any markers currently in the array.
    function showMarkers() {
      setMapOnAll(map);
    }

    // Deletes all markers in the array by removing references to them.
    function deleteMarkers() {
      clearMarkers();
      markers = [];
    }

    function geocodeAddress(geocoder, resultsMap) {
      var address = document.getElementById('address').value;
      geocoder.geocode({'address': address}, function(results, status) {
        if (status === google.maps.GeocoderStatus.OK) {
          resultsMap.setCenter(results[0].geometry.location);

          clearMarkers();
          //markers = [];
          // addMarker(results[0].geometry.location)
          // markers.push(marker);
        } else {
          alert('Geocode was not successful for the following reason: ' + status);
        }
      });
    }

    function getAddress(geocoder,latLng) {
      geocoder.geocode( {'latLng': latLng}, function(results, status) {
        if(status === google.maps.GeocoderStatus.OK) {
          if(results[0]) {
            document.getElementById('address').value = results[0].formatted_address;
            $('#message').text("請確認地圖上位置是否正確！");
            $('#message').css("color", "black");
          }
          else {
            document.getElementById('address').value = "No results";
          }
        }
        else {
          document.getElementById('address').value = '';//status;
          $('#message').text("無法取得此處地址，請重新點選！");
          $('#message').css("color", "red");
        }
      });
    }