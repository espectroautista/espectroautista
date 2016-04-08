#!/bin/sh

# Files that MUST exits before doing a make

touch etc/common.mak etc/es-rules.mak etc/es-pages.mak

# Generate some files
make config

# Make site
make all

# vim:sw=8:ts=8:ai:nowrap
