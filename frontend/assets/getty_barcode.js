(function(exports) {
    $(document).on("loadedrecordform.aspace", function(event, $pane) {
        const loc_hash = document.location.hash.split('::');
        if (loc_hash.length > 1) {
            const name = $('label[for=archival_object_component_id_]').parent().find('div').text() || loc_hash[1];
            const data = $('label[for=archival_object_ref_id_]').parent().find('.identifier-display').text();
            const text = loc_hash[1].split('_')[2];
            const refid = $('label[for=archival_object_ref_id_]').parent().find('.identifier-display').text().substr(-8);

            if (data) {
                const url = AS.app_prefix('/plugins/getty_barcode?data=' + data + '&name=barcode_' + name + '&text=' + text + '&refid=' + refid);
                const bbut = '<a id="getty-barcode-button" class="btn btn-sm btn-default" href="' + url + '">Barcode</a>';
                $('.record-toolbar > .btn-toolbar > .btn-group').prepend(bbut);

                // show the barcode in the title area. disable for now. not sure if it's required
                // const bimg = '<div class="pull-right"><a href="' + url + '" title="Click to download"><img id="getty-barcode-image" style="height:50px;" src="' + url + '"/></a></div>';
                // $('.record-pane').prepend(bimg);
            }
        }
    });
}(window));

