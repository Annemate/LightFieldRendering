using UnityEngine;
using System.Collections;

[ExecuteInEditMode]
public class loldepth : MonoBehaviour {

	public bool clean = false;
	private Material material;

	private float renderTextureWidth;


	public RenderTexture camOneRenderTexture;
	public RenderTexture camTwoRenderTexture;
	public RenderTexture camTreeRenderTexture;
	public RenderTexture camFourRenderTexture;

	// Creates a private material used to the effect
	void Awake ()
	{
		material = new Material( Shader.Find("Custom/loldepth") );
		print (Screen.width + " " + Screen.height);

		if(camOneRenderTexture != null){
				if(camOneRenderTexture.height != camOneRenderTexture.width){
					print("Aspect ratio for cam 1 is not 1:1");
				}
		}
		if(camTwoRenderTexture != null){
				if(camTwoRenderTexture.height != camTwoRenderTexture.width){
					print("Aspect ratio for cam 2 is not 1:1");
				}
		}

		if(camTreeRenderTexture != null){
				if(camTreeRenderTexture.height != camTreeRenderTexture.width){
					print("Aspect ratio for cam 3 is not 1:1");
				}
		}

		if(camFourRenderTexture != null){
				if(camFourRenderTexture.height != camFourRenderTexture.width){
					print("Aspect ratio for cam 4 is not 1:1");
				}
		}
		renderTextureWidth = camOneRenderTexture.height;
		print(renderTextureWidth);
	//if(camOneRenderTexture.height + camTwoRenderTexture.height + camTreeRenderTexture.height + camFourRenderTexture.height == camOneRenderTexture.height * 4){
	//	renderTextureWidth = camOneRenderTexture.height;
	//}else{
	//	print("The resolution of the render textures are not the same");
	//}
	}


	// Postprocess the image
	void OnRenderImage (RenderTexture source, RenderTexture destination)
	{
		if (clean)
		{
			Graphics.Blit (source, destination);
			return;
		}

		//material.SetFloat("_bwBlend", Screen.width);
		//material.SetFloat("_TextureWidth", renderTextureWidth);
		//material.SetTexture ("_cam2", renderTexture);
		material.SetTexture ("_Cam2", camOneRenderTexture);
		//if(Time.frameCount%100 == 0)
		//print (Screen.width + " " + Screen.height);
		Graphics.Blit (source, destination, material);
	}
}
