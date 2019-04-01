using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Rotate : MonoBehaviour {
	public enum Axis{
		X,
		Y,
		Z
	}

	public Axis axis;
	public float speed;
	public bool auto = true;

	
	// Update is called once per frame
	void Update () {
		if (auto) {
			switch (axis) {
				case Axis.X:
					transform.RotateAround(transform.right, speed * Time.deltaTime);
					break;
				case Axis.Y:
					transform.RotateAround(transform.up, speed * Time.deltaTime);
					break;
				case Axis.Z:
					transform.RotateAround(transform.forward, speed * Time.deltaTime);
					break;
			}
		}
	}

	public void Flip() {
		speed *= -1;
		
	}

	public void ToggleStop() { auto = !auto; }
}
