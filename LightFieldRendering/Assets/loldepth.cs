using UnityEngine;
using System.Collections;

[ExecuteInEditMode]
public class loldepth : MonoBehaviour {

	public bool clean = false;
	private Material material;
	public Material material2;
	public Texture Texture; 
	public RenderTexture renderTexture; 

	// Creates a private material used to the effect
	void Awake ()
	{
		material = new Material( Shader.Find("Custom/loldepth") );
	}

	// Postprocess the image
	void OnRenderImage (RenderTexture source, RenderTexture destination)
	{
		if (clean)
		{
			Graphics.Blit (source, destination);
			return;
		}

		material.SetFloat("_bwBlend", Screen.width);
		material.SetTexture ("_Cam2", renderTexture);
		print (Screen.width);
		Graphics.Blit (source, destination, material);
	}
}