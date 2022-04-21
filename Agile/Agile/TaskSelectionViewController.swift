//
//  TaskSelectionViewController.swift
//  Agile
//
//  Created by LUCAS GAMA on 4/19/22.
//

import UIKit

class TaskSelectionViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var unsolvedTasksTableView: UITableView!
    
    var currSprint = Sprints()
    var tasksInstance = TasksDataHandler()
    var unsolvedTasksList = [Tasks]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //set up table view
        unsolvedTasksTableView.delegate = self
        unsolvedTasksTableView.dataSource = self

        // Get all unsolved tasks
        unsolvedTasksList = tasksInstance.getUnsolvedTasks(projectID: currSprint.projectID)
        print("Unsolved tasks list: \(unsolvedTasksList)")
    }
    
    func render(){
        unsolvedTasksTableView.reloadData()
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    
    // MARK: - Table View
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return unsolvedTasksList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "unsolvedTasksCell", for: indexPath)

        // Configure the cell...
        var cellConfig = cell.defaultContentConfiguration()
        cellConfig.text = unsolvedTasksList[indexPath.row].taskTitle
        
        cell.contentConfiguration = cellConfig
        if  unsolvedTasksList[indexPath.row].sprintID == currSprint.sprintID{
            cell.accessoryType = .checkmark
        }
        else{
            cell.accessoryType = .none
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) { //logic for clicking in a row
        //set task to sprint id
        tasksInstance.updateTaskSprintID(currTask: unsolvedTasksList[indexPath.row], newSprintID: currSprint.sprintID)
        self.render()
    }

}
