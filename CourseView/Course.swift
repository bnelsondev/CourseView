//
//  Course.swift
//  CourseView
//
//  Created by Bryan Nelson on 1/22/21.
//

import Foundation

class Course: Codable {
    var title = ""
    var subtitle = ""
    var imageURL = ""
    
    enum CodingKeys: String, CodingKey {
        case title
        case subtitle
        case imageURL = "image"
    }
}
