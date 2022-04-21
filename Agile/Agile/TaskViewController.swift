//
//  TaskViewController.swift
//  Agile
//
//  Created by LUCAS GAMA on 4/20/22.
//

import UIKit

class TaskViewController: UIViewController {
    
    var tasksInstance = TasksDataHandler()
    var currTask = Tasks()
    var taskToDelete = Tasks()

    @IBOutlet weak var taskTitleLable: UILabel!
    @IBOutlet weak var taskDescriptionLabel: UILabel!
    @IBOutlet weak var taskDoneButtonOutlet: UIButton!
    @IBOutlet weak var taskDoneLable: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        print("Current task is: \(currTask)")
        self.render()
    }
    
    func render(){
        //set view layout (title, description, and switch)
        taskTitleLable.text = currTask.taskTitle
        if currTask.taskDescription == "" {
            taskDescriptionLabel.text = "No description for this task"
        }
        else {
            taskDescriptionLabel.text = currTask.taskDescription
        }
        
        if currTask.taskConcluded == false{
            taskDoneButtonOutlet.setTitle("Click to conclude task", for: .normal)
            taskDoneLable.text = "Task isn't done"
        }
        else{
            taskDoneButtonOutlet.setTitle("Undo task conclusion", for: .normal)
            taskDoneLable.text = "This task is concluded"
        }

    }
    
    @IBAction func taskDoneButton(_ sender: Any) {
        if currTask.taskConcluded == false{
            tasksInstance.setDoneProperty(currTask: currTask, isDone: true)
        }
        else{
            tasksInstance.setDoneProperty(currTask: currTask, isDone: false)
        }
        self.render()
    }
//    @IBAction func deleteButton(_ sender: Any) {
//        //call delete function and delete task
//        tasksInstance.deleteSingleTask(taskItem: currTask)
//    }
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if segue.identifier == "deleteSegue"{
//            taskToDelete = currTask
//        }
//    }
    
    
    // MARK: - Navigation

}
