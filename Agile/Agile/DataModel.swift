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
    @Persisted var projectName: String
    @Persisted var projectDescription: String
}

class Tasks: Object {
    @Persisted(primaryKey: true) var tasksID = ObjectId.generate()
    @Persisted var projectID: ObjectId
    @Persisted var sprintID: ObjectId
    @Persisted var taskTitle: String
    @Persisted var taskDescription: String
    @Persisted var taskConcluded: Bool
    @Persisted var isOnBacklog: Bool
}

class Sprints: Object {
    @Persisted (primaryKey: true) var sprintID = ObjectId.generate()
    @Persisted var projectID: ObjectId
    @Persisted var sprintNumber: Int
}
