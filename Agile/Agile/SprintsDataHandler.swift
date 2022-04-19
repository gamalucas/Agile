//
//  SprintsDataHandler.swift
//  Agile
//
//  Created by LUCAS GAMA on 4/19/22.
//

import Foundation
import RealmSwift

class SprintsDataHandler {
    var myRealm: Realm! //instanciate realm database
    var sprintsData: Results<Sprints> //make a collection of Project objects
    {
        get{
            return myRealm.objects(Sprints.self) //return all Project objects from Realm
        }
    }
    
    init(){
        // call db setup
        dbSetup()
    }
    
    func dbSetup(){
        do {
            myRealm = try Realm()
        } catch let err {
            print("Error during dbSetup: \(err.localizedDescription)")
        }
        print("Realm Project database location: \(Realm.Configuration.defaultConfiguration.fileURL!)")
    }
    
    func getSprints()->[Sprints]{
        return Array(sprintsData)
    }
    
    func addSprint(newSprint: Sprints){
        do {
            try myRealm.write({
                myRealm.add(newSprint) //add a new project to database (this includes name and description)
            })
        } catch let err {
            print("Error during addProject: \(err.localizedDescription)")
        }
    }
    
    func getSprints(projectID: ObjectId)->[Sprints]{
        var projectSprints = [Sprints]()
        
        if projectSprints.isEmpty == true{
            print("No SPRINTS for this project yet")
        }
        
        for i in sprintsData{
            if i.projectID == projectID{
                projectSprints.append(i)
            }
        }
        return projectSprints
    }
    
    func deleteSprint(sprintItem: Sprints){
        do{
            try myRealm.write({
                myRealm.delete(sprintItem)
            })
        } catch let err{
            print("Error during addProject: \(err.localizedDescription)")
        }
    }
    
}
