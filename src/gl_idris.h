#ifndef __GL_IDRIS_H
#define __GL_IDRIS_H

#include <idris_rts.h>

void* idr_glfw_create_window(char* title, int width, int height);

int idr_glGenVertexArrays();
void idr_glDeleteVertexArrays(int id);

int idr_glGenBuffers();
int idr_glDeleteBuffers(int id);

void idr_glVertexAttribPointer(int index, int size, int type, int normalized, int stride, int offset);

char* idr_glGetString(int name);

int idr_sizeof_doubles(int len);
void* idr_allocate_doubles(int len);
void idr_set_double(void* buf, int idx, double val);

void idr_glShaderSource(int id, void* source);

void idr_main_loop();

int idr_init_glew();



#endif
