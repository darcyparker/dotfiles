#!/usr/bin/env bash

#Set $XML_CATALOG_FILES for programs like xmllint.  vim's syntastic uses xmllint to validate xml files
#https://github.com/darcyparker/XMLCatalog is my XMLCatalog
#Note: Surround $XML_CATALOG_FILES in rare case there are spaces in it
if [ -z "$XML_CATALOG_FILES" ]; then
  [ -e "$HOME/src/XMLCatalog/catalog.xml" ] && export XML_CATALOG_FILES=$HOME/src/XMLCatalog/catalog.xml
fi
