﻿Shader "Custom/lol" {
	Properties {
		_MainTex ("Base (RGB)", 2D) = "white" {}
		_bwBlend ("Black & White blend", Range (0, 1)) = 0
		_LastCameraDepthTexture ()
	}
	SubShader {
		Pass {
			CGPROGRAM
			#pragma vertex vert_img
			#pragma fragment frag
 
			#include "UnityCG.cginc"
 
			uniform sampler2D _MainTex;
			uniform float _bwBlend;
 
			float4 frag(v2f_img i) : COLOR {
				//_WorldSpaceCameraPos;

				float4 c = tex2D(_MainTex, i.uv);

				float4 lol = float4(c.a, c.a, c.a, c.a);
				//_LastCameraDepthTexture;

				float lum = c.r*.3 + c.g*.59 + c.b*.11;
				float3 bw = float3( lum, lum, lum ); 
				
				float4 result = c;
				result.rgb = lerp(c.rgb, bw, _bwBlend);
				return lol;


			}
			ENDCG
		}
	}
}