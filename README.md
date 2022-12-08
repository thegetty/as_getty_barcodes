# as_getty_barcodes

An ArchivesSpace plugin that adds the ability to download DataMatrix
barcodes for Archival Object Ref IDs.

Compatible with ArchivesSpace v3.2.0. It will likely be fine on any
recent version, but only tested on v3.2.0.

Developed by Hudson Molonglo for the J. Paul Getty Trust.


## Installation

No special installation instructions.
No Gems. No database migrations. No overridden templates.


## Description

Adds a button to the Archival Object toolbar. When clicked a Datamatrix
barcode is generated using the AO's Ref Id, and is downloaded as a PNG image.

The name of the file is based on the AO's Component Unique Identifier (CUI)
as follows:
```
  barcode_[CUI].png
```

## Dependencies

This plugin uses two open source java libraries to generate barcodes:
  - [barcode4j.jar](https://barcode4j.sourceforge.net/)
  - [jai-imageio-core-1.4.0.jar](https://mvnrepository.com/artifact/com.github.jai-imageio/jai-imageio-core)

These are bundled with the plugin.
