(function(exports) {
    $(document).on("loadedrecordform.aspace", function(event, $pane) {
        const name = $('label[for=archival_object_component_id_]').parent().find('div').text() || document.location.hash.split('::')[1];
        const data = $('label[for=archival_object_ref_id_]').parent().find('.identifier-display').text();

        if (data) {
            const url = AS.app_prefix('/plugins/getty_barcode?data=' + data + '&name=barcode_' + name);
            const bbut = '<a id="getty-barcode-button" class="btn btn-sm btn-default" href="' + url + '">Barcode</a>';
            $('.record-toolbar > .btn-toolbar > .btn-group').prepend(bbut);

            const bimg = '<div class="pull-right"><a href="' + url + '" title="Click to download"><img id="getty-barcode-image" style="height:50px;" src="' + url + '"/></a></div>';
            $('.record-pane').prepend(bimg);
        }
    });
}(window));

