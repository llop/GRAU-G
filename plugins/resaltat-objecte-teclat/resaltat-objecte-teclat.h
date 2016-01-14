#ifndef _RESALTAT_OBJECTE_TECLAT_H  
#define _RESALTAT_OBJECTE_TECLAT_H

#include "basicplugin.h"

class ResaltatObjecteTeclat : public QObject, public BasicPlugin {

  Q_OBJECT
#if QT_VERSION >= 0x050000
  Q_PLUGIN_METADATA(IID "BasicPlugin")   
#endif
  Q_INTERFACES(BasicPlugin)

  void createBuffers();
  void generate_vbo(GLuint &vbo_id, GLsizeiptr size, const GLfloat *data, GLuint attribute_id, GLint attribute_size);
  void drawSelectedBox();

  void setSelectedObject(int selected);

  GLuint textureID;
  QGLShaderProgram* program;
  QGLShader* vs;
  QGLShader* fs;

  bool created;
  GLuint cubeVAO;
  GLuint verticesVBO;
  GLuint colorVBO;

public:
  void onPluginLoad();
  void postFrame();
  void keyPressEvent(QKeyEvent* e); 

};

#endif


