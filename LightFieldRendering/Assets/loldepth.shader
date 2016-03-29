Shader "Custom/loldepth" {

Properties {
		_Cam1 ("Cam1", 2D) = "white" {}
		_Cam2 ("Cam2", 2D) = "white" {}
		_Cam3 ("Cam3", 2D) = "white" {}
		_nearPlane ("_nearPlane", float) = 0
		_farPlane ("_farPlane", float) = 0

		_ImagePlaneLength ("_ImagePlaneLength", float) = 0
		//_TextureWidth ("TextureWidth", Float) = 0.3
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

	//sampler2D test;
	float4 _Cam2_TexelSize;
	float _ImagePlaneLength;

	float _nearPlane;
	float _farPlane;
	//Float _TextureWidth;

	float4 realCameraColors;
	float ze;

	float xe;
	float ye;

	float3 posE;

	float xp;
	float yp;

	float2 posP;

	struct v2f {
	    float4 pos : SV_POSITION;
	    float2 depth : TEXCOORD0;
	};


	v2f vert (appdata_base v) {
	    v2f o;
	    o.pos = mul (UNITY_MATRIX_MVP, v.vertex);

	    return o;
	}


	float4 frag(v2f i) : SV_Target {


		//http://gamedev.stackexchange.com/questions/65783/what-is-world-space-and-eye-space-in-game-development
		//http://www.songho.ca/opengl/gl_projectionmatrix.html

		float4 leftColor = tex2D(_Cam2, float2((i.pos.x%(1/_Cam2_TexelSize.x)) * _Cam2_TexelSize.x, (-(i.pos.y * _Cam2_TexelSize.x))+1));

		//Convert 0-1 color range to near and far clipping plane: http://gamedev.stackexchange.com/questions/33441/how-to-convert-a-number-from-one-min-max-set-to-another-min-max-set
	//float ze = (leftColor.w) * (_farPlane - _nearPlane) + _nearPlane;

	////Convert from projection space to eye space
 	//float xe = (i.pos.x * ze)/_ImagePlaneLength;
 	//float ye = (i.pos.y * ze)/_ImagePlaneLength;

	////Combine to vector3
	//float3 posE = float3(xe, ye, ze);

	////Convert back from eye space to projection space
	//float xp = (_ImagePlaneLength * xe) / ze;
	//float yp = (_ImagePlaneLength * ye) / ze;

	////Combine to vector2
	//float2 posP = float2(xp, yp);



		if(i.pos.x > (1/_Cam2_TexelSize.x) && i.pos.x < (1/_Cam2_TexelSize.x)*2){



			//leftColor = float4(leftColor.w, leftColor.w, leftColor.w, leftColor.w);
			for(int j = 0 ; j < 256; j++){
				float loldsa = 1;
				//Loop through real camera colors
				realCameraColors = tex2D(_Cam2, float2(j/(1/_Cam2_TexelSize.x), (-(i.pos.y * (_Cam2_TexelSize.x)))+1));


				 ze = (realCameraColors.w) * (_farPlane - _nearPlane) + _nearPlane;

				//Convert from projection space to eye space
				// xe = ((j-(_Cam2_TexelSize.x / 2)) * ze)/_ImagePlaneLength;
				xe = ( (j-((1/_Cam2_TexelSize.x) / 2)) * -ze)/-_ImagePlaneLength;

				xe = xe - 1;
				 //need fixing
				 //ye = (i.pos.y * ze)/_ImagePlaneLength;

				//Combine to vector3
				// posE = float3(xe, ye, ze);

				 if(j == 1){
				 	//return float4(1,1,0,0);

				 }
				//Convert back from eye space to projection space
				 xp = (-_ImagePlaneLength * xe) / -ze;
				 xp = xp + ((1/_Cam2_TexelSize.x)/2);
				// yp = (_ImagePlaneLength * posE.y) / ze;

				//Combine to vector2
				 posP = float2(xp, yp);

				if(abs((xp) - (i.pos.x - (1/_Cam2_TexelSize.x))) < 2){
					return realCameraColors;
				//return float4(0,0,1,0);
				}

			}

			float test = (i.pos.x - (1/_Cam2_TexelSize.x)) / (1/_Cam2_TexelSize.x);
			//return float4(test,test,test,1);
			return float4(1,0,0,0);

		}

		if(i.pos.y > (1/_Cam2_TexelSize.y)){
			leftColor = float4(0,0,0,0);
		}

		//Check for difference between original value and calculated value
		//if(abs(i.pos.x - xp) > 2){
		//	leftColor = float4(1,1,0,0);
		//}

		//leftColor = float4(i.pos.x/_ScreenParams.x , i.pos.y/_ScreenParams.y , 0 , 1.0);

		//Round to nearest int
		//leftColor = float4(round(0.5), round(0.5), round(0.5), 1);
		//leftColor = tex2D(_Cam2, float2(0,0));



		return leftColor;
	}


	ENDCG
	    }
	}
		FallBack "Diffuse"
}
