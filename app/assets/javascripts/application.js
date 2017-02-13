// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//

//= require_tree .
//= require jquery
//= require jquery_ujs
//= require bootstrap
//= require react
//= require react_ujs
//= require components
//= require redactor-rails
//= require_tree
//= require jquery.infinite-pages
//= require jquery-fileupload
//= require js.cookie
//= require semantic-ui
//= require clipboard
//= require shop
<<<<<<< HEAD
//= require bootstrap
//= require bootstrap.min
//= require jquery.easing-1.3.min
//= require jquery.scrollTo-1.4.3.1-min
//= require bootstrap/dropdown
//= require bootstrap/alert

=======
>>>>>>> b2867074238d0572110b76f57aefa3a0ef6aaed6


$(document).ready(function() {
  $('#product_manage').popup({
    inline   : true,
    position : 'bottom right',
    on: 'click'
  });
  $('#user_profile').popup({
    inline   : true,
    position : 'bottom right',
    on: 'click'
  });
  $('#type_and_brand').popup({
    inline   : true,
    position : 'bottom right',
    on: 'click'
  });
  $('#pay_and_delivery').popup({
    inline   : true,
    position : 'bottom right',
    on: 'click'
  });
  $('#user_manage').popup({
    inline   : true,
    position : 'bottom right',
    on: 'click'
  });
  $('.simple_time')
    .popup({
      inline   : true,
      hoverable: true,
      position : 'top center'
    })
  ;
});
  $('body').on('click','#edit-admin',function(){
    $('.ui.dimmer.site').dimmer('show');

    var row_id = $(this).data("value");
    $.get( "/accounts/"+row_id+"/edit", function(html) {
      $("#admin_from").empty();
      $("#admin_from").append(html);
      $('.ui.dimmer.site').dimmer('hide');

      $('.ui.small.modal.admin').modal({
        observeChanges: true
      }).modal('setting', 'closable', false)
      .modal('refresh').modal('show');

    }).fail(function() {
      $('.ui.dimmer.site').dimmer('hide');
      alert( "error" );
    });
  });
  
$(function() {
  $("#map").click
  (function(e) {

    var offset = $(this).offset();

    var relativeX = (e.pageX - offset.left);
    var relativeY = (e.pageY - offset.top);
    var imagemap_width = $('#map').width();
    var imagemap_height = $('#map').height();
    /*alert(relativeX+':'+relativeY);*/
    $(".position").val("afaf");

    $('#x_point').text("x = " + relativeX);
    $('#y_point').text("y = " + relativeY);
    $('#image_width').text("width = " + imagemap_width);
    $('#image_hight').text("hight = " + imagemap_height);

    $('#beacon_x').val(relativeX);
    $('#beacon_y').val(relativeY);
    $('#map_width').val(imagemap_width);
    $('#map_hight').val(imagemap_height);
    $('#offsetleft').val(offset.left);
    $('#offsettop').val(offset.top);

    $("#add_beacon").show();

    });
  $("#add_beacon").hide();
});

$(function()
{
  $("#other").click
  (function(e)
    {
//      $("#add_beacon").hide();
    }
  );
});
/*
$(function()
{
  $("#beacon").click
  (function(e)
    {
      if($('#sidebar-wrapper').css('display') == 'none'){
        $("#sidebar-wrapper").show();
      }
      else{
        $("#sidebar-wrapper").hide();
      }
    }
  );
});*/

//------------------------------------Progress Bar

//--- 新增畫面選擇brand_id

$(document).on('change','#new_brand_id', function () {//change majors when user changes school

  var e = document.getElementById("new_brand_id");
  var brand = e.options[e.selectedIndex].value;

  if ( brand == 1 ){
    document.getElementById("new_power").checked = true;
  }
  else{
    document.getElementById("new_power").checked = false;
  }
});

//---beacon_uuid dropdown select

// $(document).on('change','#brand_id_dropdown', function () {//change majors when user changes school
//    var request = "/beacons/find_beacon_uuid_given_brand_id?brand_id=" //access controller of interest
//         + $('#brand_id_dropdown').val();

//     var aj = $.ajax({
//         url: request,
//         type: 'get',
//         data: $(this).serialize()
//     }).done(function (data) {
//          change_uuids(data);//modify the majors' dropdown
//     }).fail(function (data) {
//          console.log('AJAX request has FAILED');
//     });
// });

// function change_uuids(data) {
//     $("#beacon_uuid_dropdown").empty();//remove all previous majors
//     var option;
//     if(data.length != 0){
//      for(i = 0;i<data.length;i++){
//          $("#beacon_uuid_dropdown").append(//add in an option for each major
//              option = $("<option></option>").attr("value", data[i].beacon_uuid).text(data[i].beacon_uuid),
//              option.attr('selected', true)
//          );
//      }
//      $("#beacon_description").show();
//  }
//  else{
//    $("#beacon_description").hide();
//  }
// };


