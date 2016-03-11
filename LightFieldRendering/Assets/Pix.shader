// Upgrade NOTE: replaced 'glstate.matrix.mvp' with 'UNITY_MATRIX_MVP'
 
Shader "Pix" {
Properties {
    _MainTex ("Main Texture", 2D) = "" {}
    _Color ("Color", Color) = (0.5,0.5,0.5,0.5)
    _RenderPaintTexture ("Render Texture", 2D) = "white" {}
    _Threshold ("Alpha Threshold", Range(0,1)) = 0.6
}
Category {
 
    Tags { "Queue"="Transparent" "IgnoreProjector"="True" "RenderType"="Transparent" }
    Blend SrcAlpha One
   
    Cull Off Lighting Off ZWrite Off Fog { Color (0,0,0,0) }
 
    BindChannels
    {
        Bind "Color", color
        Bind "Vertex", vertex
        Bind "TexCoord", texcoord
    }
 
    SubShader {
        Pass
        {  
        ColorMask A
 
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #pragma fragmentoption ARB_precision_hint_fastest
            #pragma multi_compile_particles
            #include "UnityCG.cginc"
 
            uniform sampler2D _MainTex;
           
            uniform float4 _Color;
 
            struct appdata {
                float4 vertex : POSITION;
                float2 texcoord : TEXCOORD0;
            };
 
            float4 _MainTex_ST;
 
            struct v2f {
                float4 vertex : POSITION;
                float2 texcoord : TEXCOORD0;
            };
 
            v2f vert(appdata v) {
                v2f o;
                o.vertex = mul(UNITY_MATRIX_MVP, v.vertex);
                o.texcoord = TRANSFORM_TEX(v.texcoord, _MainTex);
                return o;
            }
 
            fixed4 frag (v2f i) : COLOR
            {
                float4 col = _Color * tex2D(_MainTex, i.texcoord);
                return col;
            }
 
            ENDCG
        }
        Pass
        {
        ColorMask RGB
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #include "UnityCG.cginc"
 
            uniform sampler2D _MainTex;
            uniform sampler2D _RenderPaintTexture;
            uniform float _Threshold;
            uniform float4 _Color;
 
            struct appdata {
                float4 vertex : POSITION;
                float2 texcoord : TEXCOORD0;
            };
 
            struct v2f {
                float4 pos : POSITION;
                float2 texcoord : TEXCOORD0;
                float4 screenPos : TEXCOORD4;
            };
 
            float4 _MainTex_ST;
 
            v2f vert(appdata v) {
                v2f o;
                o.pos = mul(UNITY_MATRIX_MVP, v.vertex);
                o.texcoord = TRANSFORM_TEX(v.texcoord, _MainTex);
                o.screenPos = o.pos;
                return o;
            }
 
            fixed4 frag (v2f i) : COLOR
            {
                float2 screenPos = i.screenPos.xy / i.screenPos.w;   // screenpos ranges from -1 to 1
                screenPos.x = (screenPos.x + 1) * 0.5;   // I need 0 to 1
                screenPos.y = (screenPos.y + 1) * 0.5;   // I need 0 to 1
                screenPos.y = 1 - screenPos.y;
 
                //float4 col = tex2D(_MainTex, i.texcoord);
                float4 rendCol = tex2D(_RenderPaintTexture, screenPos);
 
                return (rendCol.a > _Threshold) ? _Color : float4(0,0,0,0);
            }
 
            ENDCG
        }
    }
           
   
    // ---- Dual texture cards
    SubShader {
        Pass {
            SetTexture [_MainTex] {
                constantColor [_TintColor]
                combine constant * primary
            }
            SetTexture [_MainTex] {
                combine texture * previous DOUBLE
            }
        }
    }
   
    // ---- Single texture cards (does not do color tint)
    SubShader {
        Pass {
            SetTexture [_MainTex] {
                combine texture * primary
            }
    }
}
}
}
 
