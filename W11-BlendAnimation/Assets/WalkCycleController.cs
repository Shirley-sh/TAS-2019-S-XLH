using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class WalkCycleController : MonoBehaviour {
    private Animator anim;
    private float timer;
    [Range(0,15f)]
    public float speed;
   
    // Start is called before the first frame update
    void Start(){
        anim = GetComponent<Animator>();
    }

    // Update is called once per frame
    void Update() {
        timer += Time.deltaTime*speed;
        float animSpeed = speed/15*2-1;
        anim.SetFloat("Time", (Mathf.Sin(timer)));
        anim.SetFloat("Speed", (Mathf.Sin(animSpeed)));

    }
}
