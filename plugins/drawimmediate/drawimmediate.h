#ifndef _DRAWIMMEDIATE_H
#define _DRAWIMMEDIATE_H

#include "basicplugin.h"

 class DrawImmediate : public QObject, public BasicPlugin
 {
     Q_OBJECT
     Q_INTERFACES(BasicPlugin)  

 public:
     bool drawScene();
 };
 
 #endif
 
 
