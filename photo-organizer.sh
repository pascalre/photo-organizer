#!/bin/bash

exiftool -v -r -d ./%Y/%m/%y-%m-%d/%Y%m%d_%H%M%S%%+2c.%%e '-FileName<CreateDate' *
