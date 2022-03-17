//
//  DataModel.swift
//  Agile
//
//  Created by LUCAS GAMA on 3/3/22.
//

import Foundation
import RealmSwift

class Project: Object {
    @Persisted(primaryKey: true) var projectID = ObjectId.generate()
    @Persisted var projectName = ""
    @Persisted var projectDescription = ""
}

class Tasks: Object {
    @Persisted(primaryKey: true) var tasksID = ObjectId.generate()
    @Persisted var projectID: ObjectId
    @Persisted var taskTitle = ""
    @Persisted var taskDescription = ""
    @Persisted var taskConcluded = false
    @Persisted var taskSprint = ""
}
