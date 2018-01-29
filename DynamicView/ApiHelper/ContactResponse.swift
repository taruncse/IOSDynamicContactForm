//
//  ContactResponse.swift
//  DynamicView
//
//  Created by Tarun Kumar on 2018-01-29.
//  Copyright © 2018 Tarun Kumar. All rights reserved.
//

// To parse the JSON, add this file to your project and do:
//
//   let contactResponse = try? JSONDecoder().decode(ContactResponse.self, from: jsonData)

import Foundation

class ContactResponse: Codable {
    let firstName: String
    let middleName: String
    let lastName: String
    let title: String
    let company: String
    let primaryEmail: String
    let otherEmails: [OtherEmail]
    let primaryPhone: String
    let otherPhones: [OtherPhone]
    let primaryAddress: Address
    let otherAddresses: [Address]
    let relations: [Relation]
    let familyMembers: [FamilyMember]
    let assistants: [Assistant]
    let facebook: String
    let linkedin: String
    let twitter: String
    let website: String
    let userID: String
    let associatedFiles: [JSONAny]
    let sharedFiles: [JSONAny]
    let dateModified: String
    let isUser: Bool
    let isTrustedAdvisor: Bool
    let isInvited: Bool
    let active: Bool
    
    enum CodingKeys: String, CodingKey {
        case firstName = "firstName"
        case middleName = "middleName"
        case lastName = "lastName"
        case title = "title"
        case company = "company"
        case primaryEmail = "primaryEmail"
        case otherEmails = "otherEmails"
        case primaryPhone = "primaryPhone"
        case otherPhones = "otherPhones"
        case primaryAddress = "primaryAddress"
        case otherAddresses = "otherAddresses"
        case relations = "relations"
        case familyMembers = "familyMembers"
        case assistants = "assistants"
        case facebook = "facebook"
        case linkedin = "linkedin"
        case twitter = "twitter"
        case website = "website"
        case userID = "userId"
        case associatedFiles = "associatedFiles"
        case sharedFiles = "sharedFiles"
        case dateModified = "dateModified"
        case isUser = "isUser"
        case isTrustedAdvisor = "isTrustedAdvisor"
        case isInvited = "isInvited"
        case active = "active"
    }
}

/*class Assistant: Codable {
    let firstName: String
    let middleName: String
    let lastName: String
    let phone: String
    let email: String
    
    enum CodingKeys: String, CodingKey {
        case firstName = "firstName"
        case middleName = "middleName"
        case lastName = "lastName"
        case phone = "phone"
        case email = "email"
    }
}*/

class FamilyMember: Codable {
    let title: String
    let firstName: String
    let middleName: String
    let lastName: String
    let phone: String
    let email: String
    let notes: String
    
    enum CodingKeys: String, CodingKey {
        case title = "title"
        case firstName = "firstName"
        case middleName = "middleName"
        case lastName = "lastName"
        case phone = "phone"
        case email = "email"
        case notes = "notes"
    }
}

/*class Address: Codable {
    let street: String
    let city: String
    let stateProvince: String
    let country: String
    let unit: String
    let zip: String
    
    enum CodingKeys: String, CodingKey {
        case street = "street"
        case city = "city"
        case stateProvince = "stateProvince"
        case country = "country"
        case unit = "unit"
        case zip = "zip"
    }
}*/

class OtherEmail: Codable {
    let type: String
    let number: String
    
    enum CodingKeys: String, CodingKey {
        case type = "type"
        case number = "number"
    }
}

class OtherPhone: Codable {
    let type: String
    let email: String
    
    enum CodingKeys: String, CodingKey {
        case type = "type"
        case email = "email"
    }
}

class Relation: Codable {
    let relations: String
    let family: String
    
    enum CodingKeys: String, CodingKey {
        case relations = "relations"
        case family = "family"
    }
}

// MARK: Encode/decode helpers

class JSONNull: Codable {
    public init() {}
    
    public required init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if !container.decodeNil() {
            throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
        }
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encodeNil()
    }
}

class JSONCodingKey: CodingKey {
    let key: String
    
    required init?(intValue: Int) {
        return nil
    }
    
    required init?(stringValue: String) {
        key = stringValue
    }
    
    var intValue: Int? {
        return nil
    }
    
    var stringValue: String {
        return key
    }
}

class JSONAny: Codable {
    public let value: Any
    
    static func decodingError(forCodingPath codingPath: [CodingKey]) -> DecodingError {
        let context = DecodingError.Context(codingPath: codingPath, debugDescription: "Cannot decode JSONAny")
        return DecodingError.typeMismatch(JSONAny.self, context)
    }
    
    static func encodingError(forValue value: Any, codingPath: [CodingKey]) -> EncodingError {
        let context = EncodingError.Context(codingPath: codingPath, debugDescription: "Cannot encode JSONAny")
        return EncodingError.invalidValue(value, context)
    }
    
    static func decode(from container: SingleValueDecodingContainer) throws -> Any {
        if let value = try? container.decode(Bool.self) {
            return value
        }
        if let value = try? container.decode(Int64.self) {
            return value
        }
        if let value = try? container.decode(Double.self) {
            return value
        }
        if let value = try? container.decode(String.self) {
            return value
        }
        if container.decodeNil() {
            return JSONNull()
        }
        throw decodingError(forCodingPath: container.codingPath)
    }
    
