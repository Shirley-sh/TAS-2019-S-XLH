// Shader created with Shader Forge v1.38 
// Shader Forge (c) Freya Holmer - http://www.acegikmo.com/shaderforge/
// Note: Manually altering this data may prevent you from opening it in Shader Forge
/*SF_DATA;ver:1.38;sub:START;pass:START;ps:flbk:,iptp:2,cusa:False,bamd:0,cgin:,lico:0,lgpr:1,limd:0,spmd:1,trmd:0,grmd:0,uamb:True,mssp:True,bkdf:False,hqlp:False,rprd:False,enco:False,rmgx:True,imps:True,rpth:0,vtps:0,hqsc:True,nrmq:1,nrsp:0,vomd:0,spxs:False,tesm:0,olmd:1,culm:0,bsrc:0,bdst:1,dpts:2,wrdp:True,dith:0,atcv:False,rfrpo:True,rfrpn:Refraction,coma:15,ufog:False,aust:False,igpj:True,qofs:0,qpre:0,rntp:1,fgom:False,fgoc:False,fgod:False,fgor:False,fgmd:0,fgcr:0.5,fgcg:0.5,fgcb:0.5,fgca:1,fgde:0.01,fgrn:0,fgrf:300,stcl:False,atwp:False,stva:128,stmr:255,stmw:255,stcp:6,stps:0,stfa:0,stfz:0,ofsf:0,ofsu:0,f2p0:False,fnsp:True,fnfb:True,fsmp:False;n:type:ShaderForge.SFN_Final,id:3554,x:33507,y:33385,varname:node_3554,prsc:2|emission-4497-OUT;n:type:ShaderForge.SFN_Cubemap,id:3300,x:32873,y:33116,ptovrint:False,ptlb:Cubemap,ptin:_Cubemap,varname:_Cubemap,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,cube:7d1c208d0652943a791313aef72eed74,pvfc:0;n:type:ShaderForge.SFN_Multiply,id:1968,x:32891,y:33323,varname:node_1968,prsc:2|A-3300-RGB,B-3038-OUT,C-2479-RGB,D-5593-OUT;n:type:ShaderForge.SFN_Slider,id:3038,x:32334,y:33165,ptovrint:False,ptlb:Exposure,ptin:_Exposure,varname:_Exposure,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,min:0,cur:1,max:5;n:type:ShaderForge.SFN_Color,id:2479,x:32604,y:33301,ptovrint:False,ptlb:Sky Color,ptin:_SkyColor,varname:_SkyColor,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,c1:1,c2:1,c3:1,c4:1;n:type:ShaderForge.SFN_FogColor,id:2296,x:32877,y:33671,varname:node_2296,prsc:2;n:type:ShaderForge.SFN_Clamp01,id:322,x:32589,y:33480,varname:node_322,prsc:2|IN-1751-OUT;n:type:ShaderForge.SFN_Slider,id:7679,x:31850,y:33625,ptovrint:False,ptlb:Fog Height,ptin:_FogHeight,varname:_FogHeight,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,min:-1,cur:1,max:1;n:type:ShaderForge.SFN_Add,id:1751,x:32388,y:33543,varname:node_1751,prsc:2|A-5889-OUT,B-6423-OUT;n:type:ShaderForge.SFN_Negate,id:6423,x:32234,y:33575,varname:node_6423,prsc:2|IN-7679-OUT;n:type:ShaderForge.SFN_OneMinus,id:2547,x:32922,y:33471,varname:node_2547,prsc:2|IN-5593-OUT;n:type:ShaderForge.SFN_Multiply,id:841,x:33078,y:33533,varname:node_841,prsc:2|A-2547-OUT,B-7726-OUT;n:type:ShaderForge.SFN_Add,id:4497,x:33241,y:33508,varname:node_4497,prsc:2|A-1968-OUT,B-841-OUT;n:type:ShaderForge.SFN_Power,id:5593,x:32668,y:33671,varname:fog,prsc:2|VAL-322-OUT,EXP-8642-OUT;n:type:ShaderForge.SFN_Slider,id:8642,x:32077,y:33783,ptovrint:False,ptlb:Fog Smoothness,ptin:_FogSmoothness,varname:_FogSmoothness,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,min:0.1,cur:0.1,max:1;n:type:ShaderForge.SFN_SwitchProperty,id:7726,x:33120,y:33686,ptovrint:False,ptlb:Use Custom Fog Color,ptin:_UseCustomFogColor,varname:_UseCustomFogColor,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,on:False|A-2296-RGB,B-2888-RGB;n:type:ShaderForge.SFN_Color,id:2888,x:32877,y:33841,ptovrint:False,ptlb:Fog Color,ptin:_FogColor,varname:_FogColor,prsc:2,glob:False,taghide:False,taghdr:False,tagprd:False,tagnsco:False,tagnrm:False,c1:0.5,c2:0.5,c3:0.5,c4:1;n:type:ShaderForge.SFN_FragmentPosition,id:1149,x:31881,y:33426,varname:node_1149,prsc:2;n:type:ShaderForge.SFN_ViewVector,id:9421,x:31955,y:33024,varname:node_9421,prsc:2;n:type:ShaderForge.SFN_Dot,id:5889,x:32158,y:33165,varname:node_5889,prsc:2,dt:0|A-9421-OUT,B-9459-OUT;n:type:ShaderForge.SFN_Vector3,id:9459,x:31955,y:33205,varname:node_9459,prsc:2,v1:0,v2:-1,v3:0;proporder:3300-3038-2479-7679-8642-7726-2888;pass:END;sub:END;*/

