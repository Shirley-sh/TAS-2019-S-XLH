using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class CameraController: MonoBehaviour {
	public float moveSpeed;
	public float rotSpeed;
	public LookAtUnityBezier laub;
	private List<BezierExample> curveList;
	private float currentTime;

	private Transform cam;
	// Use this for initialization
	void Start() {
		currentTime = 0;
		curveList = laub.curveList;
		cam = Camera.main.transform;
	}
	
	// Update is called once per frame
	void Update () {
		float pTime = currentTime;
		int pCurveIndex = (int)pTime % curveList.Count;
		float pTangent = pTime - (int) pTime;
		BezierExample pCurve = curveList[pCurveIndex];
		Vector3 pPos = GetPosFromCurve(pCurve, pTangent);
		
		currentTime += Time.deltaTime * moveSpeed;
		int currentCurveIndex = (int)currentTime % curveList.Count;
		float tangent = currentTime - (int) currentTime;
		BezierExample currentCurve = curveList[currentCurveIndex];
		Vector3 pos = GetPosFromCurve(currentCurve, tangent);

		Quaternion rotation = Quaternion.LookRotation(pos - pPos, Vector3.up);
		cam.rotation = Quaternion.Lerp(cam.rotation, rotation, Time.deltaTime * rotSpeed);
		
		cam.position = Vector3.Lerp(pPos, pos, Time.deltaTime);
	}
	
	Vector3 GetPosFromCurve(BezierExample curveData, float t)
	{
		Vector3 a = curveData.startPoint;
		Vector3 b = curveData.startTangent;
		Vector3 c = curveData.endTangent;
		Vector3 d = curveData.endPoint;

		Vector3 ab = Vector3.Lerp(a, b, t);
		Vector3 bc = Vector3.Lerp(b, c, t);
		Vector3 cd = Vector3.Lerp(c, d, t);

		Vector3 abc = Vector3.Lerp(ab, bc, t);
		Vector3 bcd = Vector3.Lerp(bc, cd, t);

		Vector3 final = Vector3.Lerp(abc, bcd, t);

		return final;
	}
}
