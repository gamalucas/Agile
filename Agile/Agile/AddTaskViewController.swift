//
//  AddTaskViewController.swift
//  Agile
//
//  Created by LUCAS GAMA on 4/11/22.
//

import UIKit

class AddTaskViewController: UIViewController {

    @IBOutlet weak var taskNameTxtField: UITextField!
    @IBOutlet weak var taskDescriptionTxtField: UITextField!
    
    var addedTasktTitle = String()
    var addedTaskDescription = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "saveSegue"{
            if taskNameTxtField.text?.isEmpty == false {
                addedTasktTitle = taskNameTxtField.text!
                addedTaskDescription = taskDescriptionTxtField.text!
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
