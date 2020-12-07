SHELL = /bin/bash

MKDIR = mkdir -p
CP = cp

.PHONY : all
all : build/ \

build/ :
	$(MKDIR) $@
