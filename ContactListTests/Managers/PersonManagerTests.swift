//
//  ContactManagerTests.swift
//  ContactListTests
//
//  Created by Martynov Evgeny on 15.04.22.
//

import XCTest
@testable import ContactList

class PersonManagerTests: XCTestCase {

    var personsManager: PersonsManager!
    var person: Person!

    override func setUp() {
        super .setUp()
        print("- - - setUp - - -")
        personsManager = PersonsManager() // contactManager init
        person = Person(name: "name", phone: "phone")
    }

    override func tearDown() {
        print("- - - tearDown - - -")
        personsManager = nil // contactManager deinit
        person = nil
        super.tearDown()
    }

    // проверка пустого contactManager после инициализации
    func testInitContactManagerWithEmptyList() {
        print("1")
        XCTAssertEqual(personsManager.personsCount, 0)
    }

    // проверка добавления нового контакта
    func testAddPersonIncrementContactListCount() {
        print("2")
        personsManager.add(person: person)
        XCTAssertEqual(personsManager.personsCount, 1)
    }

    // контакт по индексу добавлен
    func testContactAtIndexIsAddedPerson() {
        print("3")
        personsManager.add(person: person)
        let returnedPerson = personsManager.person(at: 0)
        XCTAssertEqual(person, returnedPerson)
    }

    // делаем список только уникальных контактов
    func testAddingSameObjectDoesNotIncrementCount() {
        print("4")
        personsManager.add(person: Person(name: "name", phone: "phone"))
        personsManager.add(person: Person(name: "name", phone: "phone"))
        XCTAssertEqual(personsManager.personsCount, 1)
    }
}
