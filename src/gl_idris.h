#ifndef __GL_IDRIS_H
#define __GL_IDRIS_H

#include <idris_rts.h>

void* idr_glfw_create_window(char* title, int width, int height);

int idr_glGenVertexArrays();

int idr_glGenBuffers();

int idr_sizeof_doubles(int len);
void* idr_allocate_doubles(int len);
void idr_set_double(void* buf, int idx, double val) {
  
#endif
