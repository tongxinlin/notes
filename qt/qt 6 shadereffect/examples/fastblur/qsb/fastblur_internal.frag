#version 440

layout(location = 0) in vec2 qt_TexCoord0;
layout(location = 1) in vec2 qt_TexCoord1;
layout(location = 2) in vec2 qt_TexCoord2;
layout(location = 3) in vec2 qt_TexCoord3;
layout(location = 0) out vec4 fragColor;

layout(std140, binding = 0) uniform buf {
    mat4 qt_Matrix;
    float qt_Opacity;
    float xStep;
    float yStep;
};

layout(binding = 1) uniform sampler2D source;

void main()
{
    vec4 sourceColor = (texture(source, qt_TexCoord0) +
                        texture(source, qt_TexCoord1) +
                        texture(source, qt_TexCoord2) +
                        texture(source, qt_TexCoord3)) * 0.25;
    fragColor = sourceColor * qt_Opacity;
}

//uniform lowp sampler2D source;
//uniform lowp float qt_Opacity;
//varying highp vec2 qt_TexCoord0;
//varying highp vec2 qt_TexCoord1;
//varying highp vec2 qt_TexCoord2;
//varying highp vec2 qt_TexCoord3;

//void main() {
//    highp vec4 sourceColor = (texture2D(source, qt_TexCoord0) +
//    texture2D(source, qt_TexCoord1) +
//    texture2D(source, qt_TexCoord2) +
//    texture2D(source, qt_TexCoord3)) * 0.25;
//    gl_FragColor = sourceColor * qt_Opacity;
//}
