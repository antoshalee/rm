//= require active_admin/base
//= require jquery.ui.tabs
//= require activeadmin-sortable
//= require autocomplete-rails
//= require jquery.Jcrop
//= require_tree ./admin
//= require jquery-fileupload/basic
//= require jquery-fileupload/vendor/tmpl
//= require igallery

$(document).ready(function(){
	$('#album_multiupload_form').fileupload({
		dropZone: $('#album_files_dropzone'),
		done: function(e, data) {
			console.log(data)
			var thumb_url = data.result.thumb_url;
			var fullscreen_url = data.result.fullscreen_url;
			var new_tr = '<tr>' +
                      	'<td class="">' +
                      	'<a class="igallery_item" href="' + fullscreen_url + '">' +
                      	'<img alt="" src="'+ thumb_url +'"></a></td>' +
                      	'<td class=""></td></tr>';

			// var new_tr = $('#album_items_table tr').last().clone();
			$('#album_items_table').append(new_tr);
			initIgallery();
		}
	});

	$('#collection_multiupload_form').fileupload({
		dropZone: $('#collection_files_dropzone'),
		done: function(e, data) {
			console.log(data)
			var thumb_url = data.result.thumb_url;
			var fullscreen_url = data.result.fullscreen_url;
			var new_tr = '<tr>' +
                      	'<td class="">' +
                      	'<a class="igallery_item" href="' + fullscreen_url + '">' +
                      	'<img alt="" src="'+ thumb_url +'"></a></td>' +
                      	'<td class=""></td><td class=""></td></tr>';

			// var new_tr = $('#collection_items_table tr').last().clone();
			$('#collection_items_table').append(new_tr);
			initIgallery();
		}
	});

	$('.sidebar_changer').change(function() {
		// alert('huy')

		var blockId = $('.sidebar_changer').val();
		if (!blockId) {
			$('#sidebar .panel_contents').html("");
		}
		else {
			$.get('/admin/sidebars/'+blockId+'/partial', function(data){
				$('#sidebar .panel_contents').html(data);
			});
		}

	});

	initIgallery();
})

// Sidebar form
$(document).ready(function() {
	function handleSidebarKindChanged() {
		if($('#sidebar_kind').val() == 'customized') {
			$('.has_many.sidebar_items').show();
		}
		else {
			$('.has_many.sidebar_items').hide();
		}
	}
	$('select#sidebar_kind').change(handleSidebarKindChanged);
	handleSidebarKindChanged();
})

function initIgallery() {
	if($('a.igallery_item').size()) {
		$('a.igallery_item').iGallery();
	}
}
