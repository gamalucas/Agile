//
//  AddProjectViewController.swift
//  Agile
//
//  Created by LUCAS GAMA on 3/7/22.
//

import UIKit

class AddProjectViewController: UIViewController {

    @IBOutlet weak var projectNameTxtField: UITextField!
    @IBOutlet weak var projectDescriptioTxtField: UITextField!
    
    var addedProjectName = String()
    var addedProjectDescription = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "saveSegue"{
            if projectNameTxtField.text?.isEmpty == false {
                addedProjectName = projectNameTxtField.text!
                addedProjectDescription = projectDescriptioTxtField.text!
            }
        }
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
