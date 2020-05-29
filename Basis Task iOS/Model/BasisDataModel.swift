//
//  BasisDataModel.swift
//  Basis Task iOS
//
//  Created by mac on 29/05/20.
//  Copyright © 2020 Ganesh iOS. All rights reserved.
//

import Foundation

/**
 - Data Model (Array of Data Sets). Struct.
 */

struct BasisDataModel: Codable {
    var data: [BasisData]?
    
    enum CodingKeys: String, CodingKey {
        case data = "data"
    }
}

/**
- Single Data Set. Struct.
*/

struct BasisData: Codable {
    var id: String?
    var content: String?
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case content = "text"
    }
}
