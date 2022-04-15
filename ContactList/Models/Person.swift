//
//  Person.swift
//  ContactList
//
//  Created by Martynov Evgeny on 31.03.21.
//

import Foundation
import UIKit

struct Person {
    var name: String
    var surname: String?
    var phone: String
    let date = Date()
    
    var imageData: Data?
    
    init(name: String, phone: String, imageData: Data? = nil) {
        self.name = name
        self.phone = phone
        self.imageData = imageData
    }
    
    init(name: String, surname: String, phone: String, imageData: Data? = nil) {
        self.name = name
        self.surname = surname
        self.phone = phone
        self.imageData = imageData
    }
}

/*
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
 */
