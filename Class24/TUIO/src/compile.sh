#!/bin/sh
javac -Xlint:deprecation -Xlint:-options -Xlint:unchecked -O -source 1.5 -target 1.5 -cp ../library/libTUIO.jar:core.jar TUIO/*.java
jar cfm ../library/TUIO.jar manifest.inc TUIO/*.class
rm -f TUIO/*.class
