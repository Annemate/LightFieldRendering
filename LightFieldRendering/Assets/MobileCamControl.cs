using UnityEngine;
using System.Collections;

public class MobileCamControl : MonoBehaviour {

	public int focusDistance;
	private int oldFocusDistance;
	public bool captureImage = false;
	public bool startBracketing = false;
	private int bracketingCounter;
	public int StopBracteing = 1000;
	
	[HideInInspector]
	public string focusUrl = "http://192.168.43.123:5000/?k=33&v=0";
	[HideInInspector]
	public string captureUrl = "http://192.168.43.123:5000/?k=23&v=0";
	
	void Start() {
		oldFocusDistance = focusDistance;
		//StartCoroutine(Capture());
	}
	
	void Update(){
		if(focusDistance != oldFocusDistance){
			print("focus");
			oldFocusDistance = focusDistance;
			focusUrl = "http://192.168.43.123:5000/?k=33&v=" + focusDistance.ToString();
			StartCoroutine(Focus());
		}
		
		if(captureImage){
			print("capture");
			captureImage = false;
			StartCoroutine(Capture());
		}
		
		if (startBracketing){
			//focusDistance = 500;
			startBracketing = false;
			StartCoroutine(Bracketing());
		}
	}

	
    
	IEnumerator Bracketing() {
        StartCoroutine(Focus());
		yield return new WaitForSeconds(1);
		StartCoroutine(Capture());
		focusDistance += 10;
		
		if(focusDistance < StopBracteing){
			yield return new WaitForSeconds(2);
			StartCoroutine(Bracketing());
		}else{
			print("DONE");
		}
		
        
    }
	
    IEnumerator Focus() {
		//print("focus routine");
        WWW www = new WWW(focusUrl);
        yield return www;
        
    }
	
	IEnumerator Capture() {
		//print("capture routine");
        WWW www = new WWW(captureUrl);
        yield return www;
        
    }
}
