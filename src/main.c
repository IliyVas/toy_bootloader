#include "video_text_util.h"

#define CMPL_TIME_STR_LEN(str) ((sizeof(str) / sizeof(str[0])) - 1)


void main() {
    set_color_mod();
    clear_scr_set_color(TEXTMOD_BLACK, TEXTMOD_RED);

    char hello[] = "HELLO";
    print_str(hello, CMPL_TIME_STR_LEN(hello), TEXTMOD_RED);

    for(;;) {}
}
