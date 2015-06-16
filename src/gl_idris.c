#include <stdio.h>
#include <idris_rts.h>
#include <GL/glew.h>
#include <GLFW/glfw3.h>

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

int idr_glGenVertexArrays() {
  GLuint id;
  glGenVertexArrays(1, &id);
  return id;
}

int idr_glGenBuffers() {
  GLuint id;
  glGenBuffers(1, &id);
  return id;
}
