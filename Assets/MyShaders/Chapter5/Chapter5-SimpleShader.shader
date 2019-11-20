// Upgrade NOTE: replaced 'mul(UNITY_MATRIX_MVP,*)' with 'UnityObjectToClipPos(*)'

Shader "My Unity Shaders Book/Chapter 5/Simple Shader" {
	Properties {
		_Color ("Color Tint", Color) = (1.0, 1.0, 1.0, 1.0)
	}
	SubShader {
		Pass {
			CGPROGRAM

			#pragma vertex vert //声明顶点着色器函数
			#pragma fragment frag //声明片元着色器函数

			fixed4 _Color;

			//使用一个结构体来定义顶点着色器的输入 application to vertex shader 把数据从应用阶段传递到顶点着色器中
			struct a2v {
				float4 vertex : POSITION; //取模型空间的顶点坐标
				float3 normal : NORMAL; //取模型空间的法线方向
				float4 texcoord : TEXCOORD0; //取模型的第一套纹理坐标
			};

			//使用一个结构体来定义顶点着色器的输出
			struct v2f {
				float4 pos : SV_POSITION; //顶点在裁剪空间中的位置信息
				fixed3 color : COLOR0; //顶点存储的颜色值
			};

			// float4 vert(float4 v : POSITION) : SV_POSITION { //模型空间到裁剪空间
			// 	return UnityObjectToClipPos(v);
			// }
			v2f vert(a2v v) {
				v2f o;
				o.pos = UnityObjectToClipPos(v.vertex);
				o.color = v.normal * 0.5 + fixed3(0.5, 0.5, 0.5);
				return o;
			}

			fixed4 frag(v2f i) : SV_Target {
				fixed3 c = i.color;
				c *= _Color.rgb; //使用_Color属性来控制输出颜色
				return fixed4(c, 1.0);
			}

			ENDCG
		}
	}
}
