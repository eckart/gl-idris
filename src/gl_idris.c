#include <stdio.h>
#include <idris_rts.h>
#include <GL/glew.h>
#include <GLFW/glfw3.h>
#include <png.h>

// -------------------------------------------------------------- [ buffers ]


void idr_buffers_set_double(void* buf, int index, double val) {
  double* buffer = (double*) buf;
  buffer[index] = val;
}

void* idr_buffers_double_buffer(int len) {
  double* buf = malloc(len*sizeof(double));
  return (void*) buf;
}

int idr_buffers_double_size() {
  return sizeof(double);
}


void idr_buffers_set_float(void* buf, int index, double val) {
  float* buffer = (float*) buf;
  float fval = val;
  buffer[index] = fval;
}

void* idr_buffers_float_buffer(int len) {
  float* buf = malloc(len*sizeof(float));
  return (void*) buf;
}

int idr_buffers_float_size() {
  return sizeof(float);
}


void idr_buffers_set_string(void* buf, int index, const char* str) {
  char** buffer = (char**) buf;
  buffer[index] = malloc((strlen(str)+1)*sizeof(char));
  strcpy(buffer[index], str);
}

void* idr_buffers_string_buffer(int len) {
  char** buf = malloc(len*sizeof(char*));
  return (void*) buf;
}

void idr_buffers_free_string_buffer(void* buf, int len) {
  char** buffer = (char**) buf;
  for (int i = 0; i < len; i++) {
    free(buffer[i]);
  }
  free(buffer);
}

void idr_buffers_set_int(void* buf, int index, int val) {
  int* buffer = (int*) buf;
  buffer[index] = val;
}

int idr_buffers_read_int(void* buf, int index) {
  int* buffer = (int*) buf;
  return buffer[index];
}

void* idr_buffers_int_buffer(int len) {
  int* buf = malloc(len*sizeof(int));
  return (void*) buf;
}


// -------------------------------------------------------------- [ old functions ]


int idr_sizeof_doubles(int len) {
  return len * sizeof(double);
}

void* idr_allocate_doubles(int len) {
  double* buf = malloc(len*sizeof(double));
  return (void*) buf;
}

void idr_set_double(void* buf, int idx, double val) {
  double* buffer = (double*) buf;
  buffer[idx] = val;
}


void* idr_allocate_floats(int len) {
  double* buf = malloc(len*sizeof(float));
  return (void*) buf;
}

void idr_set_float(void* buf, int idx, double val) {
  float* buffer = (float*) buf;
  float f = val;
  buffer[idx] = f;
}


int idr_sizeof_ints(int len) {
  return len * sizeof(int);
}

void* idr_allocate_ints(int len) {
  double* buf = malloc(len*sizeof(int));
  return (void*) buf;
}

void idr_set_int(void* buf, int idx, int val) {
  int* buffer = (int*) buf;
  buffer[idx] = val;
}

// -------------------------------------------------------------------


void* idr_glfw_create_window(char* title, int width, int height) {

  if (!glfwInit ()) {
    fprintf (stderr, "ERROR: could not start GLFW3\n");
    return NULL;
  }

  // for mac only?
  glfwWindowHint (GLFW_CONTEXT_VERSION_MAJOR, 4);
  glfwWindowHint (GLFW_CONTEXT_VERSION_MINOR, 1);
  glfwWindowHint (GLFW_OPENGL_FORWARD_COMPAT, GL_TRUE);
  glfwWindowHint (GLFW_OPENGL_PROFILE, GLFW_OPENGL_CORE_PROFILE);

  GLFWwindow* window = glfwCreateWindow (width, height, title, NULL, NULL);
  if (!window) {
    fprintf (stderr, "ERROR: could not open window with GLFW3\n");
    glfwTerminate();
    return NULL;
  }
  glfwMakeContextCurrent (window);

  // initialise glew
  glewExperimental = GL_TRUE;
  glewInit ();

  // get version info
  const GLubyte* renderer = glGetString (GL_RENDERER); // get renderer string
  const GLubyte* version = glGetString (GL_VERSION); // version as a string
  printf ("Renderer: %s\n", renderer);
  printf ("OpenGL version supported %s\n", version);

  // tell GL to only draw onto a pixel if the shape is closer to the viewer
  glEnable (GL_DEPTH_TEST); // enable depth-testing
  glDepthFunc (GL_LESS); // depth-testing interprets a smaller value as "closer"
  
  return window;
}

