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
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        print("Project ID: \(currSprint.projectID)")
        print("Sprint ID: \(currSprint.sprintID)")
    }
    
    // MARK: - Navigation
    @IBAction func unwindSegue (_ segue:UIStoryboardSegue){
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "taskSelectionSegue"{
            if let destinationVC = segue.destination as? TaskSelectionViewController {
                destinationVC.currSprint = currSprint //pass as reference the current sprint (and consequently current project id as well)
                destinationVC.tasksInstance = tasksInstance
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
//        var cellConfig = cell.defaultContentConfiguration()
//        cellConfig.text = "Sprint " + String(sprintsList[indexPath.row].sprintNumber)
//
//        cell.contentConfiguration = cellConfig
        return cell
    }

}
