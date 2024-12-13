#!/bin/bash
DEFAULT_FORMAT='%a %eXX %b %Y'
FORMAT=+${1:-$DEFAULT_FORMAT}
LC_ALL=C date "$FORMAT" | sed -e 's/11XX/11th/' -e 's/12XX/12th/' -e 's/13XX/13th/' -e 's/1XX/1st/' -e 's/2XX/2nd/' -e 's/3XX/3rd/' -e 's/XX/th/'
