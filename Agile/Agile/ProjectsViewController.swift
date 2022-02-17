//
//  ProjectsViewController.swift
//  Agile
//
//  Created by LUCAS GAMA on 2/15/22.
//

import UIKit

class ProjectsViewController: UIViewController {
    
    @IBOutlet weak var projectNameLabel: UILabel!
    @IBOutlet weak var projectDescriptionLabel: UILabel!
    
    var projectList = [String]()
    var projectDescription = String()
    var backlog = [String]()
    var projectData = ProjectDataLoader()
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        projectData.loadData(fileName: "dataPList")
        projectList = projectData.getProject()
        projectDescription = projectData.getDescription(idx: 0) //DOUBLE CHECK HOW TO MAKE THIS DYNAMIC
        backlog = projectData.getBacklog(idx: 0)
        
        print("Project List: \(projectList[0])")
        print("Project Desc.: \(projectDescription)")
        print("Project backlog: \(backlog)")
        
        projectNameLabel.text = projectList[0]
        projectDescriptionLabel.text = projectDescription
    }
    
    @IBAction func unwindSegue (_ segue:UIStoryboardSegue){
        
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
