//
//  SprintViewController.swift
//  Agile
//
//  Created by LUCAS GAMA on 4/19/22.
//

import UIKit

class SprintViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var sprintTasksTableView: UITableView!
    
    var currSprint = Sprints()
    var tasksInstance = TasksDataHandler()
    var tasksList = [Tasks]()
    

    override func viewDidLoad() {
        super.viewDidLoad()

        //set up table view
        sprintTasksTableView.delegate = self
        sprintTasksTableView.dataSource = self
        
//        self.navigationItem.rightBarButtonItem = self.editButtonItem
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.render()
        print("Project ID: \(currSprint.projectID)")
        print("Sprint ID: \(currSprint.sprintID)")
    }
    
    func render(){
        tasksList = tasksInstance.getTasksInSprint(projectID: currSprint.projectID, sprintID: currSprint.sprintID)
        sprintTasksTableView.reloadData()
    }
    
    // MARK: - Navigation
    @IBAction func unwindSegue (_ segue:UIStoryboardSegue){
        if segue.identifier == "saveSegue"{
            if let source = segue.source as? AddSprintTaskViewController{
                if source.addedTasktTitle.isEmpty == false{
                    let newTaskItem = Tasks() //create new Project instance
                    newTaskItem.taskTitle = source.addedTasktTitle
                    newTaskItem.taskDescription = source.addedTaskDescription
                    newTaskItem.projectID = currSprint.projectID //associate a task to a project id
                    newTaskItem.sprintID = currSprint.sprintID //associate a task to the current sprint being added
                    newTaskItem.isOnBacklog = false //mark the task as 'backlog' since it is been created on Backlog page
                    newTaskItem.taskConcluded = false
                    self.tasksInstance.addTask(newTask: newTaskItem)
                    self.render()
                }
            }
        }
//        if segue.identifier == "deleteSegue"{
//            if let source = segue.source as? TaskViewController{
//                let taskToDelete = source.taskToDeleteID
//                tasksInstance.deleteSingleTask(taskItem: taskToDelete)
//            }
//        }
        self.render()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "taskSelectionSegue"{
            if let destinationVC = segue.destination as? TaskSelectionViewController {
                destinationVC.currSprint = currSprint //pass as reference the current sprint (and consequently current project id as well)
                destinationVC.tasksInstance = tasksInstance
            }
        }
        else if segue.identifier == "sprintTasksCell"{
            if let destinationVC = segue.destination as? TaskViewController {
                if let indexPath = sprintTasksTableView.indexPath(for: (sender as? UITableViewCell)!) {
                    let item = tasksList[indexPath.row]
                    destinationVC.currTask = item //pass as reference the current task
                    destinationVC.tasksInstance = tasksInstance
                }
            }
        }
    }
    
    
    // MARK: - Table View
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasksList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "sprintTasksCell", for: indexPath)

        // Configure the cell...
        var cellConfig = cell.defaultContentConfiguration()
        cellConfig.text = tasksList[indexPath.row].taskTitle
        //check if task is concluded to write a message
        if tasksList[indexPath.row].taskConcluded == true {
            cellConfig.secondaryText = "Done"
        }
        else {
            cellConfig.secondaryText = "In progress"
        }

        cell.contentConfiguration = cellConfig
        return cell
    }
    
    // Override to support editing the table view.
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            let taskItem = tasksList[indexPath.row]
            tasksInstance.deleteSingleTask(taskItem: taskItem)
            self.render()
        }
    }

}
