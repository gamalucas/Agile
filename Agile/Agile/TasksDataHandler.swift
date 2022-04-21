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
    
    func getBacklogTasks(projectID: ObjectId)->[Tasks]{
        var projectTasks = [Tasks]()
        
        if taskData.isEmpty == true{
            print("No tasks for this project yet")
            return projectTasks
        }
        
        for i in taskData{
            if i.projectID == projectID && i.isOnBacklog == true{
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
    
    func getTasksInSprint(projectID: ObjectId, sprintID: ObjectId)->[Tasks]{
        var projectTasks = [Tasks]()
        
        if taskData.isEmpty == true{
            print("No tasks related to this sprint yet")
            return projectTasks
        }
        
        for i in taskData{
            if i.projectID == projectID && i.sprintID == sprintID{
                projectTasks.append(i)
            }
        }
        return projectTasks
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
    
    func updateTaskSprintID(currTask: Tasks, newSprintID: ObjectId){
        do {
            try myRealm.write({
                if currTask.sprintID == newSprintID { //handle the case that you want to unselect an project (disconect if from Sprint ID)
                    currTask.sprintID = currTask.tasksID //give a id that is not the same as the sprint ID
                    currTask.isOnBacklog = false //remove task from backlog
                }
                else{
                    currTask.sprintID = newSprintID
                    currTask.isOnBacklog = false
                }
            })
        } catch let error{
            print("Error while updating task: \(error.localizedDescription)")
        }
    }
    
    func setDoneProperty(currTask: Tasks, isDone: Bool){
        do{
            try myRealm.write({
                if isDone == true {
                    currTask.taskConcluded = true
                }
                else{
                    currTask.taskConcluded = false
                }
            })
        } catch let error{
            print("Error while updating task: \(error.localizedDescription)")
        }
    }
    
    func deleteTasks(projectID: ObjectId, sprintID: ObjectId?){
        do{
            try myRealm.write({
                //search for project and sprint to delete tasks
                if sprintID == nil { //if sprint ID is nill, it means that I'm deleting the whole project
                    for (idx,task) in taskData.enumerated(){
                        if task.projectID == projectID {
                            myRealm.delete(taskData[idx])
                        }
                    }
                }
                else {
                    for (idx,task) in taskData.enumerated(){
                        if task.projectID == projectID && task.sprintID == sprintID {
                            myRealm.delete(taskData[idx])
                        }
                    }
                }
            })
            
        } catch let error{
            print("Error while deleting task: \(error.localizedDescription)")
        }
    }
    
    func deleteSingleTask(taskItem: Tasks){
        do{
            try myRealm.write({
                myRealm.delete(taskItem)
            })
            
        } catch let error{
            print("Error while deleting task: \(error.localizedDescription)")
        }
    }
}

