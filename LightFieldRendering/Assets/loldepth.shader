Shader "Custom/loldepth" {

Properties {
		_Cam1 ("Cam1", 2D) = "white" {}
		_Cam2 ("Cam2", 2D) = "white" {}
		_Cam3 ("Cam3", 2D) = "white" {}
	}

	SubShader {
	    Tags { "RenderType"="Opaque" }
	    Pass {
	CGPROGRAM

	#pragma vertex vert
	#pragma fragment frag
	#include "UnityCG.cginc"

	sampler2D _Cam1;
	sampler2D _Cam2;
 
	struct v2f {
	    float4 pos : SV_POSITION;
	    float2 depth : TEXCOORD0;
	};


	v2f vert (appdata_base v) {
	    v2f o;
	    o.pos = mul (UNITY_MATRIX_MVP, v.vertex);
	    //UNITY_TRANSFER_DEPTH(o.depth);
	    return o;
	}


	half4 frag(v2f i) : SV_Target {
	//    UNITY_OUTPUT_DEPTH(i.depth);

	//float4 leftColor = tex2D(_Cam1, i.pos)*4;
	float4 leftColor = tex2D(_Cam2, i.pos/512);

	//float4 leftColor = float4(i.pos.y, i.pos.y, i.pos.y, 1)/400;

	return leftColor;
	}


	ENDCG
	    }
	}
		FallBack "Diffuse"
}
