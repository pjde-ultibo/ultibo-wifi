rem for a Pi3
rem arm-none-eabi-gcc -DUltibo -D_POSIX_THREADS -O2 -mabi=aapcs -marm -march=armv7-a -mfpu=vfpv3-d16 -mfloat-abi=hard -Iwhd -D__DYNAMIC_REENT__ -c srce/*.c
rem for a PiZero 
arm-none-eabi-gcc -O2 -mabi=aapcs -marm -march=armv6 -mfpu=vfp -mfloat-abi=hard -Iwhd -D__DYNAMIC_REENT__ -c srce/*.c
arm-none-eabi-ar rcs ..\libwifi.a *.o