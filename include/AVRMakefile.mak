# AVRMakefile.mak

# detect the system we are using
ifeq ($(OS),Windows_NT)
	include $(MAKE_BASE)include/AVRMakeWin.mak
else
	UNAME_S = $(shell uname -s)
	ifeq ($(UNAME_S), Linux)
		include $(MAKE_BASE)include/AVRMakeLinux.mak
	endif
	ifeq ($(UNAME_S), Darwin)
		include $(MAKE_BASE)include/AVRMakeMac.mak
	endif
endif
include $(MAKE_BASE)include/AVRBuildRules.mak

