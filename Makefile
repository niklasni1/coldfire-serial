AS=m68k-elf-as
LD=m68k-elf-ld
AS_OPTS=--bitwise-or
CPU=5206e
OBJ=serial.o main.o system.o uart.o

%.o: %.s 
	${AS} ${AS_OPTS} -mcpu=${CPU} -o $@ $<

serial.elf: ${OBJ}
	${LD} -T linker.lds -o $@ $^

clean:
	rm *.o serial.elf