Shader "Shader Forge/SkyCubemapFog" {
    Properties {
        _Cubemap ("Cubemap", Cube) = "_Skybox" {}
        _Exposure ("Exposure", Range(0, 5)) = 1
        [HDR]_SkyColor ("Sky Color", Color) = (1,1,1,1)
        _FogHeight ("Fog Height", Range(-1, 1)) = 1
        _FogSmoothness ("Fog Smoothness", Range(0.1, 1)) = 0.1
        [MaterialToggle] _UseCustomFogColor ("Use Custom Fog Color", Float ) = 0.7176471
        _FogColor ("Fog Color", Color) = (0.5,0.5,0.5,1)
    }
    SubShader {
        Tags {
            "IgnoreProjector"="True"
            "Queue"="Background"
            "RenderType"="Opaque"
            "PreviewType"="Skybox"
        }
        Pass {
            Name "FORWARD"
            Tags {
                "LightMode"="ForwardBase"
            }
            
            
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #include "UnityCG.cginc"
            #pragma multi_compile_fwdbase
            #pragma only_renderers d3d9 d3d11 glcore gles gles3 metal 
            #pragma target 3.0
            uniform samplerCUBE _Cubemap;
            uniform float _Exposure;
            uniform float4 _SkyColor;
            uniform float _FogHeight;
            uniform float _FogSmoothness;
            uniform fixed _UseCustomFogColor;
            uniform float4 _FogColor;
            struct VertexInput {
                float4 vertex : POSITION;
                float3 normal : NORMAL;
            };
            struct VertexOutput {
                float4 pos : SV_POSITION;
                float4 posWorld : TEXCOORD0;
                float3 normalDir : TEXCOORD1;
            };
            VertexOutput vert (VertexInput v) {
                VertexOutput o = (VertexOutput)0;
                o.normalDir = UnityObjectToWorldNormal(v.normal);
                o.posWorld = mul(unity_ObjectToWorld, v.vertex);
                o.pos = UnityObjectToClipPos( v.vertex );
                return o;
            }
            float4 frag(VertexOutput i) : COLOR {
                i.normalDir = normalize(i.normalDir);
                float3 viewDirection = normalize(_WorldSpaceCameraPos.xyz - i.posWorld.xyz);
                float3 normalDirection = i.normalDir;
                float3 viewReflectDirection = reflect( -viewDirection, normalDirection );
////// Lighting:
////// Emissive:
                float fog = pow(saturate((dot(viewDirection,float3(0,-1,0))+(-1*_FogHeight))),_FogSmoothness);
                float3 emissive = ((texCUBE(_Cubemap,viewReflectDirection).rgb*_Exposure*_SkyColor.rgb*fog)+((1.0 - fog)*lerp( unity_FogColor.rgb, _FogColor.rgb, _UseCustomFogColor )));
                float3 finalColor = emissive;
                return fixed4(finalColor,1);
            }
            ENDCG
        }
    }
    CustomEditor "ShaderForgeMaterialInspector"
}
