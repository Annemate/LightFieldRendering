using UnityEngine;
using System.Collections;

public class gridSpacing : MonoBehaviour {

	public static int cameraCounter;
	private int cameraId;
	public int camX = 14;
	public int camY = 7;

	private float xScaling = 0.0651f;
	private float yScaling = 0.1157f;

	public float commonX;
	public float commonY;

	private float tmpX;
	private float tmpY;

	public float fov;
	private float tmpFov;


	void Update(){
		if (commonX != tmpX || commonY != tmpX || fov != tmpFov) {
			tmpX = commonX;
			tmpY = commonY;
			tmpFov = fov;
			int iloop = 0;
			foreach(Transform child in transform){
				child.gameObject.GetComponent<Camera>().fieldOfView = fov;
				//child.gameObject.GetComponent<Camera>().rect = new Rect (((float)i * xScaling) + commonX, ((float)j * yScaling) + commonY, xScaling, yScaling);
				print (iloop%camX + " " + (int) + (iloop/camX));

				iloop++;
				//print (GetComponentInChil
				//print(child.gameObject.GetComponent<Camera>().rect.);
			}
			for(int i = 0; i <= camX; i++){
				for(int j = 0; j <= camY; j++){
					//AdjustViewPort();
				}
			}
		}
	}


	void AdjustViewPort(GameObject tmpCamera, int i, int j){
		tmpCamera.GetComponent<Camera>().rect = new Rect (((float)i * xScaling) + commonX, ((float)j * yScaling) + commonY, xScaling, yScaling);
	}

	void Start () {
		GameObject tmpCamera;
		cameraId = cameraCounter;

		cameraCounter++;

		// set up camera grid
		if (cameraId == 0) {
			for(int j = 0; j <= camY; j++){
				for(int i = 0; i <= camX; i++){ 
						int tmp = (j*camX) + i + j;
						tmpCamera = new GameObject();
						tmpCamera.transform.position = new Vector3((float) i, (float) j, 0);
						tmpCamera.name = "camera " + tmp.ToString();
						tmpCamera.AddComponent<Camera>();
						tmpCamera.transform.parent = gameObject.transform;
						AdjustViewPort(tmpCamera, i, j);
						
						tmpCamera.GetComponent<Camera>().fieldOfView = fov;

						// color stuff
						tmpCamera.GetComponent<Camera>().clearFlags = CameraClearFlags.SolidColor;
						if(i%2 != j%2){
							tmpCamera.GetComponent<Camera>().backgroundColor = Color.white;
						} else{
							tmpCamera.GetComponent<Camera>().backgroundColor = Color.black;
						}
					//}
				}
			}
		}
	}

}
