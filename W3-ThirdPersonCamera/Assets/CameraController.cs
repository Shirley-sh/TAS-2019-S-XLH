using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class CameraController : MonoBehaviour{
    public float distanceDefault;
    public Vector3 cameraBaseOffsetDefault;
    public float moveSpeed;
    public float rotationSpeed;
    public float heightOffsetRange;

    private Transform app;
    private Transform view;
    private Transform cameraBase;
    private Transform camera;
    private Transform avatar;
    private GameObject[] objectsOfInterest;

    private Vector3 targetPosition;
    private Vector3 cameraBaseOffset;
    [SerializeField]private float distance;
    private float rotationYOffset;
    [SerializeField]private float heightOffset;
    private float heightDefault;
    
    
    private enum CameraMode {
        AUTO,
        MANUAL,
        TARGET_IN_SIGHT
    }

    private CameraMode mode = CameraMode.AUTO;
    
    private void Awake(){
        app = GameObject.Find("Application").transform;
        view = app.Find("View");
        objectsOfInterest = GameObject.FindGameObjectsWithTag("objectOfInterest");
        cameraBase = view.Find("CameraBase");
        camera = cameraBase.Find("Camera");
        avatar = view.Find("AIThirdPersonController");

        cameraBaseOffset = cameraBaseOffsetDefault;
        distance = distanceDefault * 1;
        rotationYOffset = 0;
        heightDefault = camera.localPosition.y;
        targetPosition = avatar.position;
    }


    private void LateUpdate() {
        if (Input.GetMouseButton(1)) {
            SetToManual();
        }
        //update states
        Transform objectOfInterest = FindTargetInSight();
        if (objectOfInterest!=null) {
            SetToTargetInSight();
        } else if(mode == CameraMode.TARGET_IN_SIGHT){
            SetToAuto();
        }
        
        //apply condition
        switch (mode) {
                case CameraMode.TARGET_IN_SIGHT:  
                    heightOffset = Mathf.Lerp(heightOffset, heightOffsetRange*2, Time.deltaTime);
                    targetPosition = objectOfInterest.position*0.5f + avatar.position*0.5f;
                    if (HasNoProtentialCollision()) {
                        distance = Mathf.Lerp(distance, distanceDefault * 3f, Time.deltaTime*1.5f);
                    } else if(IsColliding()){
                        distance = Mathf.MoveTowards(distance,1.5f,Time.deltaTime*3);
                    }
                    break;
                case CameraMode.MANUAL:
                    if (Input.GetMouseButton(1)) {
                        //mouse Y controls vertical slide (camera height)
                        heightOffset += Input.GetAxis("Mouse Y") * 0.05f;
                        if (heightOffset > heightOffsetRange) heightOffset = heightOffsetRange;
                        if (heightOffset < -1 * heightOffsetRange) heightOffset = heightOffsetRange * -1;
                        //mouse X controls horizontal slide (camera base rotation)
                        rotationYOffset += Input.GetAxis("Mouse X") * 5;
                    }

                    targetPosition = avatar.position;
                    
                    if (HasNoProtentialCollision()) {
                        distance = Mathf.Lerp(distance, distanceDefault, Time.deltaTime*1.5f);
                    } else if(IsColliding()){
                        distance = Mathf.MoveTowards(distance,1.5f,Time.deltaTime*3);
                        heightOffset = heightOffsetRange * -0.5f;
                    }
                    break;
                case CameraMode.AUTO:
                    targetPosition = avatar.position;
                    rotationYOffset = 0;
                    heightOffset = Mathf.Lerp(heightOffset, 0, Time.deltaTime);
                    if (HasNoProtentialCollision()) {
                        distance = Mathf.Lerp(distance, distanceDefault, Time.deltaTime*1.5f);
                    } else if(IsColliding()){
                        distance = Mathf.MoveTowards(distance,1.5f,Time.deltaTime*3);
                    }
                    break;
        }
        
        
        //update cameraBase
        cameraBase.position = Vector3.Lerp(cameraBase.position,targetPosition + cameraBaseOffset, Time.deltaTime*moveSpeed);
        AlignCameraRotation(rotationYOffset);
        //update camera
        camera.localPosition = new Vector3(camera.localPosition.x,heightDefault+heightOffset,camera.localPosition.z);
        camera.localPosition = camera.localPosition.normalized * distance;
        camera.LookAt(cameraBase);
    }

    private Transform FindTargetInSight() {
        foreach (var go in objectsOfInterest) {
            Transform target = go.transform;
            Vector3 fromCameraToTarget = target.position - camera.position;
            float angle = Vector3.Angle(camera.forward, fromCameraToTarget.normalized);
            if(angle<camera.gameObject.GetComponent<Camera>().fieldOfView){ //in sight
                if (Vector3.Distance(avatar.position, target.position) < 7) { //close enough
                    return target;
                }

            }

        }
        return null;
    }



    public void SetToAuto() {mode = CameraMode.AUTO;}
    public void SetToManual() { mode = CameraMode.MANUAL; }
    public void SetToTargetInSight() { mode = CameraMode.TARGET_IN_SIGHT; }
    
    #region Helper Functions
    
    private bool IsColliding() {
        Collider[] hitColliders = Physics.OverlapSphere(camera.position+camera.forward.normalized*0.5f, 0.75f);
        if (hitColliders.Length >= 1) {
            foreach (var c in hitColliders) {
                if (!c.gameObject.CompareTag("Player") && !c.gameObject.CompareTag("ground")) {
                    return true;
                }
            }

        }
        return false;
        
    }
    
    private bool HasNoProtentialCollision() {
        bool hasObj = false;
        Collider[] hitColliders = Physics.OverlapSphere(camera.position+camera.forward.normalized, 1.5f);
        if (hitColliders.Length >= 1) {
            foreach (var c in hitColliders) {
                if (!c.gameObject.CompareTag("Player") && !c.gameObject.CompareTag("ground")) {
                    hasObj =  true;
                }
            }
            
        }
        return !hasObj;
        
    }
    
    
    
    private void AlignCameraRotation (float yOffset) {
        Quaternion targetRotation = avatar.rotation * Quaternion.Euler(Vector3.up * yOffset);
        if ( Mathf.Abs(Quaternion.Angle(targetRotation, cameraBase.rotation)) > 1f) {
            cameraBase.rotation = Quaternion.Slerp(cameraBase.rotation, targetRotation, Time.deltaTime * rotationSpeed);
        }
        
    }

    #endregion

}
