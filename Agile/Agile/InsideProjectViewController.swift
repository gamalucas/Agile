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

    @IBOutlet weak var sprintTableView: UITableView!
    
    @IBAction func newSprintBT(_ sender: Any) {
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //set up table view
        sprintTableView.delegate = self
        sprintTableView.dataSource = self

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        print("Current project id: \(currProject.projectID)")
        //tasksList = tasksInstance.getTasks()
    }
    
    @IBAction func unwindSegue (_ segue:UIStoryboardSegue){
        
    }
    
    // MARK: - Sprint Table View
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "____", for: indexPath)

        // Configure the cell...
//        let item = projectsList[indexPath.row]
//        cell.projectTitleLabel.text = item.projectName
//        cell.projectDecriptionLabel.text = item.projectDescription

        return cell
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
