using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class FlockingSystem : MonoBehaviour {
    public GameObject agentGO;
    private List<Agent> agents;
 
    public class Agent {
        GameObject go;
        Vector3 pos,vel,acc;
        float rad, destRad, maxSpeed, maxForce, power;
        Vector3 axis;
        
        public Agent(GameObject _go) {
            go = _go;
            pos = go.transform.position;
            maxSpeed = 2;
            maxForce = 0.05f;
            power = 0;
            vel = new Vector3(Random.Range(-10f,10f),Random.Range(-10f,10f),Random.Range(-10f,10f));
            acc = new Vector3(0,0,0);
        }

        public void Run(List<Agent> agents) {
            Flock(agents);
            UpdateStatus();
            Display();
        }
    
    
        void Flock(List<Agent> agents){
            Vector3 sep = Separate(agents);
            Vector3 ali = Align(agents);
            Vector3 coh = Cohesion(agents);
            // Arbitrarily weight these forces
            sep *= 3.0f;
            ali *= 1.0f;
            coh *= 0.5f;
            ApplyForce(sep);
            ApplyForce(ali);
            ApplyForce(coh);
        }
    
        void UpdateStatus(){
            power  = vel.magnitude/2;
            power +=acc.magnitude*2;
            vel += acc;
            pos.x = Mathf.Lerp(pos.x, pos.x+vel.x, 0.1f);
            pos.y = Mathf.Lerp(pos.y, pos.y+vel.y, 0.1f);
            pos.z = Mathf.Lerp(pos.z, pos.z+vel.z, 0.1f);
    
            pos += vel;
            acc *= 0;
            
            CheckEdges();
    
        }
    
        void Display() {
            go.transform.position = pos;
            go.transform.LookAt(go.transform.position+vel);
        }
        
        Vector3 Seek(Vector3 target){
            Vector3 desired = target - pos;
            desired.Normalize();
            desired *= maxSpeed;
            Vector3 steer = desired - vel;
            steer = Vector3.ClampMagnitude(steer,maxForce);
            return steer;
        }
        
        Vector3 Separate(List<Agent> agents){
            float desiredSeparation = 200.0f;
            Vector3 steer = new Vector3(0,0,0);
            int count = 0;
            for(int i = 0; i < agents.Count; i++) {
                float d = Vector3.Distance(pos, agents[i].pos);
                if ((d > 0) && (d < desiredSeparation)) {
                    Vector3 diff = pos - agents[i].pos;
                    diff.Normalize();
                    diff /= d;
                    steer += diff;
                    count++;
                }
            }
                if(count >0){
                    steer /= count;
                }
                if(steer.magnitude>0){
                    steer.Normalize();
                    steer*=maxSpeed;
                    steer-=vel;
                    steer = Vector3.ClampMagnitude(steer,maxForce);
                }
                return steer;
        }
        
        Vector3 Align(List<Agent> agents){
            int neighbordist = 100;
            Vector3 sum=new Vector3(0,0,0);
            int count = 0;
            for (int i = 0; i < agents.Count; i++) {
                float d = Vector3.Distance(pos, agents[i].pos);
                if ((d > 0) && (d < neighbordist)) {
                    sum+=agents[i].vel;
                    count++;
                }
                CheckCollision(agents[i]);
            }
            if (count > 0) {
                sum /= count;
                sum.Normalize();
                sum*=maxSpeed;
                Vector3 steer = sum -vel;
                steer = Vector3.ClampMagnitude(steer,maxForce);
                return steer;
            } else {
                return Vector3.zero;
            }
        }
        
        Vector3 Cohesion(List<Agent> agents){
            int neighbordist = 100;
            Vector3 sum=new Vector3(0,0,0);
            int count = 0;
            for (int i = 0; i < agents.Count; i++) {
                float d = Vector3.Distance(pos, agents[i].pos);
                    if ((d > 0) && (d < neighbordist)) {
                       sum+=agents[i].pos;
                       count++;
                    }
            }
            if (count > 0) {
                sum /= count;
                return Seek(sum);
            }
            
            return Vector3.zero;
            
        }
        
        void ApplyForce(Vector3 force){
            acc+=force;
        }
        
        void ApplyFriction(float amount){
            vel*=amount;
        }
        
        void ApplyAttraction(Vector3 target){
            Vector3 force = (target-pos).normalized;
            force *= 0.5f;
            ApplyForce(force);
        }
            
        void ApplyAttraction(Vector3 target, float amount){
            Vector3 force = (target-pos).normalized;
            force *= amount;
            ApplyForce(force);
        }
        
        void ApplyRepulsion(Vector3 target){
            Vector3 force = (target-pos).normalized;
            force *= -0.5f;
            ApplyForce(force);
        }
    
            
        void CheckCollision(Agent other){
            float distance = Vector3.Distance(pos,other.pos);
            if(distance<rad+other.rad){
                Vector3 force = pos - other.pos;
                force*=0.01f;
                ApplyForce(force);
                force = other.pos-pos;
                force*=0.01f;
                other.ApplyForce(force);
            }
        }
        
        void  CheckEdges() {
            float amount = -0.1f;
            if(pos.magnitude>800){
                Vector3 force =pos;
                force.Normalize();
                force*=amount;
                ApplyForce(force);
            }
        }
    
    }

    void Start() {
        agents = new List<Agent>();
        for (int i = 0; i < 20; i++) {
            GameObject agentInstance = Instantiate(agentGO);
            agentInstance.transform.parent = transform;
            Agent newAgent = new Agent(agentInstance);
            agents.Add(newAgent);
        }    
    }

    void Update() {
        foreach (Agent agent in agents) {
            agent.Run(agents);
        }
    }
}   
    
    
   

