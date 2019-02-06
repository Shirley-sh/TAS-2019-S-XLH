using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEditor;

[CustomEditor(typeof(LookAtUnityBezier))]
public class ButtonsForLAUB : Editor
{
    public override void OnInspectorGUI()
    {
        LookAtUnityBezier _myLAUB = (LookAtUnityBezier)target;

        DrawDefaultInspector();

        if (GUILayout.Button("Make new curve")){

            BezierExample newBE = _myLAUB.myModel.gameObject.AddComponent<BezierExample>();

            if (_myLAUB.curveList.Count > 0){
                BezierExample lastBE = _myLAUB.curveList[_myLAUB.curveList.Count - 1];

                newBE.startPoint = lastBE.endPoint;
                newBE.endPoint = lastBE.endPoint;
                newBE.startTangent = lastBE.endPoint;
                newBE.endTangent = lastBE.endPoint;
            }

            _myLAUB.curveList.Add(newBE);
        }
        
        if (GUILayout.Button("Close Loop")){
      
            if (_myLAUB.curveList.Count > 1){
                for (int i = 0; i < _myLAUB.curveList.Count; i++) {
                    BezierExample curve = _myLAUB.curveList[i];
                    int before = i - 1;
                    if (before < 0) before = _myLAUB.curveList.Count - 1;
                    int after = i + 1;
                    if (after >=  _myLAUB.curveList.Count) after = 0;
                    
                    curve.startPoint = _myLAUB.curveList[before].endPoint;
                    curve.endPoint = (_myLAUB.curveList[after].startPoint + _myLAUB.curveList[i].endPoint)/2;  
                }
            }

        }
        
    }
}
