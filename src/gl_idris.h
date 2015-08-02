#ifndef __GL_IDRIS_H
#define __GL_IDRIS_H

#include <idris_rts.h>

// -------------------------------------------------------------- [ buffers ]


// set a double in a buffer
void idr_buffers_set_double(void* buf, int index, double val);

// allocate an empty double buffer of len doubles
void* idr_buffers_double_buffer(int len);

// the size of a double
int idr_buffers_double_size();

// set a double as a float in a buffer
void idr_buffers_set_float(void* buf, int index, double val);

// allocate an empty float buffer of length len
void* idr_buffers_float_buffer(int len);

// the size of a float
int idr_buffers_float_size();


void idr_buffers_set_string(void* buf, int index, const char* str);

void* idr_buffers_string_buffer(int len);

void idr_buffers_free_string_buffer(void* buf, int len);

// set an int in a buffer
void idr_buffers_set_int(void* buf, int index, int val);

// read an int from the buffer
int idr_buffers_read_int(void* buf, int index);

// creates an int buffer
void* idr_buffers_int_buffer(int len);


// -------------------------------------------------------------- [ old functions ]


void* idr_glfw_create_window(char* title, int width, int height);

int idr_glGenVertexArrays();
void idr_glDeleteVertexArrays(int id);

int idr_glGenBuffers();
int idr_glDeleteBuffers(int id);

void idr_glVertexAttribPointer(int index, int size, int type, int normalized, int stride, int offset);

void idr_glDrawElements(int mode, int size);

char* idr_glGetString(int name);

int idr_sizeof_doubles(int len);
void* idr_allocate_doubles(int len);
void idr_set_double(void* buf, int idx, double val);

void* idr_allocate_floats(int len);
void idr_set_float(void* buf, int idx, double val);

int idr_sizeof_ints(int len);
void* idr_allocate_ints(int len);
void idr_set_int(void* buf, int idx, double val);

void idr_glShaderSource(int id, void* source);

void idr_glUniformMatrix4fv(int location, void* buffer);
void idr_glUniform3fv(int location, void* buffer);
void idr_glUniform1f(int location, double val);

GLuint png_texture_load(const char * file_name);

void idr_main_loop();

int idr_init_glew();

void printShaderLog(int shaderId);


#endif
