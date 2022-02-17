//
//  ProjectDataLoader.swift
//  Agile
//
//  Created by LUCAS GAMA on 2/15/22.
//

import Foundation

class ProjectDataLoader{
    var allData = [DataModel]()
    
    func loadData(fileName: String){
        if let pathURL = Bundle.main.url(forResource: fileName, withExtension: "plist"){
            let dataDecoder = PropertyListDecoder()
            do{
                let data = try Data(contentsOf: pathURL)
                allData = try dataDecoder.decode([DataModel].self, from: data)
            } catch {
                print("Error while getting the data: \(error)")
            }
        }
    }
    
    func getProject() -> [String]{
        var projects = [String]()
        for item in allData{
            print("All Data: \(allData)")
            projects.append(item.project)
        }
        return projects
    }
    
    func getDescription(idx: Int) -> String{
        return allData[idx].project_description
    }
    
    func getBacklog(idx: Int) -> [String]{
        return allData[idx].backlog
    }
    /*
    func createProject(projectName: String){
        allData.append(projectName) //double check if this can be used to create a new project
    }
    */
    func addBacklogTask(projectIdx: Int, newBacklogTask: String, position: Int){
        allData[projectIdx].backlog.insert(newBacklogTask, at: position)
    }
}
