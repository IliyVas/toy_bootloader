#ifndef VIDEO_TEXT_UTIL_H
#define VIDEO_TEXT_UTIL_H

typedef unsigned char u8;

#define TEXTMOD_BLACK ((u8)0x0)
#define TEXTMOD_RED ((u8)0x4)

void set_color_mod(); // It clears screen too

__attribute__((cdecl))
void clear_scr_set_color(u8 bg_color, u8 text_color);

__attribute__((cdecl))
void print_str(const char *str, unsigned short len, u8 text_color);

#endif
