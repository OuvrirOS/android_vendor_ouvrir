#dotOS Versioning :
OUVRIR_MOD_VERSION = v6.0

OUVRIR_BUILD_TYPE ?= UNOFFICIAL
ifeq ($(WITH_GAPPS), true)
	OUVRIR_BUILD_TYPE := UNOFFICIAL_GAPPS
endif

CURRENT_DEVICE=$(shell echo "$(TARGET_PRODUCT)" | cut -d'_' -f 2,3)

OUVRIR_BUILD_DATE_UTC := $(shell date -u '+%Y%m%d-%H%M')

ifeq ($(OUVRIR_OFFICIAL), true)
   LIST = $(shell cat vendor/ouvrir/dot.devices)
   FOUND_DEVICE =  $(filter $(CURRENT_DEVICE), $(LIST))
    ifeq ($(FOUND_DEVICE),$(CURRENT_DEVICE))
      IS_OFFICIAL=true
      OUVRIR_BUILD_TYPE := OFFICIAL
      ifeq ($(WITH_GAPPS), true)
	OUVRIR_BUILD_TYPE := GAPPS
      endif
    endif
    ifneq ($(IS_OFFICIAL), true)
       OUVRIR_BUILD_TYPE := UNOFFICIAL
       ifeq ($(WITH_GAPPS), true)
	 OUVRIR_BUILD_TYPE := UNOFFICIAL_GAPPS
       endif
       $(error Device is not official "$(FOUND)")
    endif

endif

TARGET_PRODUCT_SHORT := $(subst dot_,,$(OUVRIR_BUILD))

OUVRIR_VERSION := dotOS-$(OUVRIR_MOD_VERSION)-$(CURRENT_DEVICE)-$(OUVRIR_BUILD_TYPE)-$(OUVRIR_BUILD_DATE_UTC)

OUVRIR_FINGERPRINT := dotOS/$(OUVRIR_MOD_VERSION)/$(PLATFORM_VERSION)/$(TARGET_PRODUCT_SHORT)/$(OUVRIR_BUILD_DATE_UTC)