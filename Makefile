THEOS_DEVICE_IP = 192.168.2.123
THEOS_DEVICE_PORT = 22

include $(THEOS)/makefiles/common.mk

TOOL_NAME = wechatd
wechatd_FILES = main.mm
wechatd_FRAMEWORKS = 
wechatd_CODESIGN_FLAGS = -SEntitlements.plist

include $(THEOS_MAKE_PATH)/tool.mk

after install::
		install.exec "kill -9 wechatd;nohup wechatd &"
