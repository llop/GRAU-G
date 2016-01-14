#ifndef _REFLECTION_H
#define _REFLECTION_H

#include "basicplugin.h"
#include <QGLShader>
#include <QGLShaderProgram>

class Reflection : public QObject, public BasicPlugin {
  Q_OBJECT
  Q_INTERFACES(BasicPlugin)

public:
  void onPluginLoad();
  bool paintGL();
 
private:
  QGLShaderProgram* program;
  QGLShader* vs;
  QGLShader* fs;  
  GLuint textureId;
};

#endif
