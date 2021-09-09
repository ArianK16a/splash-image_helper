if [ ! -d "TP1803" ]; then
	mkdir TP1803
fi

SPLASH_BIN="TP1803_splash.bin"

dd skip=0 count=16384 ibs=1 if=${SPLASH_BIN} of=TP1803/prefix.bin
dd skip=16384 count=6998454 ibs=1 if=${SPLASH_BIN} of=TP1803/boot.bmp
dd skip=7014838 count=27211338 ibs=1 if=${SPLASH_BIN} of=TP1803/suffix.bin

#DECIMAL       HEXADECIMAL     DESCRIPTION
#--------------------------------------------------------------------------------
#16384         0x4000          PC bitmap, Windows 3.x format,, 1080 x 2160 x 24
