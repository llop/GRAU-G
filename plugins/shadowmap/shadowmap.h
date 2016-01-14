#ifndef _SHADOWMAP_H
#define _SHADOWMAP_H

#include "basicplugin.h"
#include <QGLShader>
#include <QGLShaderProgram>


class ShadowMap : public QObject, public BasicPlugin
 {
     Q_OBJECT
     Q_INTERFACES(BasicPlugin)

 public:
    void onPluginLoad();
    bool paintGL();
    void keyPressEvent(QKeyEvent*);   
 
 private:
    QGLShaderProgram* program;
    QGLShader* vs;
    QGLShader* fs;  
    GLuint textureId;
    Camera lightCamera;
 };
 
 #endif
