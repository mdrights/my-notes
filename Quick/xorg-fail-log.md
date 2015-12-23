==> /var/log/Xorg.0.log <==
[  2241.025] (**) SynPS/2 Synaptics TouchPad: (accel) acceleration profile 1
[  2241.025] (**) SynPS/2 Synaptics TouchPad: (accel) acceleration factor: 2.000
[  2241.025] (**) SynPS/2 Synaptics TouchPad: (accel) acceleration threshold: 4
[  2241.026] (--) synaptics: SynPS/2 Synaptics TouchPad: touchpad found
[  2241.027] (II) config/udev: Adding input device SynPS/2 Synaptics TouchPad (/dev/input/mouse0)
[  2241.027] (**) SynPS/2 Synaptics TouchPad: Ignoring device from InputClass "touchpad ignore duplicates"
[  2241.028] (II) config/udev: Adding input device PC Speaker (/dev/input/event5)
[  2241.028] (II) No input driver specified, ignoring this device.
[  2241.028] (II) This device may have been added with another device file.
[  3304.874] (EE) intel(0): Failed to submit batch buffer, expect rendering corruption: Resource deadlock avoided.
 (EE) 
[  3644.655] (EE) Backtrace:
[  3644.656] (EE) 0: /usr/bin/X (xorg_backtrace+0x52) [0xb7711552]
[  3644.656] (EE) 1: /usr/bin/X (0xb756b000+0x1aa7f2) [0xb77157f2]
[  3644.657] (EE) 2: linux-gate.so.1 (__kernel_rt_sigreturn+0x0) [0xb7547d28]
[  3644.657] (EE) 3: /usr/lib/i386-linux-gnu/libpixman-1.so.0 (0xb7370000+0x99df0) [0xb7409df0]
[  3644.657] (EE) 4: /usr/lib/i386-linux-gnu/libpixman-1.so.0 (0xb7370000+0x58f4f) [0xb73c8f4f]
[  3644.657] (EE) 5: /usr/lib/i386-linux-gnu/libpixman-1.so.0 (pixman_blt+0x4a) [0xb73768aa]
[  3644.657] (EE) 6: /usr/lib/xorg/modules/libfb.so (fbCopyNtoN+0x2bc) [0xb6a2ab2c]
[  3644.657] (EE) 7: /usr/bin/X (miCopyRegion+0x18d) [0xb76ef75d]
[  3644.658] (EE) 8: /usr/bin/X (miDoCopy+0x49d) [0xb76efd3d]
[  3644.658] (EE) 9: /usr/lib/xorg/modules/libfb.so (fbCopyArea+0x4e) [0xb6a2b28e]
[  3644.658] (EE) 10: /usr/lib/xorg/modules/drivers/intel_drv.so (0xb6a77000+0x116756) [0xb6b8d756]
[  3644.658] (EE) 11: /usr/lib/xorg/modules/drivers/intel_drv.so (0xb6a77000+0x10fde3) [0xb6b86de3]
[  3644.658] (EE) 12: /usr/bin/X (0xb756b000+0x12b7b5) [0xb76967b5]
[  3644.659] (EE) 13: /usr/bin/X (0xb756b000+0xd1ae2) [0xb763cae2]
[  3644.659] (EE) 14: /usr/bin/X (0xb756b000+0xd2ecd) [0xb763decd]
[  3644.659] (EE) 15: /usr/bin/X (0xb756b000+0xd00d7) [0xb763b0d7]
[  3644.659] (EE) 16: /usr/bin/X (0xb756b000+0x122802) [0xb768d802]
[  3644.664] (EE) 17: /usr/bin/X (ConfigureWindow+0x40c) [0xb75d58bc]
[  3644.664] (EE) 18: /usr/bin/X (0xb756b000+0x375cf) [0xb75a25cf]
[  3644.664] (EE) 19: /usr/bin/X (0xb756b000+0x3d086) [0xb75a8086]
[  3644.664] (EE) 20: /usr/bin/X (0xb756b000+0x4126a) [0xb75ac26a]
[  3644.665] (EE) 21: /usr/bin/X (0xb756b000+0x2af2a) [0xb7595f2a]
[  3644.665] (EE) 22: /lib/i386-linux-gnu/i686/cmov/libc.so.6 (__libc_start_main+0xf3) [0xb7131a63]
[  3644.665] (EE) 23: /usr/bin/X (0xb756b000+0x2af68) [0xb7595f68]
[  3644.665] (EE) 
[  3644.665] (EE) Segmentation fault at address 0x1470a0
[  3644.665] (EE) 
Fatal server error:
[  3644.666] (EE) Caught signal 11 (Segmentation fault). Server aborting
[  3644.666] (EE) 
[  3644.666] (EE) 
Please consult the The X.Org Foundation support 
	 at http://wiki.x.org
 for help. 
[  3644.666] (EE) Please also check the log file at "/var/log/Xorg.0.log" for additional information.
[  3644.666] (EE) 
[  3644.666] (II) AIGLX: Suspending AIGLX clients for VT switch
[  3644.681] (EE) Server terminated with error (1). Closing log file.
