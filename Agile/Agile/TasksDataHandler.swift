//
//  TasksDataHandler.swift
//  Agile
//
//  Created by LUCAS GAMA on 4/19/22.
//

import Foundation
import RealmSwift

class TasksDataHandler {
    var myRealm: Realm!
    var taskData: Results<Tasks>
    {
        get{
            return myRealm.objects(Tasks.self)
        }
    }
    
    init(){
        // call db setup
        dbSetup()
    }
    
    func dbSetup(){
        do{
            myRealm = try Realm()
        } catch let err {
            print("Error during dbSetup: \(err.localizedDescription)")
        }
        print("Realm Tasks database location: \(Realm.Configuration.defaultConfiguration.fileURL!)")
    }
    
    func getTasks(projectID: ObjectId)->[Tasks]{
        var projectTasks = [Tasks]()
        
        if taskData.isEmpty == true{
            print("No tasks for this project yet")
            return projectTasks
        }
        
        for i in taskData{
            if i.projectID == projectID{
                projectTasks.append(i)
            }
        }
        return projectTasks
    }
    
    func getUnsolvedTasks(projectID: ObjectId)->[Tasks]{
        var unsolvedProjectTasks = [Tasks]()
        
        if taskData.isEmpty == true{
            print("No unsolved tasks for this project")
            return unsolvedProjectTasks
        }
        
        for i in taskData{
            if i.projectID == projectID && i.taskConcluded == false{
                unsolvedProjectTasks.append(i)
            }
        }
        return unsolvedProjectTasks
    }
    
    func addTask(newTask: Tasks){
        do {
            try myRealm.write({
                myRealm.add(newTask) //add a new project to database (this includes name and description)
            })
        } catch let err {
            print("Error during addTask: \(err.localizedDescription)")
        }
    }
}

