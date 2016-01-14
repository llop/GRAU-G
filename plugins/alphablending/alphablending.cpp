#include "alphablending.h"
#include "glwidget.h"

void AlphaBlending::preFrame() 
{
    glDisable(GL_DEPTH_TEST);
    glBlendEquation(GL_FUNC_ADD);
    glBlendFunc(GL_SRC_ALPHA, GL_ONE);
    glEnable(GL_CULL_FACE);
    glEnable(GL_BLEND);
}

void AlphaBlending::postFrame() 
{
    glEnable(GL_DEPTH_TEST);
    glDisable(GL_BLEND);
}

#if QT_VERSION < 0x050000
Q_EXPORT_PLUGIN2(alpha-blending, AlphaBlending)   // plugin name, plugin class
#endif

