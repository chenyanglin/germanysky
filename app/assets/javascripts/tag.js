//---------------------------------------------------------------------------------
/*!
 * jQuery Taggd
 * A helpful plugin that helps you adding 'tags' on images.
 *
 * License: MIT
 */
var map_show = localStorage.getItem("map_show");
$(document).on('click','#map', function () {
    // localStorage.setItem("map_show", 1);
    // window.location.reload();
    // alert('修改完成!');
    localStorage.setItem("map_show",0);
    window.location.reload();
    
});
(function($) {
	'use strict';
	
	var defaults = {
		edit: false,
		
		align: {
			x: 'center',
			y: 'center'
		},

		handlers: {},

		offset: {
			left: 0,
			top: 0
		},
		
		strings: {
			save: '&#x2713;',
			delete: '&#x00D7;'
		}
	};
	
	var methods = {
		show: function() {
			var $this = $(this),
				$label = $this.next();
			
			$this.addClass('active');
			$label.addClass('show').find('input').focus();
		},
		
		hide: function() {
			var $this = $(this);
			
			$this.removeClass('active');
			$this.next().removeClass('show');
		},
		
		toggle: function() {
			var $hover = $(this).next();
			
			if($hover.hasClass('show')) {
				methods.hide.call(this);
			} else {
				methods.show.call(this);
			}
		}
	};
	/****************************************************************
	 * TAGGD
	 ****************************************************************/
	//只有程式一開始執行
	var Taggd = function(element, options, data) {
		var _this = this;
		
		/*if(options.edit) {
			options.handlers = 
			{
				click: function() {
					mapbeacon_get();
					_this.hide(); //前一個隱藏
					methods.show.call(this);//新增刪除視窗彈出
				}
			};
		}*/
		this.element = $(element);
		this.options = $.extend(true, {}, defaults, options);
		this.data = data;

		this.initialized = true;
		
		if(!this.element.height() || !this.element.width()) {
			this.element.on('load', _this.initialize.bind(this));
		} 
		else this.initialize();
	};

	function mapbeacon_get(){
		// var request = "/javascripts/task_mapbeacon_assigned?map_id=" //access controller of interest
		//  + $('#map_id').text() + '&task_id=' + $('#task_id').text();
		var request = "/maps/mapbeacon_get?map_id=" //access controller of interest
		 + $('#map_id').text();
		var aj = $.ajax({
				async: false,
		        url: request,
		        type: 'get',
		        beacondata: $(this).serialize(),
		        dataType: 'json'
		    }).then(function (beacondata) {
		         insert_beacon(beacondata);
		         //update_assign_beacon();
		         async: true;
		    }).fail(function (beacondata) {
		         console.log('AJAX request has FAILED');
		         async: true;
		    });
 	};
 	function mapbeacon_add(){
		var request = "/maps/mapbeacon_add";
		var aj = $.ajax({
				async: false,
		        url: request,
		        type: 'get',
		        beacondata: $(this).serialize(),
		        dataType: 'json'
		    }).then(function (beacondata) {
		         async: true;
		    }).fail(function (beacondata) {
		         console.log('AJAX request has FAILED');
		         async: true;
		    });
 	};
 	function mapbeacon_del(uuid){
		var request = "/maps/mapbeacon_del?uuid=" + uuid;
		var aj = $.ajax({
				async: false,
		        url: request,
		        type: 'get',
		        beacondata: $(this).serialize(),
		        dataType: 'json'
		    }).then(function (beacondata) {
		         async: true;
		    }).fail(function (beacondata) {
		         console.log('AJAX request has FAILED');
		         async: true;
		    });
 	};
 	function insert_beacon(beacondata){
 		data.length = 0;
 		for(var i=0;i<beacondata.length;i++){
			data.push( { 
				x: beacondata[i].beacon_x, 
				y: beacondata[i].beacon_y, 
				text: beacondata[i].beacon_uuid,
				beacon_id: beacondata[i].beacon_id,
			 	status: beacondata[i].beacon_status,
			 	power: beacondata[i].power,
			 	width: beacondata[i].map_width,
			 	height: beacondata[i].map_height,
			 	
			 });
		};
	};
	function update_assign_beacon(map_id){
 		var request = "/tasks/refresh_beacons?map_id=" //access controller of interest
		 + $('#map_id').text() + '&task_id=' + $('#task_id').text();
		var aj = $.ajax({
				async: false,
		        url: request,
		        type: 'get',
		        beacondata: $(this).serialize(),
		        dataType: 'json'
		    }).then(function (beacondata) {
		         insert_beacon(beacondata);
		         update_assign_beacon($('#map_id').text());
		         async: true;
		    }).fail(function (beacondata) {
		         console.log('AJAX request has FAILED');
		         async: true;
		    });
	};

	function radio_check(){

		var rates = document.getElementsByName('[beacon_uuid]');
		var checked = false;
		//alert(rates[0].checked);
		for(var i = 0; i < rates.length; i++){
		    if(rates[i].checked){
		        checked = rates[i].checked;
		        break;
		        //alert(checked);
		    }
		}
	};

	Taggd.prototype.hide_uuid = function() {
		var _this = this;
		hide();
	};

	/****************************************************************
	 * INITIALISATION
	 ****************************************************************/
	
	Taggd.prototype.initialize = function() {
		var _this = this;
		
		this.initialized = true;
		
		this.initWrapper();

		mapbeacon_get();

		this.addDOM();
		
		if(this.options.edit) {
			this.element.on('click', function(e) {
				// alert(event.type);
			var poffset = $(this).parent().offset(),

				x = (e.pageX - poffset.left),// / _this.element.width(),
				y = (e.pageY - poffset.top);// / _this.element.height();

				$('#beacon_x').val(e.pageX - poffset.left),
				$('#beacon_y').val(e.pageY - poffset.top);
				//mapbeacon_get();

				var rates = document.getElementsByName('[beacon_uuid]');
				var checked = false;
				//alert(rates[0].checked);
				for(var i = 0; i < rates.length; i++){
				    if(rates[i].checked){
				        checked = rates[i].checked;
				        $('#radio_check').text(rates[i].value);
				        break;
				        //alert(checked);
				    }
				}
				//if ($("#task_beacon_uuid_dropdown").text() != '')
				// if (checked == true)
				// {
					//平面圖佈點
					// _this.addData({
					// 	x: x,
					// 	y: y,
					// 	text: '',
					// 	status: 'qq',
					// 	width: $('#map').width(),
					// 	height: $('#map').height()
					// });
					// _this.show(_this.data.length - 1);
				// }
			});
		}
		if (map_show == 1) {
			this.show();//讓全部uuid秀出來
		}
		
		$(window).resize(function() {
			_this.updateDOM();
		});
	};
	
	Taggd.prototype.initWrapper = function() {
		var wrapper = $('<div class="taggd-wrapper" />');
		this.element.wrap(wrapper);
		
		this.wrapper = this.element.parent('.taggd-wrapper');
	};
	
	//---edit 功能區
	Taggd.prototype.alterDOM = function() {
		var _this = this;
		
		this.wrapper.find('.taggd-item-hover').each(function() {
			var $e = $(this),
			// $linkstart = $('<a id="pointbutton" href="'+$rootdomain+'/notifications/uuidedit.'+$e.text()+'" >'+$e.text()+'</a>'),
			
			$id = $e.attr('beacon_id'),
			$linkstart = $('<a id="pointbutton" href="/notifications/uuidedit.'+$e.text()+'" >'+$id+'</a>'),
			$uuid = $e.text(),
			// $uuid = $('<span />')
			// 	.html($e.text()),
			$power = $('<div> <span class="glyphicon glyphicon-flash" aria-hidden="true" style="font-size:13px;color:yellow;font-weight:bold"></span>'+$e.attr('power')+'%</div>')
				.html(),
			$br = $("<br></br>"),
			$pushlink = $("<div> "+$e.attr('pushlink')+'</div>')
				.html(),
			$nopower = $('<div> <span class="glyphicon glyphicon-flash" aria-hidden="true" style="font-size:13px;color:yellow;font-weight:bold"></span>--%</div>')
				.html(),
			//$input = $('<input type="text" size="16" />')
			//	.val($e.text()),
			$button_ok = $('<button />')
				.html(_this.options.strings.save),
			$button_delete = $('<button />')
				.html(_this.options.strings.delete);
			
			$button_ok.on('click', function() {
				_this.addDOM();
				_this.element.triggerHandler('change');

				mapbeacon_add();
			    window.location.reload();
			});
			
			$button_delete.on('click', function() {
				var x = $e.attr('data-x'),
					y = $e.attr('data-y');
				
					_this.data = $.grep(_this.data, function(v) {
						return v.x != x || v.y != y;
					});

						mapbeacon_del($uuid.text());
						window.location.reload();
					
					_this.addDOM();
					_this.element.triggerHandler('change');
			});
			
			/*
			$input.on('change', function() {
				var x = $e.attr('data-x'),
					y = $e.attr('data-y'),
					item = $.grep(_this.data, function(v) {
						return v.x == x && v.y == y;
					}).pop();
				
				if(item) item.text = $input.val();
				
				_this.addDOM();
				_this.element.triggerHandler('change');	
			});
	*/
			//$e.empty().append($input, $button_ok, $button_delete);


			//判斷若點在點上 不能儲存
			if ($e.text() == ''){
				//$uuid = $('<span />').html($('#task_beacon_uuid_dropdown').val());
				$uuid = $('#radio_check').text();
				$e.empty().append($id,$button_ok,$button_delete);
			}else{
				if ($e.attr('power') > -1){
					if ($e.attr('power') == 0){
						$e.empty().append($id, $nopower);
					} else {
						$e.empty().append($linkstart, $power);
						// alert($linkstart+$uuid);
					}
				} else {
					$e.empty().append($id);
				}
			}
		});
		_this.updateDOM();
	};
	/****************************************************************
	 * DATA MANAGEMENT
	 ****************************************************************/
	
	Taggd.prototype.addData = function(data) {
		if($.isArray(data)) {
			this.data = $.merge(this.data, data);
		} else {
			if (this.data.length > 0){
				if (this.data[this.data.length-1].status == 'qq'){
					this.data.pop();
				}
			}
			this.data.push(data);
		}
		
		if(this.initialized) {
			this.addDOM();
			this.element.triggerHandler('change');
		}
	};
	
/*	Taggd.prototype.setData = function(data) {
		this.data = data;
		
		if(this.initialized) {
			this.addDOM();
		}
	};*/
	
	Taggd.prototype.clear = function() {
		if(!this.initialized) return;
		this.wrapper.find('.taggd-item, .taggd-item-hover').remove();
	};
	
	
	/****************************************************************
	 * EVENTS
	 ****************************************************************/
	
	Taggd.prototype.on = function(event, handler) {
		if(
			typeof event !== 'string' ||
			typeof handler !== 'function'
		) return;
		
		this.element.on(event, handler);
	};
	
	
	/****************************************************************
	 * TAGS MANAGEMENT
	 ****************************************************************/
	
	Taggd.prototype.iterateTags = function(a, yep) {
		var func;
		
		if($.isNumeric(a)) {
			func = function(i, e) { return a === i; };
		} else if(typeof a === 'string') {
			func = function(i, e) { return $(e).is(a); }
		} else if($.isArray(a)) {
			func = function(i, e) {
				var $e = $(e);
				var result = false;
				
				$.each(a, function(ai, ae) {
					if(
						i === ai ||
						e === ae ||
						$e.is(ae)
					) {
						result = true;
						return false;
					}
				});
				
				return result;
			}
		} else if(typeof a === 'object') {
			func = function(i, e) {
				var $e = $(e);
				return $e.is(a);
			};
		} else if($.isFunction(a)) {
			func = a;
		} else if(!a) {
			func = function() { return true; }
		} else return this;
		
		this.wrapper.find('.taggd-item').each(function(i, e) {
			if(typeof yep === 'function' && func.call(this, i, e)) {
				yep.call(this, i, e);
			}
		});
		
		return this;
	};
	
	Taggd.prototype.show = function(a) {
		return this.iterateTags(a, methods.show);
	};
	
	Taggd.prototype.hide = function(a) {
		return this.iterateTags(a, methods.hide);
	};
	
	Taggd.prototype.toggle = function(a) {
		return this.iterateTags(a, methods.toggle);
	};
	
	/****************************************************************
	 * CLEANING UP
	 ****************************************************************/
	
	Taggd.prototype.dispose = function() {
		this.clear();
		this.element.unwrap(this.wrapper);
	};
	
	
	/****************************************************************
	 * SEMI-PRIVATE
	 ****************************************************************/
	
	Taggd.prototype.addDOM = function() {
		var _this = this;
		
		this.clear();
		//this.element.css({ height: 'auto', width: 'auto' });
		this.element.css({ height: $('#map').height(), width: $('#map').width() });

		//var height = this.element.height();//圖的高
		//var width = this.element.width();

		var height = $('#map').height();
		var width = $('#map').width();
		
		$.each(this.data, function(i, v) {
			var $item = $('<span />');
			var $hover;
			
			var x = 0, y = 0;
			/*if(
				v.x > 1 && v.x % 1 === 0 &&
				v.y > 1 && v.y % 1 === 0
			) {
				v.x = v.x / width;
				v.y = v.y / height;
			}*/
			
			if(typeof v.attributes === 'object') {
				$item.attr(v.attributes);
			}
			x = v.x * ( width / v.width ),
			y = v.y * ( height / v.height )
			
			//---點的格式

			$item.attr({
				'data-x': x,
				'data-y': y
			});
			
			$item.css('position', 'absolute');
			$item.addClass('taggd-item');
			//---

			if (v.status == '4'){
				$item.css('background-color', '#0F0');
			}
			
			_this.wrapper.append($item);//秀點
			
			//點擊時的視窗
			if(typeof v.text === 'string' && (v.text.length > 0 || _this.options.edit)) {

				$hover = $('<span class="taggd-item-hover" style="position: absolute;" />').html(v.text);
				
				//$hover_power = v.power;

				$hover.attr({
					'data-x': x,
					'data-y': y,
					'power': v.power,
					'pushlink': v.pushlink,
					'beacon_id' :v.beacon_id
				});
				
				_this.wrapper.append($hover); //點擊新增時的對話視窗
			}
			
			if(typeof _this.options.handlers === 'object') {
				$.each(_this.options.handlers, function(event, func) {
					var handler;
					
					if(typeof func === 'string' && methods[func]) {
						handler = methods[func];
					} else if(typeof func === 'function') {
						handler = func;
					}
					
					$item.on(event, function(e) {
						if(!handler) return;
						handler.call($item, e, _this.data[i]);
					});
				});
			}
		});
		
		this.element.removeAttr('style');
		
		if(this.options.edit) {
			this.alterDOM();
		}
		this.updateDOM();
	};
	
	Taggd.prototype.updateDOM = function() {
		var _this = this;
		
		this.wrapper.removeAttr('style').css({
			//height: this.element.height(),
			//width: this.element.width()
			height: $('#map').height(),
			width: $('#map').width()
		});

		var height = parseInt($('#map').height());// * $('#map').width();
		var width = parseInt($('#map').width());// * $('#map').height();
		
		this.wrapper.find('span').each(function(i, e) {
			var $el = $(e);
			
			//var left = $el.attr('data-x') * _this.element.width();
			//var top = $el.attr('data-y') * _this.element.height();

			var left = parseInt($el.attr('data-x'));// * $('#map').width();
			var top = parseInt($el.attr('data-y'));// * $('#map').height();
			//alert(top);
			
			//點位置
			if($el.hasClass('taggd-item')) {
				$el.css({
					left: left - $el.outerWidth(true) / 2,
					top: top - $el.outerHeight(true) / 2
				});
			} 
			else if($el.hasClass('taggd-item-hover')) {
				/*if(_this.options.align.x === 'center') {
					left -= $el.outerWidth(true) / 2;
				} else if(_this.options.align.x === 'right') {
					left -= $el.outerWidth(true);
				}
				
				if(_this.options.align.y === 'center') {
					top -= $el.outerHeight(true) / 2;
				} else if(_this.options.align.y === 'bottom') {
					top -= $el.outerHeight(true);
				}
				
				$el.attr('data-align', $el.outerWidth(true));
				
				$el.css({
					left: left + _this.options.offset.left,
					top: top + _this.options.offset.top
				});*/
				//資訊位置
				//left -= 100;
				var widthgap = $el.outerWidth(true) / 2 - (width - left) +2
				if (width - left <= $el.outerWidth(true)/2){
					left -= widthgap;
				}
				if (left <= $el.outerWidth(true)/2){
					left += $el.outerWidth(true) / 2 -left;
				}
				if (height - top <= $el.outerHeight(true)*2.8){
					top -= $el.outerHeight(true)*3.5;
				}
				$el.css({
					left: left - $el.outerWidth(true) / 2,
					top: top + $el.outerHeight(true) / 1.5
				});
			}
		});
	};
	
	
	/****************************************************************
	 * JQUERY LINK
	 ****************************************************************/
	//初始時呼叫Taggd
	$.fn.taggd = function(options, data) {
		return new Taggd(this, options, data);
	};
})(jQuery);