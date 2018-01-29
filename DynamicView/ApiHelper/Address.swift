//
// Created by Tarun Kumar on 2018-01-29.
// Copyright (c) 2018 Tarun Kumar. All rights reserved.
//

import Foundation

struct Address : Equatable, Codable {
    var street: String
    var stateProvince: String
    var zip: String
    var country: String
    var city: String
    var unit: String

    enum CodingKeys: String, CodingKey {
        case street = "street"
        case city = "city"
        case stateProvince = "stateProvince"
        case country = "country"
        case unit = "unit"
        case zip = "zip"
    }
}

func ==(lhs: Address, rhs: Address) -> Bool {
    return lhs.street == rhs.street
}