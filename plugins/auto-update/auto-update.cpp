#include "auto-update.h"
#include "glwidget.h"

void AutoUpdate::onPluginLoad()
{
	QTimer *timer = new QTimer(this);
	connect(timer, SIGNAL(timeout()), glwidget(), SLOT(updateGL()));
	timer->start();
}

Q_EXPORT_PLUGIN2(auto-update, AutoUpdate)   // plugin name, plugin class
