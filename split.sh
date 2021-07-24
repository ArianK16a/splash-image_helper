if [ ! -d "split" ]; then
	mkdir split
fi

dd skip=0 count=16384 ibs=1 if=splash.img of=split/00_prefix.img
dd skip=16384 count=6998454 ibs=1 if=splash.img of=split/01_boot-locked.bmp
dd skip=7014838 count=2 ibs=1 if=splash.img of=split/empty.img
dd skip=7014840 count=6220854 ibs=1 if=splash.img of=split/02_bootloader.bmp
dd skip=13235694 count=6998454 ibs=1 if=splash.img of=split/03_system-destroyed.bmp
dd skip=20234148 count=6998454 ibs=1 if=splash.img of=split/04_boot-unlocked.bmp
dd skip=27232602 count=39876262 ibs=1 if=splash.img of=split/05_suffix.img
