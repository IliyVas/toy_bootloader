.code16
.text
    .globl set_color_mod;
    .globl clear_scr_set_color;
    .globl print_str;


set_color_mod:
    movb $0x03, %al     # 80x25 color mod
    movb $0x00, %ah
    int  $0x10
    ret


clear_scr_set_color:
    push %ebp
    mov %esp, %ebp

    # Clear screen using scroll
    movw $0x0600, %ax
    
    # Set Color
    push %ebx
    xorw %bx, %bx
    movb 0x08(%bp), %bh
    shlb $0x04, %bh
    orb 0x0c(%bp), %bh
    
    # Upper left corner
    xorw %cx, %cx
    
    # Bottom right corner (24, 79)
    movw $0x184f, %dx

    int $0x10

    pop %ebx
    pop %ebp
    ret


print_str:
    # Set str pointer
    push %ebp
    mov 0x08(%esp), %eax    # Function 1st arg
    movw %ax, %bp
    shr $0x10, %eax
    movw %ax, %es           # I can xor es as 16-bit address expected, can't I?

    # Set str length
    movw 0x0c(%esp), %cx    # Function 2nd arg

    # Set column and row to 0
    xor %edx, %edx

    # Set color 
    push %ebx
    xor %ebx, %ebx          # Page 0
    movb 0x14(%esp), %bl    # Function 3d arg

    # Write str and update cursor
    movw $0x1301, %ax

    int $0x10

    pop %ebx
    pop %ebp
    ret
