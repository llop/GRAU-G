#ifndef _MULTITEX_H
#define _MULTITEX_H

#include "basicplugin.h"
#include <QGLShader>
#include <QGLShaderProgram>


class Multitex : public QObject, public BasicPlugin
 {
     Q_OBJECT
     Q_INTERFACES(BasicPlugin)

 public:
    void onPluginLoad();
    void preFrame();
    void postFrame();
    
 private:
    QGLShaderProgram* program;
    QGLShader* vs;
    QGLShader* fs; 
    GLuint textureId0, textureId1;
 };
 
 #endif
