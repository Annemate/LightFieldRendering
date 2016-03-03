using UnityEngine;
using System.Collections;

public class Spacing : MonoBehaviour {

    public float xScaling = 0.0651f;
    public float yScaling = 0.1157f;
    public Camera myCamera;
    [Range(0, 14)]
    public int lensXaxis;
    [Range(0, 7)]
    public int lensYaxis;

    [Range(-0.1f, 0.1f)]
    public float xAxisFineAdjustment;
    [Range(-0.1f, 0.1f)]
    public float yAxisFineAdjustment;

    static float commonX;
    static float commonY;
	// Use this for initialization
	void Start () {
        //myCamera = gameObject.GetComponent<Camera>();
	}

	// Update is called once per frame
	void Update () {
        if(gameObject.name == "Main Camera (0)"){
            commonX = xAxisFineAdjustment;
            commonY = yAxisFineAdjustment;
        }

        if(gameObject.name == "TEST CAMERA"){
            myCamera.rect = new Rect (((float)lensXaxis * xScaling) + xAxisFineAdjustment  + commonX, ((float)lensYaxis * yScaling) + yAxisFineAdjustment  + commonY, xScaling, yScaling);
        }else{
            myCamera.rect = new Rect (((float)lensXaxis * xScaling) + commonX, ((float)lensYaxis * yScaling) + commonY, xScaling, yScaling);
	    }
    }
}
