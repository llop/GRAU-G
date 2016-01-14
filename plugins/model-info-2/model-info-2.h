#ifndef _MODELINFO2_H  
#define _MODELINFO2_H

#include "basicplugin.h"

class ModelInfo2 : public QObject, public BasicPlugin {

  Q_OBJECT
#if QT_VERSION >= 0x050000
  Q_PLUGIN_METADATA(IID "BasicPlugin")   
#endif
  Q_INTERFACES(BasicPlugin)

  void updateModelInfo();
  void drawRect();
  
  int nobj, npol, nver, ntri;

  QString nobj_str;
  QString npol_str;
  QString nver_str;
  QString perc_str;

  GLuint textureID;
  QGLShaderProgram* program;
  QGLShader* vs;
  QGLShader* fs;

public:
  void onPluginLoad();
  void onObjectAdd();
  void postFrame();
};

#endif


