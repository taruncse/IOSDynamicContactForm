//
// Created by Tarun Kumar on 2018-01-29.
// Copyright (c) 2018 Tarun Kumar. All rights reserved.
//

import Foundation

struct Assistant : Equatable, Codable {
    var firstName: String
    var middleName: String
    var lastName: String
    var phone: String
    var email: String

    enum CodingKeys: String, CodingKey {
        case firstName = "firstName"
        case middleName = "middleName"
        case lastName = "lastName"
        case phone = "phone"
        case email = "email"
    }
}
func ==(lhs: Assistant, rhs: Assistant) -> Bool {
    return lhs.email == rhs.email
}
