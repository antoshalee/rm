//= require active_admin/base
//= require jquery.ui.tabs
//= require activeadmin-sortable
//= require autocomplete-rails
//= require jquery.Jcrop
//= require_tree ./admin
//= require jquery-fileupload/basic
//= require jquery-fileupload/vendor/tmpl

$(document).ready(function(){
	$('#album_multiupload_form').fileupload({
		dropZone: $('#album_files_dropzone'),
		done: function(e, data) {
			console.log(data)
			var thumb_url = data.result.thumb_url;
			var new_tr = '<tr>' +
                      	'<td class="">' +
                      	'<img alt="" src=" '+ thumb_url +'"></td>' +
                      	'<td class=""></td></tr>';

			// var new_tr = $('#album_items_table tr').last().clone();
			$('#album_items_table').append(new_tr);
		}
	});
})
