This repository includes scripts to split the splash image of Mi A2 and concatenate
it's components.

### How to use ###
Pull splash.img from your device:
`adb pull /dev/block/bootdevice/by-name/splash splash.img`

**split.sh** can divide ./splash.img into 7 parts:  
`split/00_prefix.img`: A prefix before the images  
`split/01_boot-locked.bmp`: A bitmap, shown on boot with locked bootloader  
`split/empty.img`: Some ~useless~ 2 bit  
`split/02_bootloader.bmp`: A bitmap, shown in fastboot/bootloader  
`split/03_system-destroyed.bmp`: A bitmap, shown when the system is destroyed  
`split/04_boot-unlocked.bmp`: A bitmap, shown on boot with unlocked bootloader  
`split/05_suffix.img`: A suffix after the images  

**merge.sh** can concatenate the splitted parts to a flashable image.
It can be flashed like this: `fastboot flash splash newsplash.img`

### Where do the offsets come from? ###
The offsets have been determined with the help of https://github.com/ReFirmLabs/binwalk.

The output for Mi A2 is:

```
$ binwalk splash.img

DECIMAL       HEXADECIMAL     DESCRIPTION
--------------------------------------------------------------------------------
16384         0x4000          PC bitmap, Windows 3.x format,, 1080 x 2160 x 24
7014840       0x6B09B8        PC bitmap, Windows 3.x format,, 1080 x 1920 x 24
13235694      0xC9F5EE        PC bitmap, Windows 3.x format,, 1080 x 2160 x 24
20234148      0x134BFA4       PC bitmap, Windows 3.x format,, 1080 x 2160 x 24
```

The first column tells us where the images start. The length of the images can be
calculated with the information given in the last collumn:
*horizontal * vertical * bit_depth / 8 + bitmap_offset = filesize*

Example for an 1080 x 2160 x 24 image:
1080 * 2160 * 24 / 8 + 54 = 6998454

### Replace images and generate splash.img ###
If you want to replace some of the images, you need to make sure that the file type,
resolution, bit depth and file size exactly match the original image. This is pretty
easy due to the constant size of bitmaps.

**NOTE:** You might need to disable writing color space information to match to
original size. In GIMP you can remove it: *File -> Export as... -> Select a location
-> Export -> Compatibility Options -> Enable "Do not write color space information"*.

If you managed to get your images into the correct format you just need to replace
the original images in ./split with your ones and run `merge.sh`.
**Ensure that the original naming is retained!**
After this you can flash the generated splash image:
`fastboot flash splash newsplash.img`
