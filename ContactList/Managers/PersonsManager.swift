//
//  ContactManager.swift
//  ContactList
//
//  Created by Martynov Evgeny on 15.04.22.
//

import Foundation

// Менеджер контактов, для работы с persons
class PersonsManager {
    
    // MARK: Private

    private var persons: [Person] = []
    
    // MARK: Internal

    var personsCount: Int {
        persons.count
    }

    func add(person: Person) {
        if !persons.contains(person) {
            persons.append(person)
        }
    }

    func person(at index: Int) -> Person {
        persons[index]
    }
}
