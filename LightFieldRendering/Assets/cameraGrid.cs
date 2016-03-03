using UnityEngine;
using System.Collections;

public class cameraGrid : MonoBehaviour {

    [Range(-0.3f, 0.3f)]
    public float xAxisFineAdjustment;
    [Range(-0.3f, 0.3f)]
    public float yAxisFineAdjustment;

    private float initialX;
    private float initialY;
    private float initialShit;

	// Use this for initialization
	void Start () {
	initialX = transform.position.z;
    initialY = transform.position.y;
    initialShit = transform.position.x;
	}

	// Update is called once per frame
	void Update () {
	   transform.position = new Vector3(initialShit, initialY + yAxisFineAdjustment, initialX + xAxisFineAdjustment);
	}
}
