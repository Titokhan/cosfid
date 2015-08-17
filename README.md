#Cyanogen OS Factory Image Downloader

#Introduction

If you get your hands on a device with Cyanogen OS preinstalled and there is no factory image for it published by Cyanogen Inc. yet, then this script is for you. It constructs download links of factory image from a device running Cyanogen OS.

There are different files for a factory image: signed fastboot flashable zip, signed zip & boot-debuggable image.

Signed fastboot flashable zip: It contains the complete rom and can overwrite everything including your data partition. These cannot be flashed via recovery - extract their contents and flash via fastboot. An unlocked bootloader is required.

Signed zip: Normal recovery-flashable zip that contains just the system and kernel (they won't overwrite your data partition).

Boot-debuggable image: It is boot image/kernel that enables adb root and the developer menu options.

#Requirements

1. Windows Vista or newer. 2000/XP should also work if choice.exe is present.
2. Properly installed adb driver; see here: https://github.com/PFCKrutonium/UnifL_ADB_USB_Project
3. Properly configured adb_usb.ini (optional); see here: https://github.com/apkudo/adbusbini
4. A device with regular Cyanogen OS (testing versions aren't supported) installed; list is here: https://cyngn.com/support/

#Usage

Download all of the files using "Download ZIP" option, extract somewhere (path with no space is recommended), connect the target device using USB cable & execute COSFID.cmd.

Don't confuse it by Cyanogen OS OTA trackers like the original one: http://cyanogen-ota-bacon.somee.com/; read carefully to spot the difference. ;)

#Credit

1. qewlpal@MDL (http://forums.mydigitallife.info/members/162297) for inspirations in scripting
2. Jernej Simončič for providing Windows builds of GNU wget (https://eternallybored.org/misc/wget/)
3. Google for providing adb binaries under Apache license
4. Cyanogen for making Android more beautiful :)
