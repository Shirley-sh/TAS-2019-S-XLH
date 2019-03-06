using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class TerrainGenerator : MonoBehaviour{
    public GameObject chunk;
    public GameObject target;
    
    private float scale;
    private List<GameObject> chunks;

    private Vector3 _intPos;
    private Vector3 _oldIntPos;

    void Start() {
        scale = chunk.GetComponent<ChunkExample>().sizeSquare;
        chunks = new List<GameObject>();

        for (int i = 0; i < 3; i++){
            for (int j = 0; j < 3; j++) {
                GameObject newChunk = Instantiate(chunk, new Vector3((j-1)*scale, 0, (i-1)*scale), Quaternion.identity);

                chunks.Add(newChunk);
            }
        }
    }

    void Update(){
        _intPos = new Vector3(Mathf.Floor(target.transform.position.x/scale), 0, Mathf.Floor(target.transform.position.z/scale));

        if (_intPos != _oldIntPos){
            if (_intPos.x > _oldIntPos.x){
                foreach(GameObject g in chunks){
                    g.transform.position += Vector3.right*scale;
                }
            }
            if (_intPos.x < _oldIntPos.x){
                foreach(GameObject g in chunks){
                    g.transform.position -= Vector3.right*scale;
                }
            }
            if (_intPos.z > _oldIntPos.z){
                foreach (GameObject g in chunks){
                    g.transform.position += Vector3.forward*scale;
                }
            }
            if (_intPos.z < _oldIntPos.z){
                foreach (GameObject g in chunks){
                    g.transform.position -= Vector3.forward*scale;
                }
            }

            _oldIntPos = _intPos;
            foreach (GameObject g in chunks) {
                g.GetComponent<ChunkExample>().Reset();
            }
        }
    }
}
