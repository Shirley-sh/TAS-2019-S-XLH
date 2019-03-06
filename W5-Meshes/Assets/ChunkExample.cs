using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class ChunkExample : MonoBehaviour
{
    private MeshFilter meshFilter;
    private MeshRenderer meshRenderer;
    private Material material;

    private Mesh mesh;

    private Vector3[] verts;
    private int[] tris;
    private Vector2[] uVs;
    private Vector3[] normals;

    public int sizeSquare;
    private int totalVertInd;
    private int totalTrisInd;

    private void Awake(){
        meshFilter = gameObject.AddComponent<MeshFilter>();
        meshRenderer = gameObject.AddComponent<MeshRenderer>();
        material = Resources.Load<Material>("MyMat");
        mesh = new Mesh();
        meshRenderer.material = material;
    }

    private void Start(){
        Init();
        CalcMesh();
        ApplyMesh();
    }


    public void Reset() {
        CalcMesh();
        ApplyMesh();
    }

    private void Init(){
        totalVertInd = (sizeSquare + 1) * (sizeSquare + 1);
        totalTrisInd = (sizeSquare) * (sizeSquare) * 2 * 3;
        verts = new Vector3[totalVertInd];
        tris = new int[totalTrisInd];
        uVs = new Vector2[totalVertInd];
        normals = new Vector3[totalVertInd];
    }
    
    private void CalcMesh(){
        
        for (int z = 0; z <= sizeSquare; z++){
            for (int x = 0; x <= sizeSquare; x++) {
                Vector3 v = GetVertPos(x, z);
                verts[(z * (sizeSquare + 1)) + x] = v;
                normals[(z * (sizeSquare + 1)) + x] = GetSmoothedNormal(x, z);
            }
        }

        int triInd = 0;
        for (int i = 0; i < sizeSquare; i++){
            for (int j = 0; j < sizeSquare; j++){
                int bottomLeft = j + (i * (sizeSquare + 1)); // true as long as j < sizesquare - 1
                int bottomRight = j + (i * (sizeSquare + 1)) + 1; // true as long as j < sizesquare -1
                int topLeft = j + ((i + 1) * (sizeSquare + 1));
                int topRight = j + ((i + 1) * (sizeSquare + 1)) + 1;

                tris[triInd] = bottomLeft;
                triInd++;
                tris[triInd] = topLeft;
                triInd++;
                tris[triInd] = bottomRight;
                triInd++;
                tris[triInd] = topLeft;
                triInd++;
                tris[triInd] = topRight;
                triInd++;
                tris[triInd] = bottomRight;
                triInd++;
            }
        }
    }

    private void ApplyMesh(){
        mesh.vertices = verts;
        mesh.triangles = tris;
        mesh.normals = normals;
        meshFilter.mesh = mesh;
    }
    
    private Vector3 GetVertPos(float x, float z) {
        //Base Height
        float y= 15*(Mathf.PerlinNoise(
                         (x + transform.position.x)/30,
                         (z + transform.position.z)/30)+0.5f);
        
        //Detailed Bump
        y += (Mathf.PerlinNoise(
                  (x + transform.position.x) *2.237f,
                  (z + transform.position.z) *2.237f)+0.5f);
        
        return new Vector3(x,y,z);    
    }

    private Vector3 GetSmoothedNormal(float x, float z) {
        Vector3 v = GetVertPos(x, z);
        Vector3 v1 = GetVertPos(x-1, z-1);
        Vector3 v2 = GetVertPos(x-1, z+1);
        Vector3 v3 = GetVertPos(x+1, z+1);
        Vector3 v4 = GetVertPos(x+1, z-1);

        Vector3 d1 = v - v1;
        Vector3 d2 = v - v2;
        Vector3 d3 = v - v3;
        Vector3 d4 = v - v4;
        
        Vector3 normal = Vector3.Cross(d1,d2)+Vector3.Cross(d2,d3)+
                         Vector3.Cross(d3,d4)+Vector3.Cross(d4,d1);

        return normal.normalized;
        
    }
    

}
