using UnityEngine;
using System.Collections;

[ExecuteInEditMode]
public class lol : MonoBehaviour {

	public bool clean = false;
	private Material material;
	public Material material2;

	// Creates a private material used to the effect
	void Awake ()
	{
		material = new Material( Shader.Find("Custom/lol") );
	}

	// Postprocess the image
	void OnRenderImage (RenderTexture source, RenderTexture destination)
	{
		if (clean)
		{
			Graphics.Blit (source, destination);
			return;
		}

		material.SetFloat("_bwBlend", 1.0f);
		Graphics.Blit (source, destination, material);
	}
}