(function(exports) {
    $(document).on("loadedrecordform.aspace", function(event, $pane) {
        const name = 'barcode_' + $('label[for=archival_object_component_id_]').parent().find('div').text();
        const data = $('label[for=archival_object_ref_id_]').parent().find('.identifier-display').text();

        if (name && data) {
            const bbut = '<a id="gettyBarcodeButton" class="btn btn-sm btn-default" href="/plugins/getty_barcode?data=' + data + '&name=' + name + '">Barcode</a>';
            $('.record-toolbar > .btn-toolbar > .btn-group').prepend(bbut);
        }
    });
}(window));

