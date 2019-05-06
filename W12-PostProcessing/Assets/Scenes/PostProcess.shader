// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "PostProcess"
{
	Properties
	{
		_MainTex("MainTex", 2D) = "white" {}
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
	}
	
	SubShader
	{
		
		
		Tags { "RenderType"="Opaque" }
		LOD 100

		CGINCLUDE
		#pragma target 3.0
		ENDCG
		Blend Off
		Cull Back
		ColorMask RGBA
		ZWrite On
		ZTest LEqual
		Offset 0 , 0
		
		
		
		Pass
		{
			Name "Unlit"
			
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			#pragma multi_compile_instancing
			#include "UnityCG.cginc"
			

			struct appdata
			{
				float4 vertex : POSITION;
				float4 color : COLOR;
				UNITY_VERTEX_INPUT_INSTANCE_ID
				float4 ase_texcoord : TEXCOORD0;
			};
			
			struct v2f
			{
				float4 vertex : SV_POSITION;
				UNITY_VERTEX_INPUT_INSTANCE_ID
				UNITY_VERTEX_OUTPUT_STEREO
				float4 ase_texcoord : TEXCOORD0;
			};

			uniform sampler2D _MainTex;
			uniform float4 _MainTex_ST;
			
			v2f vert ( appdata v )
			{
				v2f o;
				UNITY_SETUP_INSTANCE_ID(v);
				UNITY_INITIALIZE_VERTEX_OUTPUT_STEREO(o);
				UNITY_TRANSFER_INSTANCE_ID(v, o);

				o.ase_texcoord.xy = v.ase_texcoord.xy;
				
				//setting value to unused interpolator channels and avoid initialization warnings
				o.ase_texcoord.zw = 0;
				float3 vertexValue =  float3(0,0,0) ;
				#if ASE_ABSOLUTE_VERTEX_POS
				v.vertex.xyz = vertexValue;
				#else
				v.vertex.xyz += vertexValue;
				#endif
				o.vertex = UnityObjectToClipPos(v.vertex);
				return o;
			}
			
			fixed4 frag (v2f i ) : SV_Target
			{
				UNITY_SETUP_INSTANCE_ID(i);
				fixed4 finalColor;
				float2 uv015 = i.ase_texcoord.xy * float2( 1,1 ) + float2( 0.001,0.001 );
				float4 tex2DNode2 = tex2D( _MainTex, uv015 );
				float3 desaturateInitialColor14 = tex2DNode2.rgb;
				float desaturateDot14 = dot( desaturateInitialColor14, float3( 0.299, 0.587, 0.114 ));
				float3 desaturateVar14 = lerp( desaturateInitialColor14, desaturateDot14.xxx, 1.0 );
				float2 uv_MainTex = i.ase_texcoord.xy * _MainTex_ST.xy + _MainTex_ST.zw;
				float3 desaturateInitialColor17 = tex2D( _MainTex, uv_MainTex ).rgb;
				float desaturateDot17 = dot( desaturateInitialColor17, float3( 0.299, 0.587, 0.114 ));
				float3 desaturateVar17 = lerp( desaturateInitialColor17, desaturateDot17.xxx, 1.0 );
				float3 smoothstepResult25 = smoothstep( float3( 0,0,0 ) , float3( 0.1,0.1,0.1 ) , abs( ( desaturateVar14 - desaturateVar17 ) ));
				float2 uv027 = i.ase_texcoord.xy * float2( 1,1 ) + float2( 0.001,0.001 );
				float2 break38 = frac( ( uv027 * float2( 80,80 ) ) );
				float blendOpSrc37 = break38.x;
				float blendOpDest37 = break38.y;
				
				
				finalColor = ( tex2DNode2 * float4( ( 1.0 - ( smoothstepResult25 + float3( 0,0,0 ) + ( step( desaturateVar14 , float3( 0.4,0.4,0.4 ) ) * step( ( saturate( abs( blendOpSrc37 - blendOpDest37 ) )) , 0.05 ) ) ) ) , 0.0 ) );
				return finalColor;
			}
			ENDCG
		}
	}
	CustomEditor "ASEMaterialInspector"
	
	
}
/*ASEBEGIN
Version=16700
452;249;1043;635;1161.979;159.0826;2.208105;True;False
Node;AmplifyShaderEditor.TextureCoordinatesNode;27;-855.1443,808.984;Float;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0.001,0.001;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;28;-606.8826,811.6498;Float;False;2;2;0;FLOAT2;0,0;False;1;FLOAT2;80,80;False;1;FLOAT2;0
Node;AmplifyShaderEditor.TexturePropertyNode;22;-1038.963,-90.05335;Float;True;Property;_MainTex;MainTex;0;0;Create;True;0;0;False;0;None;None;False;white;Auto;Texture2D;0;1;SAMPLER2D;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;15;-1029.624,165.9484;Float;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0.001,0.001;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.FractNode;29;-472.8826,817.6498;Float;False;1;0;FLOAT2;0,0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.SamplerNode;2;-758.389,156.7372;Float;True;Property;_tex;tex;0;0;Create;True;0;0;False;0;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;23;-755.0352,370.4192;Float;True;Property;_TextureSample0;Texture Sample 0;0;0;Create;True;0;0;False;0;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.DesaturateOpNode;17;-338.4424,328.4498;Float;False;2;0;FLOAT3;0,0,0;False;1;FLOAT;1;False;1;FLOAT3;0
Node;AmplifyShaderEditor.BreakToComponentsNode;38;-371.268,823.4804;Float;False;FLOAT2;1;0;FLOAT2;0,0;False;16;FLOAT;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4;FLOAT;5;FLOAT;6;FLOAT;7;FLOAT;8;FLOAT;9;FLOAT;10;FLOAT;11;FLOAT;12;FLOAT;13;FLOAT;14;FLOAT;15
Node;AmplifyShaderEditor.DesaturateOpNode;14;-353.4857,220.2424;Float;False;2;0;FLOAT3;0,0,0;False;1;FLOAT;1;False;1;FLOAT3;0
Node;AmplifyShaderEditor.BlendOpsNode;37;-140.3749,818.1418;Float;False;Difference;True;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;18;-59.70846,304.791;Float;False;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.AbsOpNode;19;102.9359,324.6257;Float;False;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.StepOpNode;39;70.28962,816.9282;Float;False;2;0;FLOAT;0;False;1;FLOAT;0.05;False;1;FLOAT;0
Node;AmplifyShaderEditor.StepOpNode;40;24.61485,536.1725;Float;False;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0.4,0.4,0.4;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SmoothstepOpNode;25;260.0374,383.183;Float;False;3;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0.1,0.1,0.1;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;41;288.6452,642.3904;Float;False;2;2;0;FLOAT3;0,0,0;False;1;FLOAT;0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleAddOpNode;26;520.3154,443.1075;Float;False;3;3;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.OneMinusNode;42;678.3317,450.3542;Float;False;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;43;839.5236,417.2326;Float;False;2;2;0;COLOR;0,0,0,0;False;1;FLOAT3;0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode;1;961.1505,401.8857;Float;False;True;2;Float;ASEMaterialInspector;0;1;PostProcess;0770190933193b94aaa3065e307002fa;True;Unlit;0;0;Unlit;2;True;0;1;False;-1;0;False;-1;0;1;False;-1;0;False;-1;True;0;False;-1;0;False;-1;True;False;True;0;False;-1;True;True;True;True;True;0;False;-1;True;False;255;False;-1;255;False;-1;255;False;-1;7;False;-1;1;False;-1;1;False;-1;1;False;-1;7;False;-1;1;False;-1;1;False;-1;1;False;-1;True;1;False;-1;True;3;False;-1;True;True;0;False;-1;0;False;-1;True;1;RenderType=Opaque=RenderType;True;2;0;False;False;False;False;False;False;False;False;False;True;0;False;0;;0;0;Standard;1;Vertex Position,InvertActionOnDeselection;1;0;1;True;False;2;0;FLOAT4;0,0,0,0;False;1;FLOAT3;0,0,0;False;0
WireConnection;28;0;27;0
WireConnection;29;0;28;0
WireConnection;2;0;22;0
WireConnection;2;1;15;0
WireConnection;23;0;22;0
WireConnection;17;0;23;0
WireConnection;38;0;29;0
WireConnection;14;0;2;0
WireConnection;37;0;38;0
WireConnection;37;1;38;1
WireConnection;18;0;14;0
WireConnection;18;1;17;0
WireConnection;19;0;18;0
WireConnection;39;0;37;0
WireConnection;40;0;14;0
WireConnection;25;0;19;0
WireConnection;41;0;40;0
WireConnection;41;1;39;0
WireConnection;26;0;25;0
WireConnection;26;2;41;0
WireConnection;42;0;26;0
WireConnection;43;0;2;0
WireConnection;43;1;42;0
WireConnection;1;0;43;0
ASEEND*/
//CHKSM=FD063EACD20CFF6EFCBD5C5D4CF80943BE5840ED