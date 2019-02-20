using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class ThirdPersonCameraController : MonoBehaviour {

//    #region Internal References
    private Transform _app;
    private Transform _view;
    private Transform _cameraBaseTransform;
    private Transform _cameraTransform;
    private Transform _cameraLookTarget;
    private Transform _avatarTransform;
//    #endregion

//    #region Public Tuning Variables
    public Vector3 avatarObservationOffset_Base;
    public float followDistance_Base;
    public float verticalOffset_Base;
//    public float pitchGreaterLimit;
//    public float pitchLowerLimit;
//    public float fovAtUp;
//    public float fovAtDown;
//    #endregion

//    #region Persistent Outputs
    //Positions
    private Vector3 _camRelativePostion_Auto;

    //Directions
    private Vector3 _avatarLookForward;

    //Scalars
    private float _followDistance_Applied;
    private float _verticalOffset_Applied;
//    #endregion

    private void Awake()
    {
        _app = GameObject.Find("Application").transform;
        _view = _app.Find("View");
        _cameraBaseTransform = _view.Find("CameraBase");
        _cameraTransform = _cameraBaseTransform.Find("Camera");
        _cameraLookTarget = _cameraBaseTransform.Find("CameraLookTarget");

        _avatarTransform = _view.Find("AIThirdPersonController");
    }

    private void Update(){
        //update states
        if (Input.GetMouseButton(1))
            _ManualUpdate();
        else
            _AutoUpdate();
        
        //apply behaviors
        //lerp target
        //lerp distance
        //
    }

    private void _AutoUpdate()
    {
        _ComputeData();
        _FollowAvatar();
        _LookAtAvatar();
    }
    private void _ManualUpdate()
    {
        _FollowAvatar();
        _ManualControl();
    }

//    #region Internal Logic

    float _standingToWalkingSlider = 0;

    private void _ComputeData(){
        _avatarLookForward = Vector3.Normalize(Vector3.Scale(_avatarTransform.forward, new Vector3(1, 0, 1)));

        if (_Helper_IsWalking())
        {
            _standingToWalkingSlider = Mathf.MoveTowards(_standingToWalkingSlider, 1, Time.deltaTime * 3);
        }
        else
        {
            _standingToWalkingSlider = Mathf.MoveTowards(_standingToWalkingSlider, 0, Time.deltaTime);
        }

        float _followDistance_Walking = followDistance_Base*2;
        float _followDistance_Standing = followDistance_Base;

        float _verticalOffset_Walking = verticalOffset_Base*2;
        float _verticalOffset_Standing = verticalOffset_Base;

        _followDistance_Applied = Mathf.Lerp(_followDistance_Standing, _followDistance_Walking, _standingToWalkingSlider);
        _verticalOffset_Applied = Mathf.Lerp(_verticalOffset_Standing, _verticalOffset_Walking, _standingToWalkingSlider);
    }
    

    private void _FollowAvatar(){
        _camRelativePostion_Auto = _avatarTransform.position;
        _cameraTransform.position = _avatarTransform.position - _avatarLookForward * _followDistance_Applied + Vector3.up * _verticalOffset_Applied;
    }

    private void _LookAtAvatar(){
        _cameraLookTarget.position = _avatarTransform.position + avatarObservationOffset_Base;
        _cameraTransform.LookAt(_cameraLookTarget);
    }

//    private void _ManualControl(){
//        Vector3 _camEulerHold = _cameraTransform.localEulerAngles;
//
//        if (Input.GetAxis("Mouse X") != 0)
//            _camEulerHold.y += Input.GetAxis("Mouse X");
//
//        if (Input.GetAxis("Mouse Y") != 0)
//        {
//            float temp = _camEulerHold.x - Input.GetAxis("Mouse Y");
//            temp = (temp + 360) % 360;
//
//            if (temp < 180)
//                temp = Mathf.Clamp(temp, 0, 80);
//            else
//                temp = Mathf.Clamp(temp, 360 - 80, 360);
//
//            _camEulerHold.x = temp;
//        }
//
//        Debug.Log("The V3 to be applied is " + _camEulerHold);
//        _cameraTransform.localRotation = Quaternion.Euler(_camEulerHold);
//    }
    
    private void _ManualControl(){
        Vector3 _camEulerHold = _cameraTransform.localEulerAngles;

        if (Input.GetAxis("Mouse X") != 0)
            _camEulerHold.y += Input.GetAxis("Mouse X");

        if (Input.GetAxis("Mouse Y") != 0)
        {
            float temp = _camEulerHold.x - Input.GetAxis("Mouse Y");
            temp = (temp + 360) % 360;

            if (temp < 180)
                temp = Mathf.Clamp(temp, 0, 80);
            else
                temp = Mathf.Clamp(temp, 360 - 80, 360);

            _camEulerHold.x = temp;
        }

        Debug.Log("The V3 to be applied is " + _camEulerHold);
        _cameraTransform.localRotation = Quaternion.Euler(_camEulerHold);
    }
//    #endregion

    #region Helper Functions

    private Vector3 _lastPos;
    private Vector3 _currentPos;
    private bool _Helper_IsWalking()
    {
        _lastPos = _currentPos;
        _currentPos = _avatarTransform.position;
        float velInst = Vector3.Distance(_lastPos, _currentPos) / Time.deltaTime;

        if (velInst > .15f)
            return true;
        else return false;
    }

    #endregion
}
