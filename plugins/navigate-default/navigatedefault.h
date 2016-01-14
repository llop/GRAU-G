#ifndef _NAVIGATEDEFAULT_H
#define _NAVIGATEDEFAULT_H

#include "basicplugin.h"

class NavigateDefault : public QObject, public BasicPlugin
 {
     Q_OBJECT
#if QT_VERSION >= 0x050000
     Q_PLUGIN_METADATA(IID "BasicPlugin")   
#endif
     Q_INTERFACES(BasicPlugin)

 public:
    NavigateDefault();
 
    void	keyPressEvent ( QKeyEvent *  ) {};
    void	keyReleaseEvent ( QKeyEvent *  ) {};
    
    void	mouseMoveEvent ( QMouseEvent * event );
    void	mousePressEvent ( QMouseEvent * event );
    void	mouseReleaseEvent ( QMouseEvent * event );
    void	wheelEvent ( QWheelEvent *  ) {};
 
 private:
    typedef  enum {NONE, ROTATE, ZOOM, PAN} MouseAction;
    MouseAction pmouseAction;
    int   pxClick, pyClick;
 };
 
 #endif
 
 
