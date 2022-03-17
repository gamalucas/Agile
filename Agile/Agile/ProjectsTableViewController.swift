//
//  ProjectsTableViewController.swift
//  Agile
//
//  Created by LUCAS GAMA on 3/3/22.
//

import UIKit

class ProjectsTableViewController: UITableViewController {
    
    var projectsInstance = ProjectsDataHandler()
    var projectsList = [Project]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //register this table view with ProjectTableViewCell
        let nib = UINib(nibName: "ProjectTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "projectCell")
        
        projectsInstance.dbSetup()
        projectsList = projectsInstance.getProjects()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    func render(){
        //function to reload table view everytime needed
        projectsList = projectsInstance.getProjects()
        tableView.reloadData()
    }
    
    @IBAction func unwindSegue (_ segue:UIStoryboardSegue){
        if segue.identifier == "saveSegue"{
            if let source = segue.source as? AddProjectViewController{
                if source.addedProjectName.isEmpty == false{
                    let newProjectItem = Project() //create new Project instance
                    newProjectItem.projectName = source.addedProjectName
                    newProjectItem.projectDescription = source.addedProjectDescription
                    self.projectsInstance.addProject(newProject: newProjectItem)
                    self.render()
                }
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "projectDetailSegue" {
            if let destinationVC = segue.destination as? InsideProjectViewController {
                if let indexPath = tableView.indexPathForSelectedRow?.row { 
                    let item = projectsList[indexPath]
                    destinationVC.title = item.projectName
//                    destinationVC.projectID = String(item.projectID)
//                    destinationVC.projectsInstance = projectsInstance
                    destinationVC.currProject = item
                    destinationVC.idxProject = indexPath
                }
            }
        }
    }

    // MARK: - Table view data source

//    override func numberOfSections(in tableView: UITableView) -> Int {
//        // #warning Incomplete implementation, return the number of sections
//        return 1
//    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return projectsList.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "projectCell", for: indexPath) as! ProjectTableViewCell

        // Configure the cell...
        let item = projectsList[indexPath.row]
        cell.projectTitleLabel.text = item.projectName
        cell.projectDecriptionLabel.text = item.projectDescription

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // Place code you want to be performed when a cell is tapped inside of here, for example:
        performSegue(withIdentifier: "projectDetailSegue", sender: Any?.self) 
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

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
