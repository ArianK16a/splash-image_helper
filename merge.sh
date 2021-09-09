echo "merging splash screen for ${1}"
cat ${1}/prefix.bin ${1}/boot.bmp ${1}/suffix.bin > ${1}_newsplash.bin
