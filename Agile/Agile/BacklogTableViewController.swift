//
//  BacklogTableViewController.swift
//  Agile
//
//  Created by LUCAS GAMA on 3/16/22.
//

import UIKit

class BacklogTableViewController: UITableViewController {
    
    var projectsInstance = ProjectsDataHandler()
    var currProject = Project()
    var tasksInstance = TasksDataHandler()
    var backlogList = [Tasks]()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
         self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    override func viewWillAppear(_ animated: Bool) {
        print("Current project id on Backlog: \(currProject.projectID)")
        print("Backlog list: \(backlogList)")
        self.render()
    }
    
    func render(){
        backlogList = tasksInstance.getBacklogTasks(projectID: currProject.projectID)
        tableView.reloadData()
        print("Backlog list: \(backlogList)")
    }
    
    @IBAction func unwindSegue (_ segue:UIStoryboardSegue){
        if segue.identifier == "saveSegue"{
            if let source = segue.source as? AddTaskViewController{
                if source.addedTasktTitle.isEmpty == false{
                    let newTaskItem = Tasks() //create new Project instance
                    newTaskItem.taskTitle = source.addedTasktTitle
                    newTaskItem.taskDescription = source.addedTaskDescription
                    newTaskItem.projectID = currProject.projectID //associate a task to a project id
                    newTaskItem.isOnBacklog = true //mark the task as 'backlog' since it is been created on Backlog page
                    newTaskItem.taskConcluded = false
                    self.tasksInstance.addTask(newTask: newTaskItem)
                    self.render()
                }
            }
        }
    }
    

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return backlogList.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "backlogCell", for: indexPath)

        // Configure the cell...
        var cellConfig = cell.defaultContentConfiguration()
        cellConfig.text = backlogList[indexPath.row].taskTitle
        
        cell.contentConfiguration = cellConfig
        return cell
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            let taskItem = backlogList[indexPath.row]
            tasksInstance.deleteSingleTask(taskItem: taskItem)
            self.render()
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
