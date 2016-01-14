#include "effectcrt.h"

void EffectCRT::onPluginLoad()
{
    // Carregar shader, compile & link 
    QString vs_src = "#version 330 core\nuniform mat4 modelViewProjectionMatrix; in vec3 vertex; in vec3 color; out vec4 col; void main() { 	gl_Position    = modelViewProjectionMatrix * vec4(vertex,1.0); col=vec4(color,1.0);}";
    vs = new QGLShader(QGLShader::Vertex, this);
    vs->compileSourceCode(vs_src);
    cout << "VS log:" << vs->log().toStdString() << endl;

    QString fs_src = "#version 330 core\nout vec4 fragColor; in vec4 col; uniform int n; void main() {if (mod((gl_FragCoord.y-0.5), float(n)) > 0.0) discard; fragColor=col;}";
    fs = new QGLShader(QGLShader::Fragment, this);
    fs->compileSourceCode(fs_src);
    cout << "FS log:" << fs->log().toStdString() << endl;

    program = new QGLShaderProgram(this);
    program->addShader(vs);
    program->addShader(fs);
    program->link();
    cout << "Link log:" << program->log().toStdString() << endl;
}

void EffectCRT::preFrame() 
{
    // bind shader and define uniforms
    program->bind();
    program->setUniformValue("n", 6);
    QMatrix4x4 MVP = camera()->projectionMatrix() * camera()->modelviewMatrix();
    program->setUniformValue("modelViewProjectionMatrix", MVP); 
}

void EffectCRT::postFrame() 
{
    // unbind shader
    program->release();
}

#if QT_VERSION < 0x050000
Q_EXPORT_PLUGIN2(effectcrt, EffectCRT)   // plugin name, plugin class
#endif