void idr_glVertexAttribPointer(int index, int size, int type, int normalized, int stride, int offset) {
  GLboolean norm;
  if (norm == 1) {
    norm = GL_TRUE;
  } else {
    norm = GL_FALSE;
  }
  glVertexAttribPointer(
			(GLuint) index,
			(GLint) size,
			(GLenum) type,
			norm,
			(GLsizei) stride,
			(GLvoid*) offset // this will produce a warning that can be ignored (I hope)
			);
}


char* idr_glGetString(int name) {
  return (char*) glGetString(name);
}

int idr_init_glew() {
  glewExperimental = GL_TRUE;
  return glewInit ();
}

int idr_glGenVertexArrays() {
  GLuint id;
  glGenVertexArrays(1, &id);
  return id;
}

void idr_glDeleteVertexArrays(int id) {
  GLuint vaoId = id;
  glDeleteVertexArrays(1, &vaoId);
}

void idr_glDeleteBuffers(int id) {
  GLuint bufferId = id;
  glDeleteBuffers(1, &bufferId);
}

int idr_glGenBuffers() {
  GLuint id;
  glGenBuffers(1, &id);
  return id;
}

void idr_glDrawElements(int mode, int size) {
  glDrawElements(mode, size, GL_UNSIGNED_INT, 0);
}

void idr_glShaderSource(int id, void* source) {
  const GLchar* s = (GLchar*) source;
  glShaderSource(id, 1, &s, NULL);		    
}

void idr_glUniformMatrix4fv(int location, void* buffer) {
  GLuint loc = (GLuint) location;
  double* buff = (double*) buffer;
  
  float* mat = malloc(16*sizeof(float));
  for (int i = 0; i < 16; i++) {
    mat[i] = buff[i];
  }

  glUniformMatrix4fv(loc, 1, GL_FALSE, mat);
  free(mat);
}

void idr_glUniform3fv(int location, void* buffer) {
  GLuint loc = (GLuint) location;
  float* buff = (float*) buffer;
  glUniform3fv(loc, 1, buff);
}

void idr_glUniform1f(int loc, double val) {
  float v = val;
  glUniform1f(loc, v);  
}


// only for testing!
void idr_main_loop(void* win) {
  GLFWwindow* window = (GLFWwindow*) win;
  while(!glfwWindowShouldClose(window)) {

    //glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);
    glClear(GL_COLOR_BUFFER_BIT);
    glClear(GL_DEPTH_BUFFER_BIT);
  
    glDrawArrays(GL_TRIANGLES, 0, 3);

    glfwSwapBuffers(window);
 
    // Pool for events
    glfwPollEvents();

  }
}

