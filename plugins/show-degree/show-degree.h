#ifndef _SHOWDEGREE_H  
#define _SHOWDEGREE_H

#include "basicplugin.h"

class ShowDegree : public QObject, public BasicPlugin {

  Q_OBJECT
#if QT_VERSION >= 0x050000
  Q_PLUGIN_METADATA(IID "BasicPlugin")   
#endif
  Q_INTERFACES(BasicPlugin)

  void calcGrauMig();
  void drawRect();
  
  double grau_mig;

  GLuint textureID;
  QGLShaderProgram* program;
  QGLShader* vs;
  QGLShader* fs;

public:
  void onPluginLoad();
  void postFrame();
};

#endif


