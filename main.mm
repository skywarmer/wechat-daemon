#include <dlfcn.h>

#define SB "/System/Library/PrivateFrameworks/SpringBoardServices.framework/SpringBoardServices"

int openapp(const char *app) {
    int ret = 0;
    int (*openApp)(CFStringRef, Boolean);

    void* sbServices = dlopen(SB, RTLD_LAZY);

    openApp = (int(*)(CFStringRef, Boolean))dlsym(sbServices, "SBSLaunchApplicationWithIdentifier");

    ret = openApp((__bridge CFStringRef)@(app), false);

    dlclose(sbServices);

    return ret;
}

void tick(CFRunLoopTimerRef timer, void *info) {
    openapp("com.tencent.xin");
}

#define NOW CFAbsoluteTimeGetCurrent()

int main() {
    CFRunLoopTimerRef timer = CFRunLoopTimerCreate(NULL, NOW + 10, 60, 0, 0, &tick, nil);
    CFRunLoopAddTimer(CFRunLoopGetCurrent(), timer, kCFRunLoopDefaultMode);
    CFRunLoopRun();
}
// vim:ft=objc
