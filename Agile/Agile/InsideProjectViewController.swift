//
//  InsideProjectViewController.swift
//  Agile
//
//  Created by LUCAS GAMA on 3/14/22.
//

import UIKit

class InsideProjectViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var projectsInstance = ProjectsDataHandler()
    var currProject = Project()
    var idxProject = 0
    var tasksInstance = TasksDataHandler()
    var tasksList = [Tasks]()
    var projectID = ""
    var sprintsInstance = SprintsDataHandler()
    var sprintsList = [Sprints]()

    @IBOutlet weak var sprintTableView: UITableView!
    
    @IBAction func newSprintBT(_ sender: Any) {
        let sprintsStored = sprintsInstance.getSprints(projectID: currProject.projectID) //temp varuiable to get the amount of Sprints created for a given projet
        let newSprintItem = Sprints() //create a new sprint object
        newSprintItem.projectID = currProject.projectID //assign current project ID to sprint being created
        if sprintsStored.isEmpty == true { //check if any sprints exist. If not, assign 1 to this sprint. Otherwise assign the follow number
            newSprintItem.sprintNumber = 1
        }
        else {
            newSprintItem.sprintNumber = sprintsStored.count + 1
        }
        sprintsInstance.addSprint(newSprint: newSprintItem) //add this sprint object to realm data
        self.render()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //set up table view
        sprintTableView.delegate = self
        sprintTableView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        sprintsList = sprintsInstance.getSprints(projectID: currProject.projectID)
        print("Current project id: \(currProject.projectID)")
        print("Sprints in list: \(sprintsList)")
    }
    
    func render(){
        sprintsList = sprintsInstance.getSprints(projectID: currProject.projectID)
        print("Sprints in list: \(sprintsList)")
    }
    
    // MARK: - Navigation
    
    @IBAction func unwindSegue (_ segue:UIStoryboardSegue){
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "backlogSegue" {
            if let destinationVC = segue.destination as? BacklogTableViewController {
                destinationVC.currProject = currProject
            }
        }
        else if segue.identifier == "sprintDetailSegue"{
            if let destinationVC = segue.destination as? SprintViewController {
                if let indexPath = sprintTableView.indexPath(for: (sender as? UITableViewCell)!) {
                    let item = sprintsList[indexPath.row]
                    destinationVC.title = "Sprint " + String(item.sprintNumber)
                    destinationVC.currSprint = item //pass as reference the current sprint (and consequently current project id as well)
                    destinationVC.tasksInstance = tasksInstance 
                }
            }
        }
    }
    
    // MARK: - Sprint Table View
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sprintsList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "sprintsCell", for: indexPath)

        // Configure the cell...
        var cellConfig = cell.defaultContentConfiguration()
        cellConfig.text = "Sprint " + String(sprintsList[indexPath.row].sprintNumber)
        
        cell.contentConfiguration = cellConfig
        return cell
    }

}
