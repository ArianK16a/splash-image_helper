if [ ! -d "NX627J" ]; then
	mkdir NX627J
fi

SPLASH_BIN="NX627J_splash.bin"

dd skip=0 count=16384 ibs=1 if=${SPLASH_BIN} of=NX627J/prefix.bin
dd skip=16384 count=7581654 ibs=1 if=${SPLASH_BIN} of=NX627J/boot.bmp
dd skip=7598038 count=2 ibs=1 if=${SPLASH_BIN} of=NX627J/suffix.bin

#DECIMAL       HEXADECIMAL     DESCRIPTION
#--------------------------------------------------------------------------------
#16384         0x4000          PC bitmap, Windows 3.x format,, 1080 x 2340 x 24
#322428        0x4EB7C         Intel x86 or x64 microcode, sig 0x03030317, pf_mask 0x1e1e1e0d, 1E1E-17-17, rev 0x1e131313, size 1028
