export ARCHS = arm64 arm64e
export TARGET := iphone:clang:latest:13.0
export SYSROOT = $(THEOS)/sdks/iPhoneOS.sdk
export FINALPACKAGE = 1

include $(THEOS)/makefiles/common.mk

BUNDLE_NAME = CATCatgirlWidget

CATCatgirlWidget_FILES = Widget/CATCatgirlWidget.m
CATCatgirlWidget_FRAMEWORKS = UIKit
CATCatgirlWidget_INSTALL_PATH = /Library/Multipla/Widgets
CATCatgirlWidget_CFLAGS = -fobjc-arc

ADDITIONAL_CFLAGS += -DTHEOS_LEAN_AND_MEAN

include $(THEOS_MAKE_PATH)/bundle.mk
include $(THEOS_MAKE_PATH)/aggregate.mk
