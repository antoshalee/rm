(function ($) {
	$.fn.iGallery = function (options) {

		var self = $(this);


		self.ttt = (self.ttt || 0) + 1;
		console.log(self.ttt);

		var settings = $.extend({
			'width': 846,
			'delay': 500,
			'maxwidth': 0,
			'maxheight': 0
		}, options);

		var current = 0;
		var count = 0;


		function init() {
			deleteOldIgalleryStuff();
			var html = '<div id="ig__overlay"></div><div id="ig"><div class="ig__wrap"><nav class="ig__control"><div class="ig__prev"></div><div class="ig__next"></div></nav><ul id="ig__layer">';
			var id = 0;

			self.each(function(i){
				var e = $(this);
				var type = e.attr('data-type');
				var link = e.attr('href');
				html += '<li class="ig__item not-loaded" id="ig__slide_'+id+'" data-type="'+type+'" data-link="'+link+'"><div class="ig__item_wrap"><div class="ig__info"><div class="ig__close"></div><div class="ig__num"><span class="ig__current"></span> / <span class="ig__count"></span></div></div>';
				html += '<div class="ig__shadow"></div></div></li>';
				e.attr('data-rel',id);
				id++;
			})

			count = id - 1
			html += '</ul><div class="ig__helper"></div></div></div>';
			$('body').append(html);

			// CSS
			$('#ig__overlay, #ig').css({'display':'none'});
			$('#ig .ig__wrap, #ig .ig__item').css({'width':settings['width']});
		}

		// if iGallery was reinited
		function deleteOldIgalleryStuff() {
			$('#ig__overlay').remove();
			$('#ig').remove();
		}

		function layout() {
			if ( settings['maxwidth'] == 0 ) settings['maxwidth'] = settings['width'] - 200;
			if ( settings['maxheight'] == 0 ) settings['maxheight'] = $(window).height() - 180;

			$('#ig .ig__item_wrap').css({
				'max-width': settings['maxwidth']+'px',
				'max-height': settings['maxheight']+'px'
			});
		}

		function switchEls(type, link) {
			var content = '';
			switch(type) {
				case 'youtube':
				 	link = link.trim().match(/v=([a-zA-Z0-9._-]+)/)[1];
					content = '<iframe class="youtube_iframe" width="560" height="315" src="http://www.youtube.com/embed/'+link+'" frameborder="0" allowfullscreen scrolling="no"></iframe>';
					break;
				case 'slideshare':
					content = '<iframe src="'+link+'" width="425" height="355" frameborder="0" marginwidth="0" marginheight="0" scrolling="no" allowfullscreen></iframe>';
					break;
				default:
					content = '<img src="'+link+'" class="ig__image" alt="">';
			}
			return content;
		}

		function normalizeEls() {
			$('.ig__image').each(function(){
				var e = $(this);
				var w = e.width();
				var h = e.height();
				var iRatio = w/h;
				var fRatio = settings['maxwidth']/settings['maxheight'];
				if ( h > w ) {
					if ( iRatio > fRatio ) e.css({'max-width': settings['maxwidth']+'px'});
					else e.css({'max-height': settings['maxheight']+'px'});
				}
				else {
					if ( iRatio > fRatio ) e.css({'max-width': settings['maxwidth']+'px'});
					else e.css({'max-height': settings['maxheight']+'px'});
				}
			})
		}

		function loadEls(i) {
			var a = i-1;
			var b = i+1;
			for (var j=a; j<=b; j++) {
				var e = $('#ig__slide_'+j);
				if ( e.hasClass('not-loaded') ) {
					var type = e.attr('data-type');
					var link = e.attr('data-link');
					var content = switchEls(type, link);
					e.find('.ig__info').after(content);
					e.removeClass('not-loaded');
				}
			}
			normalizeEls();
		}


		function go(i, delay) {
			var halfdelay = delay/2;

			// Go to slide
			var indent = -1 * settings['width'] * i
			$('.ig__shadow').animate({'opacity':0},200);
			$('#ig__layer').stop().animate({'left':indent+'px'},delay,function(){
				$('.ig__item_wrap').removeClass('ig__withshadow');
				$('#ig__slide_'+i+' .ig__shadow').animate({'opacity':1},400);
			})
			loadEls(i);
			current = i;

			// Show info
			$('.ig__info').hide();
			$('.ig__current').text(current+1);
			$('.ig__count').text(count+1);
			$('#ig__slide_'+i+' .ig__info').show();

			arrows();
		}

		function arrows() {
			if (current==0) $('.ig__prev').hide();
			else $('.ig__prev').show();
			if (current==count) $('.ig__next').hide();
			else $('.ig__next').show();
		}

		init();
		layout();
		go(0,0);

		// Open gallery
		self.bind('click',function(){
			$('#ig__overlay, #ig').show().css({'opacity':0}).stop().animate({'opacity':1},settings['delay']);
			go( parseInt($(this).attr('data-rel')), 0 );
			return false;
		});

		// Arrows
		$('.ig__prev').bind('click',function(){
			if ( current>0 ) go( current-1, settings['delay'] );
			else go( count, settings['delay'] );
		});
		$('.ig__next').bind('click',function(){
			if ( current<count ) go( current+1, settings['delay'] );
			else go( 0, settings['delay'] );
		});

		$(document).keydown(function(event) {
			if ( event.which == 37 ) {
				if ( current>0 ) go( current-1, settings['delay'] );
				else go( count, settings['delay'] );
			}
			if ( event.which == 39 ) {
				if ( current<count ) go( current+1, settings['delay'] );
				else go( 0, settings['delay'] );
			}
			if ( event.which == 27 ) {
				$('#ig__overlay, #ig').hide();
			}
		});

		// Close
		$('#ig__overlay, .ig__close').bind('click',function(){
			stopVideos();
			$('#ig__overlay, #ig').hide();
		});

		function stopVideos() {
			$('.youtube_iframe').each(function(){
				var codeForReplace = $(this).clone().wrap('<p>').parent().html();
				$(this).replaceWith(codeForReplace);
			})


		}

		// Reinit
		$(window).bind('resize',function(){
			layout();
			normalizeEls();
		});
	};
})(jQuery);