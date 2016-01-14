#ifndef _RENDERDEFAULT_H
#define _RENDERDEFAULT_H

#include "basicplugin.h"

 class RenderDefault : public QObject, public BasicPlugin
 {
     Q_OBJECT
#if QT_VERSION >= 0x050000
     Q_PLUGIN_METADATA(IID "BasicPlugin")   
#endif
     Q_INTERFACES(BasicPlugin)

 public:
     bool paintGL();
 };
 
 #endif
 
 
