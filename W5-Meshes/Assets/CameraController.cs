using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class CameraController : MonoBehaviour{

    // Update is called once per frame
    void Update(){
        float xAxisValue = Input.GetAxis("Horizontal");
        float zAxisValue = Input.GetAxis("Vertical");
        transform.Translate(new Vector3(xAxisValue, 0.0f, zAxisValue));
    }
}
