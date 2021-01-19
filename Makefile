DIR_FONTS = ./Fonts
DIR_OBJ = ./obj
DIR_BIN = ./bin

OBJ_C = $(wildcard ${DIR_FONTS}/*.c ${DIR_OBJ}/*.c)
OBJ_O = $(patsubst %.c,${DIR_BIN}/%.o,$(notdir ${OBJ_C}))

TARGET = main
#BIN_TARGET = ${DIR_BIN}/${TARGET}

CC = gcc

DEBUG = -g -O0 -Wall
CFLAGS += $(DEBUG) -fpic

USELIB = USE_BCM2835_LIB
# USELIB = USE_WIRINGPI_LIB
# USELIB = USE_DEV_LIB
DEBUG = -D $(USELIB)
ifeq ($(USELIB), USE_BCM2835_LIB)
    LIB = -lbcm2835 -lm 
else ifeq ($(USELIB), USE_WIRINGPI_LIB)
    LIB = -lwiringPi -lm 
else 
    LIB = -lm 
endif

${TARGET}: ${OBJ_O}
	$(CC) $(CFLAGS) $(OBJ_O) -o $@ $(LIB)

${DIR_BIN}/%.o: $(DIR_OBJ)/%.c
	$(CC) $(CFLAGS) -c  $< -o $@ $(LIB)

${DIR_BIN}/%.o: $(DIR_FONTS)/%.c
	$(CC) $(CFLAGS) -c  $< -o $@ 
	
clean:
	$(RM) $(DIR_BIN)/*.* $(TARGET) $(DIR_OBJ)/.*.sw?

shared:
	$(CC) -shared -o $(DIR_BIN)/liboled.so \
		$(DIR_BIN)/DEV_Config.o \
		$(DIR_BIN)/dev_hardware_SPI.o \
		$(DIR_BIN)/dev_hardware_i2c.o \
		$(DIR_BIN)/OLED_Driver.o \
		$(DIR_BIN)/OLED_GUI.o \
		$(DIR_BIN)/font8.o \
		$(DIR_BIN)/font12.o \
		$(DIR_BIN)/font16.o \
		$(DIR_BIN)/font20.o \
		$(DIR_BIN)/font24.o \
		-lbcm2835 -lm
