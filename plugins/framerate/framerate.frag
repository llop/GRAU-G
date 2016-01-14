#version 330 core
out vec4 fragColor;

uniform sampler2D colorMap;
uniform float WIDTH;
uniform float HEIGHT;

void main()
{
    vec2 st = (gl_FragCoord.xy - vec2(0.5)) / vec2(WIDTH, HEIGHT);
      
    fragColor = texture(colorMap, st);

    if (all(equal(fragColor.rgb,vec3(1.0)))) discard;
    
}

