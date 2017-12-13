#!/bin/bash

SEARCHBASE=*

for FILENAME in $SEARCHBASE
do
  if test -d "$FILENAME"
  then
    continue
  fi
  FILEEXT="${FILENAME##*.}"
 
  # Check if FILENAME is an image and has the Key "Exif.Photo.DateTimeOriginal"
  exiv2 -K Exif.Photo.DateTimeOriginal "$FILENAME" > /dev/null 2>&1
  if [[ $? != 0 ]]
  then
    continue
  fi

  RNDM=$((100 + RANDOM % 899))

  #exiv2 -r %Y%m%d_%H%M%S_$RNDM $FILENAME
  echo "Renamed $FILENAME"

done 
