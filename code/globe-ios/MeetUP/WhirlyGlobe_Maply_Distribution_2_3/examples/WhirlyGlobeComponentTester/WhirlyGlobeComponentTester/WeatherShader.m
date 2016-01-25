/*
 *  WeatherShader.m
 *  WhirlyGlobeComponentTester
 *
 *  Created by Steve Gifford on 9/6/13.
 *  Copyright 2011-2013 mousebird consulting
 *
 *  Licensed under the Apache License, Version 2.0 (the "License");
 *  you may not use this file except in compliance with the License.
 *  You may obtain a copy of the License at
 *  http://www.apache.org/licenses/LICENSE-2.0
 *
 *  Unless required by applicable law or agreed to in writing, software
 *  distributed under the License is distributed on an "AS IS" BASIS,
 *  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 *  See the License for the specific language governing permissions and
 *  limitations under the License.
 *
 */

#import "WeatherShader.h"

@implementation WeatherShader

static const char *vertexShaderTriMultiTex =
"struct directional_light {\n"
"  vec3 direction;\n"
"  vec3 halfplane;\n"
"  vec4 ambient;\n"
"  vec4 diffuse;\n"
"  vec4 specular;\n"
"  float viewdepend;\n"
"};\n"
"\n"
"struct material_properties {\n"
"  vec4 ambient;\n"
"  vec4 diffuse;\n"
"  vec4 specular;\n"
"  float specular_exponent;\n"
"};\n"
"\n"
"uniform mat4  u_mvpMatrix;                   \n"
"uniform float u_fade;                        \n"
"uniform int u_numLights;                      \n"
"uniform directional_light light[8];                     \n"
"uniform material_properties material;       \n"
"uniform float u_interp;"
"\n"
"attribute vec3 a_position;                  \n"
"attribute vec2 a_texCoord0;                  \n"
"attribute vec2 a_texCoord1;                  \n"
"attribute vec4 a_color;                     \n"
"attribute vec3 a_normal;                    \n"
"\n"
"varying vec2 v_texCoord0;                    \n"
"varying vec2 v_texCoord1;                    \n"
"varying vec4 v_color;                       \n"
"\n"
"void main()                                 \n"
"{                                           \n"
"   v_texCoord0 = a_texCoord0;                 \n"
"   v_texCoord1 = a_texCoord1;                 \n"
"   v_color = vec4(0.0,0.0,0.0,0.0);         \n"
"   if (u_numLights > 0)                     \n"
"   {\n"
"     vec4 ambient = vec4(0.0,0.0,0.0,0.0);         \n"
"     vec4 diffuse = vec4(0.0,0.0,0.0,0.0);         \n"
"     for (int ii=0;ii<8;ii++)                 \n"
"     {\n"
"        if (ii>=u_numLights)                  \n"
"           break;                             \n"
"        vec3 adjNorm = light[ii].viewdepend > 0.0 ? normalize((u_mvpMatrix * vec4(a_normal.xyz, 0.0)).xyz) : a_normal.xzy;\n"
"        float ndotl;\n"
//"        float ndoth;\n"
"        ndotl = max(0.0, dot(adjNorm, light[ii].direction));\n"
//"        ndotl = pow(ndotl,0.5);\n"
//"        ndoth = max(0.0, dot(adjNorm, light[ii].halfplane));\n"
"        ambient += light[ii].ambient;\n"
"        diffuse += ndotl * light[ii].diffuse;\n"
"     }\n"
"     v_color = vec4(ambient.xyz * material.ambient.xyz * a_color.xyz + diffuse.xyz * a_color.xyz,a_color.a) * u_fade;\n"
"   } else {\n"
"     v_color = a_color * u_fade;\n"
"   }\n"
"\n"
"   gl_Position = u_mvpMatrix * vec4(a_position,1.0);  \n"
"}                                           \n"
;

static const char *fragmentShaderTriMultiTex =
"precision mediump float;"
""
"uniform sampler2D s_baseMap0;"
"uniform sampler2D s_baseMap1;"
"uniform float u_interp;"
""
"varying vec2      v_texCoord0;"
"varying vec2      v_texCoord1;"
"varying vec4      v_color;"
""
"void main()"
"{"
"  vec4 baseColor0 = texture2D(s_baseMap0, v_texCoord0);"
"  vec4 baseColor1 = texture2D(s_baseMap1, v_texCoord1);"
// If you're using 32 bit textures here, change these .a's to .r's
"  gl_FragColor = v_color * mix(vec4(baseColor0.a,baseColor0.a,baseColor0.a,baseColor0.a),vec4(baseColor1.a,baseColor1.a,baseColor1.a,baseColor1.a),u_interp);"
"}"
;

+ (NSString *)setupWeatherShader:(MaplyBaseViewController *)viewC
{
    NSString *shaderName = @"Weather Shader";
    
    MaplyShader *shader = [viewC getShaderByName:shaderName];
    if (shader)
        return shaderName;
    
    shader = [[MaplyShader alloc] initWithName:shaderName
                                                     vertex:[NSString stringWithFormat:@"%s",vertexShaderTriMultiTex]
                                                   fragment:[NSString stringWithFormat:@"%s",fragmentShaderTriMultiTex]
                                                      viewC:viewC];
    if (shader.valid)
    {
        [viewC addShaderProgram:shader sceneName:shaderName];
    } else {
        shaderName = nil;
        NSLog(@"Shader failed to compile: %@",[shader getError]);
    }
    
    return shaderName;
}


@end