GLuint png_texture_load(const char * file_name)
{
  int* width;
  int * height;
    // This function was originally written by David Grayson for
    // https://github.com/DavidEGrayson/ahrs-visualizer
  printf("loading texture %s \n", file_name);

    png_byte header[8];

    FILE *fp = fopen(file_name, "rb");
    if (fp == 0)
    {
        perror(file_name);
        return 0;
    }

    // read the header
    fread(header, 1, 8, fp);

    if (png_sig_cmp(header, 0, 8))
    {
        fprintf(stderr, "error: %s is not a PNG.\n", file_name);
        fclose(fp);
        return 0;
    }

    png_structp png_ptr = png_create_read_struct(PNG_LIBPNG_VER_STRING, NULL, NULL, NULL);
    if (!png_ptr)
    {
        fprintf(stderr, "error: png_create_read_struct returned 0.\n");
        fclose(fp);
        return 0;
    }

    // create png info struct
    png_infop info_ptr = png_create_info_struct(png_ptr);
    if (!info_ptr)
    {
        fprintf(stderr, "error: png_create_info_struct returned 0.\n");
        png_destroy_read_struct(&png_ptr, (png_infopp)NULL, (png_infopp)NULL);
        fclose(fp);
        return 0;
    }

    // create png info struct
    png_infop end_info = png_create_info_struct(png_ptr);
    if (!end_info)
    {
        fprintf(stderr, "error: png_create_info_struct returned 0.\n");
        png_destroy_read_struct(&png_ptr, &info_ptr, (png_infopp) NULL);
        fclose(fp);
        return 0;
    }

    // the code in this if statement gets called if libpng encounters an error
    if (setjmp(png_jmpbuf(png_ptr))) {
        fprintf(stderr, "error from libpng\n");
        png_destroy_read_struct(&png_ptr, &info_ptr, &end_info);
        fclose(fp);
        return 0;
    }

    // init png reading
    png_init_io(png_ptr, fp);

    // let libpng know you already read the first 8 bytes
    png_set_sig_bytes(png_ptr, 8);

    // read all the info up to the image data
    png_read_info(png_ptr, info_ptr);

    // variables to pass to get info
    int bit_depth, color_type;
    png_uint_32 temp_width, temp_height;

    // get info about png
    png_get_IHDR(png_ptr, info_ptr, &temp_width, &temp_height, &bit_depth, &color_type,
        NULL, NULL, NULL);

    if (width){ *width = temp_width; }
    if (height){ *height = temp_height; }

    //printf("%s: %lux%lu %d\n", file_name, temp_width, temp_height, color_type);

    if (bit_depth != 8)
    {
        fprintf(stderr, "%s: Unsupported bit depth %d.  Must be 8.\n", file_name, bit_depth);
        return 0;
    }

    GLint format;
    switch(color_type)
    {
    case PNG_COLOR_TYPE_RGB:
        format = GL_RGB;
        break;
    case PNG_COLOR_TYPE_RGB_ALPHA:
        format = GL_RGBA;
        break;
    default:
        fprintf(stderr, "%s: Unknown libpng color type %d.\n", file_name, color_type);
        return 0;
    }

    // Update the png info struct.
    png_read_update_info(png_ptr, info_ptr);

    // Row size in bytes.
    int rowbytes = png_get_rowbytes(png_ptr, info_ptr);

    // glTexImage2d requires rows to be 4-byte aligned
    rowbytes += 3 - ((rowbytes-1) % 4);

    // Allocate the image_data as a big block, to be given to opengl
    png_byte * image_data = (png_byte *)malloc(rowbytes * temp_height * sizeof(png_byte)+15);
    if (image_data == NULL)
    {
        fprintf(stderr, "error: could not allocate memory for PNG image data\n");
        png_destroy_read_struct(&png_ptr, &info_ptr, &end_info);
        fclose(fp);
        return 0;
    }

    // row_pointers is for pointing to image_data for reading the png with libpng
    png_byte ** row_pointers = (png_byte **)malloc(temp_height * sizeof(png_byte *));
    if (row_pointers == NULL)
    {
        fprintf(stderr, "error: could not allocate memory for PNG row pointers\n");
        png_destroy_read_struct(&png_ptr, &info_ptr, &end_info);
        free(image_data);
        fclose(fp);
        return 0;
    }

    // set the individual row_pointers to point at the correct offsets of image_data
    for (unsigned int i = 0; i < temp_height; i++)
    {
        row_pointers[temp_height - 1 - i] = image_data + i * rowbytes;
    }

    // read the png into image_data through row_pointers
    png_read_image(png_ptr, row_pointers);

    // Generate the OpenGL texture object
    GLuint texture;
    glGenTextures(1, &texture);
    glBindTexture(GL_TEXTURE_2D, texture);
    glTexImage2D(GL_TEXTURE_2D, 0, format, temp_width, temp_height, 0, format, GL_UNSIGNED_BYTE, image_data);
    //glTexParameterf(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_NEAREST);
    //glTexParameterf(GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, GL_NEAREST);

    // clean up
    png_destroy_read_struct(&png_ptr, &info_ptr, &end_info);
    free(image_data);
    free(row_pointers);
    fclose(fp);

    printf("texture loaded %s - texture id %d\n", file_name, texture);
    return texture;
}


void printShaderLog(int shaderId) {
  GLuint id = (GLuint) shaderId;
    GLint result;
    glGetShaderiv(id, GL_COMPILE_STATUS, &result );
    if( GL_FALSE == result ) {
       fprintf( stderr, "Shader compilation failed!\n" );

       GLint logLen;
       glGetShaderiv(id, GL_INFO_LOG_LENGTH, &logLen );

       if (logLen > 0) {
           char * log = (char *)malloc(logLen);

           GLsizei written;
           glGetShaderInfoLog(id, logLen, &written, log);

           fprintf(stderr, "Shader log: \n%s", log);

           free(log);
       }
    } else {
      printf("shader sucessfully compiled\n");
    }
}
