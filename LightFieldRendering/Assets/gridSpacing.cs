using UnityEngine;
using System.Collections;

public class gridSpacing : MonoBehaviour {

	public static int cameraCounter;
	private int cameraId;
	public int camX = 14;
	public int camY = 7;



	void Start () {
		GameObject tmpCamera;
		cameraId = cameraCounter;

		print (cameraId);
		cameraCounter++;


		if (cameraId == 0) {

			for(int i = 0; i <= camX; i++){
				for(int j = 0; j <= camY; j++){
					if(i != 0 || j != 0){ 
						print (cameraCounter);
						tmpCamera = Instantiate (gameObject, gameObject.transform.position + new Vector3((float) i, (float) j, 0), gameObject.transform.rotation) as GameObject;
						print ("lol");
						print (cameraCounter);
						int tmp = (i*j) + i + j;
						tmpCamera.name = "Camera " + tmp.ToString();

						tmpCamera.GetComponent<Camera>().clearFlags = CameraClearFlags.SolidColor;
						if(i%2 != j%2){
							tmpCamera.GetComponent<Camera>().backgroundColor = Color.white;
						} else{
							tmpCamera.GetComponent<Camera>().backgroundColor = Color.black;
						}
					}
				}
			}
		}
	}

}
