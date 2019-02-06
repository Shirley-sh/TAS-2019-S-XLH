using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEditor;

public class LookAtUnityBezier : MonoBehaviour {

    [Header("Public References")]
    public Transform myModel;

    [Header("My List of Curves")]
    public List<BezierExample> curveList = new List<BezierExample>();


}


