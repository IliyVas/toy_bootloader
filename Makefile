AS=as
CC=gcc
BUILD_DIR=bin
BIN=$(BUILD_DIR)/mbr.bin
C_OBJ_DIR=$(BUILD_DIR)/c_obj
S_OBJ_DIR=$(BUILD_DIR)/s_obj
SRC_DIR=src
ASFLAGS=--32 -march=i386
CCFLAGS=-c -Os -ffreestanding -Wall -m16 -march=i386 
CCFLAGS+= -fomit-frame-pointer -fno-stack-protector -mpreferred-stack-boundary=2
LDFLAGS=-static -nostdlib -melf_i386

C_FILES:=$(wildcard $(SRC_DIR)/*.c)
H_FILES:=$(wildcard $(SRC_DIR)/*.h)
S_FILES:=$(wildcard $(SRC_DIR)/*.S)

C_OBJ_FILES:=$(addprefix $(C_OBJ_DIR)/,$(notdir $(C_FILES:.c=.o)))
S_OBJ_FILES:=$(addprefix $(S_OBJ_DIR)/,$(notdir $(S_FILES:.S=.o)))


.PHONY: all
all: $(BIN)

$(S_OBJ_DIR)/%.o: $(SRC_DIR)/%.S $(H_FILES)
	$(AS) $(ASFLAGS) $< -o $@

$(C_OBJ_DIR)/%.o: $(SRC_DIR)/%.c $(H_FILES)
	$(CC) $(CCFLAGS) $< -o $@

$(BIN): $(S_OBJ_FILES) $(C_OBJ_FILES)
	ld $(LDFLAGS) -T $(SRC_DIR)/bootloader.ld $^ -o $(@:.bin=.elf) 
	objcopy -O binary $(@:.bin=.elf) $@

.PHONY: run_bochs
run_bochs: all
	bochs

.PHONY: run_qemu
run_qemu: all
	qemu-system-x86_64 -m 512 -hda $(BIN)

.PHONY: clean
clean:
	rm -rf $(BUILD_DIR)

$(info $(shell mkdir -p $(BUILD_DIR)/s_obj $(BUILD_DIR)/c_obj))
