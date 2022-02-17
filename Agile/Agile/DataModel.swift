//
//  DataModel.swift
//  Agile
//
//  Created by LUCAS GAMA on 2/15/22.
//

import Foundation

struct DataModel: Codable {
    var project: String
    var project_description: String
    var backlog: [String]
}
