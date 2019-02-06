using UnityEngine;
using UnityEditor;

[CustomEditor(typeof(BezierExample))]
public class DrawBezierExample : Editor
{
    private void OnSceneViewGUI(SceneView sv)
    {
        BezierExample be = target as BezierExample;

        be.startPoint = Handles.PositionHandle(be.startPoint, Quaternion.identity);
        be.endPoint = Handles.PositionHandle(be.endPoint, Quaternion.identity);
        be.startTangent = Handles.PositionHandle(be.startTangent, Quaternion.identity);
        be.endTangent = Handles.PositionHandle(be.endTangent, Quaternion.identity);
        Handles.color = Color.cyan;
        Handles.DotHandleCap(0,be.startPoint,Quaternion.identity,0.1f,EventType.Repaint);
        Handles.DotHandleCap(0,be.endPoint,Quaternion.identity,0.1f,EventType.Repaint);
        Handles.color = Color.magenta;
        Handles.DotHandleCap(0,be.startTangent,Quaternion.identity,0.1f,EventType.Repaint);
        Handles.DotHandleCap(0,be.endTangent,Quaternion.identity,0.1f,EventType.Repaint);
        Handles.DrawBezier(be.startPoint, be.endPoint, be.startTangent, be.endTangent, Color.yellow, null, 5f);
        Handles.Label(be.startPoint + Vector3.up * 2,
            "0");
        Handles.Label(be.startTangent + Vector3.up * 2,
            "1");
        Handles.Label(be.endTangent + Vector3.up * 2,
            "2");
        Handles.Label(be.endPoint + Vector3.up * 2,
            "3");
    }

    void OnEnable()
    {
        SceneView.onSceneGUIDelegate += OnSceneViewGUI;
    }

    void OnDisable()
    {
        SceneView.onSceneGUIDelegate -= OnSceneViewGUI;
    }
}