#ifndef _ALPHABLENDING_H  
#define _ALPHABLENDING_H

#include "basicplugin.h"

class AlphaBlending : public QObject, public BasicPlugin
 {
     Q_OBJECT
#if QT_VERSION >= 0x050000
     Q_PLUGIN_METADATA(IID "BasicPlugin")   
#endif
     Q_INTERFACES(BasicPlugin)

 public:
    void preFrame();
    void postFrame();
 };
 
 #endif
 
 