// 表格排序
;(function($) {

  $.tablesort = function ($table, settings) {
    var self = this;
    this.$table = $table;
    this.settings = $.extend({}, $.tablesort.defaults, settings);
    this.$table.find('thead th').bind('click.tablesort', function() {
      if( !$(this).hasClass('disabled') ) {
        self.sort($(this));
      }
    });
    this.index = null;
    this.$th = null;
    this.direction = [];
  };

  $.tablesort.prototype = {

    sort: function(th, direction) {
      var start = new Date(),
        self        = this,
        table       = this.$table,
        rows        = table.find('tbody tr'),
        index       = th.index(),
        cache       = [],
        fragment    = $('<div/>'),
        sortValueForCell = function(th, td, sorter) {
          var
            sortBy
          ;
          if(th.data().sortBy) {
            sortBy = th.data().sortBy;
            return (typeof sortBy === 'function')
              ? sortBy(th, td, sorter)
              : sortBy
            ;
          }
          return ( td.data('sort') )
            ? td.data('sort')
            : td.text()
          ;
        },
        naturalSort =  function naturalSort (a, b) {
          var
            chunkRegExp    = /(^-?[0-9]+(\.?[0-9]*)[df]?e?[0-9]?$|^0x[0-9a-f]+$|[0-9]+)/gi,
            stripRegExp    = /(^[ ]*|[ ]*$)/g,
            dateRegExp     = /(^([\w ]+,?[\w ]+)?[\w ]+,?[\w ]+\d+:\d+(:\d+)?[\w ]?|^\d{1,4}[\/\-]\d{1,4}[\/\-]\d{1,4}|^\w+, \w+ \d+, \d{4})/,
            numericRegExp  = /^0x[0-9a-f]+$/i,
            oRegExp        = /^0/,
            cLoc           = 0,
            useInsensitive = function(string) {
              return ('' + string).toLowerCase().replace(',', '');
            },
            // convert all to strings strip whitespace
            x              = useInsensitive(a).replace(stripRegExp, '') || '',
            y              = useInsensitive(b).replace(stripRegExp, '') || '',
            // chunk/tokenize
            xChunked       = x.replace(chunkRegExp, '\0$1\0').replace(/\0$/,'').replace(/^\0/,'').split('\0'),
            yChunked       = y.replace(chunkRegExp, '\0$1\0').replace(/\0$/,'').replace(/^\0/,'').split('\0'),
            chunkLength    = Math.max(xChunked.length, yChunked.length),
            // numeric, hex or date detection
            xDate          = parseInt(x.match(numericRegExp), 10) || (xChunked.length != 1 && x.match(dateRegExp) && Date.parse(x)),
            yDate          = parseInt(y.match(numericRegExp), 10) || xDate && y.match(dateRegExp) && Date.parse(y) || null,
            xHexValue,
            yHexValue,
            index
          ;
          // first try and sort Hex codes or Dates
          if (yDate) {
            if( xDate < yDate ) {
              return -1;
            }
            else if ( xDate > yDate ) {
              return 1;
            }
          }
          // natural sorting through split numeric strings and default strings
          for(index = 0; index < chunkLength; index++) {
              // find floats not starting with '0', string or 0 if not defined (Clint Priest)
              xHexValue = !(xChunked[index] || '').match(oRegExp) && parseFloat(xChunked[index]) || xChunked[index] || 0;
              yHexValue = !(yChunked[index] || '').match(oRegExp) && parseFloat(yChunked[index]) || yChunked[index] || 0;
              // handle numeric vs string comparison - number < string - (Kyle Adams)
              if (isNaN(xHexValue) !== isNaN(yHexValue)) {
                return ( isNaN(xHexValue) )
                  ? 1
                  : -1
                ;
              }
              // rely on string comparison if different types - i.e. '02' < 2 != '02' < '2'
              else if (typeof xHexValue !== typeof yHexValue) {
                xHexValue += '';
                yHexValue += '';
              }
              if (xHexValue < yHexValue) {
                return -1;
              }
              if (xHexValue > yHexValue) {
                return 1;
              }
          }
          return 0;
        }
      ;

      if(rows.length === 0) {
        return;
      }

      self.$table.find('thead th').removeClass(self.settings.asc + ' ' + self.settings.desc);

      this.$th = th;
      if(this.index != index) {
        this.direction[index] = 'desc';
      }
      else if(direction !== 'asc' && direction !== 'desc') {
        this.direction[index] = this.direction[index] === 'desc' ? 'asc' : 'desc';
      }
      else {
        this.direction[index] = direction;
      }
      this.index = index;
      direction = this.direction[index] == 'asc' ? 1 : -1;

      self.$table.trigger('tablesort:start', [self]);
      self.log("Sorting by " + this.index + ' ' + this.direction[index]);

      rows.sort(function(a, b) {
        var aRow = $(a);
        var bRow = $(b);
        var aIndex = aRow.index();
        var bIndex = bRow.index();

        // Sort value A
        if(cache[aIndex]) {
          a = cache[aIndex];
        }
        else {
          a = sortValueForCell(th, self.cellToSort(a), self);
          cache[aIndex] = a;
        }
        // Sort Value B
        if(cache[bIndex]) {
          b = cache[bIndex];
        }
        else {
          b = sortValueForCell(th, self.cellToSort(b), self);
          cache[bIndex]= b;
        }
        return (naturalSort(a, b) * direction);
      });

      rows.each(function(i, tr) {
        fragment.append(tr);
      });
      table.append(fragment.html());

      th.addClass(self.settings[self.direction[index]]);

      self.log('Sort finished in ' + ((new Date()).getTime() - start.getTime()) + 'ms');
      self.$table.trigger('tablesort:complete', [self]);

    },

    cellToSort: function(row) {
      return $($(row).find('td').get(this.index));
    },


    log: function(msg) {
      if(($.tablesort.DEBUG || this.settings.debug) && console && console.log) {
        console.log('[tablesort] ' + msg);
      }
    },

    destroy: function() {
      this.$table.find('thead th').unbind('click.tablesort');
      this.$table.data('tablesort', null);
      return null;
    }

  };

  $.tablesort.DEBUG = false;

  $.tablesort.defaults = {
    debug: $.tablesort.DEBUG,
    asc: 'sorted ascending',
    desc: 'sorted descending'
  };

  $.fn.tablesort = function(settings) {
    var table, sortable, previous;
    return this.each(function() {
      table = $(this);
      previous = table.data('tablesort');
      if(previous) {
        previous.destroy();
      }
      table.data('tablesort', new $.tablesort(table, settings));
    });
  };

})(jQuery);
