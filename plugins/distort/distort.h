#ifndef _DISTORT_H
#define _DISTORT_H

#include "basicplugin.h"
#include <QGLShader>
#include <QGLShaderProgram>
#include <QElapsedTimer>

class Distort : public QObject, public BasicPlugin {
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
  QElapsedTimer elapsedTimer;
};
 
#endif