    static func decode(from container: inout UnkeyedDecodingContainer) throws -> Any {
        if let value = try? container.decode(Bool.self) {
            return value
        }
        if let value = try? container.decode(Int64.self) {
            return value
        }
        if let value = try? container.decode(Double.self) {
            return value
        }
        if let value = try? container.decode(String.self) {
            return value
        }
        if let value = try? container.decodeNil() {
            if value {
                return JSONNull()
            }
        }
        if var container = try? container.nestedUnkeyedContainer() {
            return try decodeArray(from: &container)
        }
        if var container = try? container.nestedContainer(keyedBy: JSONCodingKey.self) {
            return try decodeDictionary(from: &container)
        }
        throw decodingError(forCodingPath: container.codingPath)
    }
    
    static func decode(from container: inout KeyedDecodingContainer<JSONCodingKey>, forKey key: JSONCodingKey) throws -> Any {
        if let value = try? container.decode(Bool.self, forKey: key) {
            return value
        }
        if let value = try? container.decode(Int64.self, forKey: key) {
            return value
        }
        if let value = try? container.decode(Double.self, forKey: key) {
            return value
        }
        if let value = try? container.decode(String.self, forKey: key) {
            return value
        }
        if let value = try? container.decodeNil(forKey: key) {
            if value {
                return JSONNull()
            }
        }
        if var container = try? container.nestedUnkeyedContainer(forKey: key) {
            return try decodeArray(from: &container)
        }
        if var container = try? container.nestedContainer(keyedBy: JSONCodingKey.self, forKey: key) {
            return try decodeDictionary(from: &container)
        }
        throw decodingError(forCodingPath: container.codingPath)
    }
    
    static func decodeArray(from container: inout UnkeyedDecodingContainer) throws -> [Any] {
        var arr: [Any] = []
        while !container.isAtEnd {
            let value = try decode(from: &container)
            arr.append(value)
        }
        return arr
    }
    
    static func decodeDictionary(from container: inout KeyedDecodingContainer<JSONCodingKey>) throws -> [String: Any] {
        var dict = [String: Any]()
        for key in container.allKeys {
            let value = try decode(from: &container, forKey: key)
            dict[key.stringValue] = value
        }
        return dict
    }
    
    static func encode(to container: inout UnkeyedEncodingContainer, array: [Any]) throws {
        for value in array {
            if let value = value as? Bool {
                try container.encode(value)
            } else if let value = value as? Int64 {
                try container.encode(value)
            } else if let value = value as? Double {
                try container.encode(value)
            } else if let value = value as? String {
                try container.encode(value)
            } else if value is JSONNull {
                try container.encodeNil()
            } else if let value = value as? [Any] {
                var container = container.nestedUnkeyedContainer()
                try encode(to: &container, array: value)
            } else if let value = value as? [String: Any] {
                var container = container.nestedContainer(keyedBy: JSONCodingKey.self)
                try encode(to: &container, dictionary: value)
            } else {
                throw encodingError(forValue: value, codingPath: container.codingPath)
            }
        }
    }
    
    static func encode(to container: inout KeyedEncodingContainer<JSONCodingKey>, dictionary: [String: Any]) throws {
        for (key, value) in dictionary {
            let key = JSONCodingKey(stringValue: key)!
            if let value = value as? Bool {
                try container.encode(value, forKey: key)
            } else if let value = value as? Int64 {
                try container.encode(value, forKey: key)
            } else if let value = value as? Double {
                try container.encode(value, forKey: key)
            } else if let value = value as? String {
                try container.encode(value, forKey: key)
            } else if value is JSONNull {
                try container.encodeNil(forKey: key)
            } else if let value = value as? [Any] {
                var container = container.nestedUnkeyedContainer(forKey: key)
                try encode(to: &container, array: value)
            } else if let value = value as? [String: Any] {
                var container = container.nestedContainer(keyedBy: JSONCodingKey.self, forKey: key)
                try encode(to: &container, dictionary: value)
            } else {
                throw encodingError(forValue: value, codingPath: container.codingPath)
            }
        }
    }
    
    static func encode(to container: inout SingleValueEncodingContainer, value: Any) throws {
        if let value = value as? Bool {
            try container.encode(value)
        } else if let value = value as? Int64 {
            try container.encode(value)
        } else if let value = value as? Double {
            try container.encode(value)
        } else if let value = value as? String {
            try container.encode(value)
        } else if value is JSONNull {
            try container.encodeNil()
        } else {
            throw encodingError(forValue: value, codingPath: container.codingPath)
        }
    }
    
    public required init(from decoder: Decoder) throws {
        if var arrayContainer = try? decoder.unkeyedContainer() {
            self.value = try JSONAny.decodeArray(from: &arrayContainer)
        } else if var container = try? decoder.container(keyedBy: JSONCodingKey.self) {
            self.value = try JSONAny.decodeDictionary(from: &container)
        } else {
            let container = try decoder.singleValueContainer()
            self.value = try JSONAny.decode(from: container)
        }
    }
    
    public func encode(to encoder: Encoder) throws {
        if let arr = self.value as? [Any] {
            var container = encoder.unkeyedContainer()
            try JSONAny.encode(to: &container, array: arr)
        } else if let dict = self.value as? [String: Any] {
            var container = encoder.container(keyedBy: JSONCodingKey.self)
            try JSONAny.encode(to: &container, dictionary: dict)
        } else {
            var container = encoder.singleValueContainer()
            try JSONAny.encode(to: &container, value: self.value)
        }
    }
}

