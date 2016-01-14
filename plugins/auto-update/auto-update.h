#ifndef _AUTO_UPDATE_H
#define _AUTO_UPDATE_H

#include "basicplugin.h"

class AutoUpdate : public QObject, public BasicPlugin
 {
     Q_OBJECT
     Q_INTERFACES(BasicPlugin)

 public:
    virtual void onPluginLoad();	    
 
 };
 
 #endif
 
 
