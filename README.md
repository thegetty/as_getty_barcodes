# as_getty_barcodes

An ArchivesSpace plugin that adds the ability to download DataMatrix
barcodes for Archival Object Ref IDs.

Compatible with ArchivesSpace v3.2.0. It will likely be fine on any
recent version, but only tested on v3.2.0.

Developed by Hudson Molonglo for the J. Paul Getty Trust.


## Installation

No special installation instructions.
No required configuration.
No Gems.
No database migrations.
No overridden templates.


## Description

Adds a `Barcode` button to the Archival Object toolbar. When clicked, a
Datamatrix barcode is generated using the AO's Ref Id, and is downloaded as a
PNG image.

The name of the file is based on the AO's database ID
as follows:
```
  barcode_archival_object_[ID].png
```

The image is square. It contains a square datamatrix barcode in the center.
Above the barcode is the banner text 'JPC Archive', and below it is the
database ID of the Archival Object.

The data used to generate the barcode is the AO's Ref ID. If the AO does not
have a Ref ID value set, then the barcode button will not appear.


## Configuration

All configuration options are optional. The plugin will work fine without
setting any config, but there are a few options that can be set to customize
the behaviour.

Override the banner text (default 'JPC Archive'):
```
  AppConfig[:getty_barcode_banner] = 'Banner text'
```

Override the fractional size of the barcode with respect to the image size.
This defaults to 0.6 (60% of the image size). It might be necessary to tune
this value for a particular scanner - you want the barcode as large as possible
without conflicting with the text components of the image.
```
  AppConfig[:getty_barcode_fractional_size] = 0.7
```


## Dependencies

This plugin uses two open source java libraries to generate barcodes:
  - [barcode4j.jar](https://barcode4j.sourceforge.net/)
  - [jai-imageio-core-1.4.0.jar](https://mvnrepository.com/artifact/com.github.jai-imageio/jai-imageio-core)

These are bundled with the plugin.
