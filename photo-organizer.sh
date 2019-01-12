#!/bin/bash

# Description 
# ----------------------------------------------------------------------------------
# This command helps to organise pictures and videos, that contain Exif-Metadata. It 
# sorts all the files in a specific directory-structure and renames them following 
# this pattern: "./YYYY/YYYY-MM/YYYY-MM-DD/YYYYMMDD_HHMMSS.EXT".

exiftool -v -r -d ./%Y/%Y-%m/%y-%m-%d/%Y%m%d_%H%M%S%%+2c.%%e '-FileName<CreateDate' *
