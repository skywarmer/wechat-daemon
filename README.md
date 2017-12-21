# README

iOS越狱开发

App守护进程，每60s唤醒一次App，如果App意外崩溃（如内存爆掉），可保证App能够重新启动，继续工作。


### Usage

sudo ./start.sh

> 注意：
>> 1. 修改`Makefile`的第一行，改成你的测试机的ip，确保测试机与mac在同一个局域网中
>> 2. 修改`start.sh`，设置THEOS为你theos文件夹的绝对路径

### 参考资料：

1. [iOSRE](http://bbs.iosre.com/t/ios-root/470)
2. [SO](https://stackoverflow.com/questions/15025174/pull-notification-locally-on-jailbroken-device)



### 遇到的问题：

1. 按照iosre中的教程，添加 `fauxsu` 和  `libfauxsu.dylib` 之后，make package，使用dpkg-deb查看deb包中文件的owner还是whs/staff。

   解决方法：

   ```bash
   sudo chown -R root:wheel .
   sudo su
   export THEOS=/opt/theos
   make package
   dpkg-deb -c packages/xxxxxxx.deb
   ```
   *See chang-log*

2. 无法启动App，提示： “Entitlement com.apple.frontboard.launchapplications required to open application in this manner.”

   解决方法：

   添加Entitlements.plist文件：

   ```xml
   <?xml version="1.0" encoding="UTF-8"?>
   <!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
   <plist version="1.0">
   <dict>
   	<key>com.apple.springboard.launchapplications</key>
   	<true/>
   </dict>
   </plist>
   ```

   修改Makefile，添加下面行

   ```xml 
   wechatd_CODESIGN_FLAGS = -SEntitlements.plist
   ```

   make clean

   make package install

3. 非完全越狱手机已重启就变成非越狱状态，wechatd无法自启动

   解决方法：

   修改Makefile最后一行为：

   ```makefile
   install.exec "killall -9 wechatd"
   ```

   然后手动启动wechatd

   ```bash
   ssh root@<ip>
   wechatd &
   exit
   ```

 ### change-log

 针对问题1，只需要修改layout文件夹的owner为root:wheel（或者0:0）即可
