#!/bin/bash

SEARCHBASE=*

for FILENAME in $SEARCHBASE
do
  if test -d "$FILENAME"
  then
    echo "Skipping directory '$FILENAME'."
    continue
  fi
  FILEEXT="${FILENAME##*.}"
 
  # Check if FILENAME is an image and has the Key "Exif.Photo.DateTimeOriginal"
  exiv2 -K Exif.Photo.DateTimeOriginal "$FILENAME" > /dev/null 2>&1
  if [[ $? -ne 0 ]]
  then
    echo "Skipping file '$FILENAME', because the key 'Exif.Photo.DateTimeOriginal' is missing."
    continue
  fi

  RNDM=$((100 + RANDOM % 899))

  #exiv2 -r %Y%m%d_%H%M%S_$RNDM $FILENAME
  echo "Renamed '$FILENAME'."

done 
