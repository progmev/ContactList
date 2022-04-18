//
//  Person.swift
//  ContactList
//
//  Created by Martynov Evgeny on 31.03.21.
//

import Foundation

struct Person {

    var name: String
    var phone: String
    var surname: String?
    var imageData: Data?
    private(set) var date: Date?
    // private(set) - у переменной теперь есть только get, свойство может быть установлено только в пределах кода, который является частью структуры

    init(name: String,
         phone: String,
         imageData: Data? = nil) {
        self.name = name
        self.phone = phone
        self.imageData = imageData
        date = Date()
    }

    init(name: String,
         surname: String,
         phone: String,
         imageData: Data? = nil) {
        self.name = name
        self.surname = surname
        self.phone = phone
        self.imageData = imageData
        date = Date()
    }
}

// MARK: Equatable

// Equatable по умолчанию сравнивает все св-ва
// Date соот-нно не равны

extension Person: Equatable {
    static func == (lhs: Person, rhs: Person) -> Bool {
        (lhs.name == rhs.name) && (lhs.phone == rhs.phone) // left-hand side
    }
}
