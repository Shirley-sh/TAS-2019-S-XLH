// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "Jellyfish"
{
	Properties
	{
		_Scale("Scale", Float) = 1
		_Float0("Float 0", Float) = 1
		_Freq("Freq", Float) = 1
		_Float1("Float 1", Float) = 1
		_Spread("Spread", Float) = 1
		_VertexFreq("VertexFreq", Float) = 1
		[Toggle(_FOWARD_ON)] _Foward("Foward", Float) = 1
		_Texture("Texture", 2D) = "white" {}
		_Emission("Emission", 2D) = "white" {}
		_Color("Color", Color) = (1,1,1,1)
		_Color0("Color 0", Color) = (0,0,0,0)
		_Color1("Color 1", Color) = (0,0,0,0)
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Transparent"  "Queue" = "AlphaTest+0" "IsEmissive" = "true"  }
		Cull Off
		ZWrite On
		ZTest Always
		Blend SrcAlpha OneMinusSrcAlpha
		
		CGPROGRAM
		#include "UnityShaderVariables.cginc"
		#pragma target 3.0
		#pragma shader_feature _FOWARD_ON
		#pragma surface surf Standard keepalpha noshadow vertex:vertexDataFunc 
		struct Input
		{
			float2 uv_texcoord;
			float3 worldNormal;
			half ASEVFace : VFACE;
			float3 viewDir;
		};

		uniform float _Scale;
		uniform float _Freq;
		uniform float _VertexFreq;
		uniform float _Spread;
		uniform float4 _Color;
		uniform sampler2D _Emission;
		uniform float4 _Emission_ST;
		uniform float _Float0;
		uniform float _Float1;
		uniform float4 _Color0;
		uniform float4 _Color1;
		uniform sampler2D _Texture;
		uniform float4 _Texture_ST;

		void vertexDataFunc( inout appdata_full v, out Input o )
		{
			UNITY_INITIALIZE_OUTPUT( Input, o );
			float3 ase_vertex3Pos = v.vertex.xyz;
			#ifdef _FOWARD_ON
				float staticSwitch47 = (float)1;
			#else
				float staticSwitch47 = (float)-1;
			#endif
			float temp_output_12_0 = ( _Scale * sin( ( ( _Time.y * _Freq ) + ( ase_vertex3Pos.y * ( _VertexFreq * staticSwitch47 ) ) ) ) );
			float smoothstepResult30 = smoothstep( 0.0 , 1.0 , temp_output_12_0);
			float3 ase_vertexNormal = v.normal.xyz;
			float clampResult37 = clamp( -ase_vertex3Pos.y , 0.0 , 100.0 );
			float4 appendResult4 = (float4(( smoothstepResult30 * ase_vertexNormal.x * _Spread ) , ( temp_output_12_0 * clampResult37 * smoothstepResult30 * _Spread ) , ( smoothstepResult30 * ase_vertexNormal.z * _Spread ) , 0.0));
			v.vertex.xyz += appendResult4.xyz;
		}

		void surf( Input i , inout SurfaceOutputStandard o )
		{
			o.Albedo = _Color.rgb;
			float2 uv_Emission = i.uv_texcoord * _Emission_ST.xy + _Emission_ST.zw;
			float temp_output_72_0 = ( ( _Float0 * sin( ( ( _Time.y * _Float1 ) + 0.0 ) ) ) * ( 1.0 - distance( i.uv_texcoord , float2( 0.5,0.5 ) ) ) );
			float smoothstepResult73 = smoothstep( 0.0 , 0.3 , temp_output_72_0);
			float smoothstepResult75 = smoothstep( 0.2 , 0.3 , temp_output_72_0);
			float4 temp_output_74_0 = ( tex2D( _Emission, uv_Emission ) * ( smoothstepResult73 - smoothstepResult75 ) * _Color0 );
			o.Emission = ( temp_output_74_0 + _Color1 ).rgb;
			float2 uv_Texture = i.uv_texcoord * _Texture_ST.xy + _Texture_ST.zw;
			float3 ase_worldNormal = i.worldNormal;
			float3 switchResult49 = (((i.ASEVFace>0)?(ase_worldNormal):(-ase_worldNormal)));
			float dotResult52 = dot( switchResult49 , i.viewDir );
			float4 clampResult59 = clamp( ( tex2D( _Texture, uv_Texture ).a + ( _Color.a * ( 1.0 - dotResult52 ) ) + temp_output_74_0 ) , float4( 0,0,0,0 ) , float4( 1,0,0,0 ) );
			o.Alpha = clampResult59.r;
		}

		ENDCG
	}
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=16301
0;42;1216;736;523.0046;1219.118;1.976727;True;False
Node;AmplifyShaderEditor.CommentaryNode;61;-1101.221,-1275.429;Float;False;2166.797;786.7824;Comment;14;68;67;66;65;64;63;62;60;69;70;71;72;73;76;;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;40;-1601.711,350.319;Float;False;2166.797;786.7824;Comment;24;3;10;1;9;17;38;11;2;12;36;30;37;22;27;35;23;26;4;16;15;43;47;45;48;;1,1,1,1;0;0
Node;AmplifyShaderEditor.RangedFloatNode;66;-891.1412,-1161.811;Float;False;Property;_Float1;Float 1;4;0;Create;True;0;0;False;0;1;1.73;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleTimeNode;67;-897.5021,-1225.429;Float;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.IntNode;45;-1557.441,1014.83;Float;False;Constant;_Forward;Forward;5;0;Create;True;0;0;False;0;1;0;0;1;INT;0
Node;AmplifyShaderEditor.IntNode;48;-1553.931,950.0125;Float;False;Constant;_Backward;Backward;5;0;Create;True;0;0;False;0;-1;0;0;1;INT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;68;-649.6271,-1207.606;Float;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.StaticSwitch;47;-1324.732,979.313;Float;False;Property;_Foward;Foward;7;0;Create;True;0;0;False;0;0;1;1;True;;Toggle;2;Key0;Key1;9;1;FLOAT;0;False;0;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT;0;False;7;FLOAT;0;False;8;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;15;-1478.004,813.5154;Float;False;Property;_VertexFreq;VertexFreq;6;0;Create;True;0;0;False;0;1;1.86;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.TextureCoordinatesNode;69;-716.9301,-857.563;Float;True;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleAddOpNode;62;-381.1831,-1135.17;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;10;-1391.631,463.9366;Float;False;Property;_Freq;Freq;3;0;Create;True;0;0;False;0;1;5;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.WorldNormalVector;41;-656.2137,-270.3149;Float;False;False;1;0;FLOAT3;0,0,1;False;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;43;-1141.673,842.5892;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleTimeNode;3;-1397.992,400.319;Float;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;64;-240.1029,-1216.484;Float;False;Property;_Float0;Float 0;2;0;Create;True;0;0;False;0;1;0.43;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SinOpNode;63;-263.3311,-1139.421;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.DistanceOpNode;70;-397.4561,-806.06;Float;True;2;0;FLOAT2;0,0;False;1;FLOAT2;0.5,0.5;False;1;FLOAT;0
Node;AmplifyShaderEditor.PosVertexDataNode;1;-1551.711,587.7565;Float;True;0;0;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;16;-950.1032,641.7651;Float;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.NegateNode;50;-385.9104,-212.1846;Float;False;1;0;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;9;-1150.117,418.1418;Float;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;65;-86.34206,-1210.813;Float;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.OneMinusNode;71;-148.2379,-819.1768;Float;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ViewDirInputsCoordNode;51;-168.8251,-79.51266;Float;False;World;False;0;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.SwitchByFaceNode;49;-170.9489,-218.2208;Float;False;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.SimpleAddOpNode;17;-881.6729,490.5776;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;72;143.5836,-863.7736;Float;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.DotProductOpNode;52;190.5358,-150.9089;Float;False;2;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.PosVertexDataNode;38;-739.4655,589.1704;Float;True;0;0;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SinOpNode;2;-763.821,486.3268;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SmoothstepOpNode;73;573.2427,-874.5973;Float;True;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0.3;False;1;FLOAT;0
Node;AmplifyShaderEditor.SmoothstepOpNode;75;577.7972,-652.5696;Float;True;3;0;FLOAT;0;False;1;FLOAT;0.2;False;2;FLOAT;0.3;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;11;-740.5927,409.2635;Float;False;Property;_Scale;Scale;1;0;Create;True;0;0;False;0;1;0.43;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleSubtractOpNode;76;834.6387,-803.3876;Float;True;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;60;340.8422,-1155.637;Float;True;Property;_Emission;Emission;9;0;Create;True;0;0;False;0;None;dff1b2a70991b409896957c80206865d;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;78;1076.015,-699.2063;Float;False;Property;_Color0;Color 0;11;0;Create;True;0;0;False;0;0,0,0,0;1,0,0.1345534,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.NegateNode;36;-428.5501,683.7368;Float;True;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;53;463.5132,-380.9503;Float;False;Property;_Color;Color;10;0;Create;True;0;0;False;0;1,1,1,1;0,0.3266683,1,1;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.OneMinusNode;54;394.7086,32.16302;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;12;-586.8319,414.9346;Float;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.NormalVertexDataNode;22;-706.5104,778.975;Float;False;0;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;55;-167.6368,-419.2706;Float;True;Property;_Texture;Texture;8;0;Create;True;0;0;False;0;None;9e9a792dfbc584d6295a1a92cd0416dc;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SmoothstepOpNode;30;-326.0706,525.3098;Float;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;27;-271.9085,970.2458;Float;False;Property;_Spread;Spread;5;0;Create;True;0;0;False;0;1;0.5;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.ClampOpNode;37;-206.4569,651.0208;Float;False;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;100;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;57;618.0203,7.350677;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;74;1317.786,-760.0589;Float;True;3;3;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;2;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleAddOpNode;58;813.4713,-11.43365;Float;False;3;3;0;FLOAT;0;False;1;FLOAT;0;False;2;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;35;71.44023,418.6981;Float;True;4;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;23;71.91623,651.9054;Float;True;3;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;26;68.80254,884.6014;Float;True;3;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;79;1266.938,-443.0829;Float;False;Property;_Color1;Color 1;12;0;Create;True;0;0;False;0;0,0,0,0;0,0,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ClampOpNode;59;962.4724,-15.01954;Float;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;COLOR;1,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.DynamicAppendNode;4;402.0871,484.7728;Float;False;FLOAT4;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.SimpleAddOpNode;80;1469.511,-445.0496;Float;False;2;2;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;1715.088,-446.8488;Float;False;True;2;Float;ASEMaterialInspector;0;0;Standard;Jellyfish;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;Off;1;False;-1;7;False;-1;False;0;False;-1;0;False;-1;False;0;Custom;0.5;True;False;0;True;Transparent;;AlphaTest;All;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;False;2;5;False;-1;10;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;0;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;68;0;67;0
WireConnection;68;1;66;0
WireConnection;47;1;48;0
WireConnection;47;0;45;0
WireConnection;62;0;68;0
WireConnection;43;0;15;0
WireConnection;43;1;47;0
WireConnection;63;0;62;0
WireConnection;70;0;69;0
WireConnection;16;0;1;2
WireConnection;16;1;43;0
WireConnection;50;0;41;0
WireConnection;9;0;3;0
WireConnection;9;1;10;0
WireConnection;65;0;64;0
WireConnection;65;1;63;0
WireConnection;71;0;70;0
WireConnection;49;0;41;0
WireConnection;49;1;50;0
WireConnection;17;0;9;0
WireConnection;17;1;16;0
WireConnection;72;0;65;0
WireConnection;72;1;71;0
WireConnection;52;0;49;0
WireConnection;52;1;51;0
WireConnection;2;0;17;0
WireConnection;73;0;72;0
WireConnection;75;0;72;0
WireConnection;76;0;73;0
WireConnection;76;1;75;0
WireConnection;36;0;38;2
WireConnection;54;0;52;0
WireConnection;12;0;11;0
WireConnection;12;1;2;0
WireConnection;30;0;12;0
WireConnection;37;0;36;0
WireConnection;57;0;53;4
WireConnection;57;1;54;0
WireConnection;74;0;60;0
WireConnection;74;1;76;0
WireConnection;74;2;78;0
WireConnection;58;0;55;4
WireConnection;58;1;57;0
WireConnection;58;2;74;0
WireConnection;35;0;12;0
WireConnection;35;1;37;0
WireConnection;35;2;30;0
WireConnection;35;3;27;0
WireConnection;23;0;30;0
WireConnection;23;1;22;1
WireConnection;23;2;27;0
WireConnection;26;0;30;0
WireConnection;26;1;22;3
WireConnection;26;2;27;0
WireConnection;59;0;58;0
WireConnection;4;0;23;0
WireConnection;4;1;35;0
WireConnection;4;2;26;0
WireConnection;80;0;74;0
WireConnection;80;1;79;0
WireConnection;0;0;53;0
WireConnection;0;2;80;0
WireConnection;0;9;59;0
WireConnection;0;11;4;0
ASEEND*/
//CHKSM=FE344A4AFC9481651B3E32D50BC3E404268627DE