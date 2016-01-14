uniform sampler2D colorMap;

uniform float SIZE;

const int W = 20; // filter size: 2W*2W

void main()
{
    vec2 st = (gl_FragCoord.xy - vec2(0.5)) / SIZE;
    float a = 1.0/SIZE;

    vec4 sum=vec4(0.0);
    float count = 0.0;
    for (int i=-W; i<W; ++i)
    for (int j=-W; j<W; ++j)
    {
        vec4 tmp = texture2D(colorMap, st+vec2(a*float(i), a*float(j)));
        if (length(tmp.rgb)>0.0) // assumes background is black 
        {
            float w = max(0.0, float(W) - length(vec2(float(i), float(j))));
            count += w;
            sum += w*tmp;
        } 
    }
    sum /= count;
    sum = pow(sum, vec4(5.0));
        
    gl_FragColor = mix(texture2D(colorMap, st), sum, 0.8);
    
}

