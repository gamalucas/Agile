//
//  ProjectsDataHandler.swift
//  Agile
//
//  Created by LUCAS GAMA on 3/3/22.
//

import Foundation
import RealmSwift

class ProjectsDataHandler {
    var myRealm: Realm! //instanciate realm database
    var projectsData: Results<Project> //make a collection of Project objects
    {
        get{
            return myRealm.objects(Project.self) //return all Project objects from Realm
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
    
    func getProjects()->[Project]{
        return Array(projectsData)
    }
    
    func addProject(newProject: Project){
        do {
            try myRealm.write({
                myRealm.add(newProject) //add a new project to database (this includes name and description)
            })
        } catch let err {
            print("Error during addProject: \(err.localizedDescription)")
        }
    }
    
    func deleteProject(projectItem: Project){
        do{
            try myRealm.write({
                myRealm.delete(projectItem)
            })
        } catch let err{
            print("Error during addProject: \(err.localizedDescription)")
        }
    }
    
}

