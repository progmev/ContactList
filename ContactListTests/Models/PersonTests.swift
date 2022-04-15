//
//  PersonTests.swift
//  ContactListTests
//
//  Created by Martynov Evgeny on 31.03.21.
//

import XCTest
@testable import ContactList

class PersonTests: XCTestCase {

    var imageData: Data?

    override func setUp() {
        super.setUp()
        let image = #imageLiteral(resourceName: "avatar")
        imageData = image.pngData()
    }

    override func tearDown() {
        imageData = nil
        super.tearDown()
    }

    // проверка инициализации модели Person (имя и телефон обязательны)
    func testInitPersonWithNameAndPhone() {
        let person = Person(name: "name", phone: "phone")
        XCTAssertNotNil(person) // проверка на nil
    }

    // проверка полной инициализации модели Person (имя фамилия и телефон обязательны)
    func testInitPersonWithFullNameAndPhone() {
        let person = Person(name: "name", surname: "surname", phone: "phone")
        XCTAssertNotNil(person)
    }

    // проверка что значения действительно установлены в модели
    func testWhenGivenNameAndPhoneSetsNameAndPhone() {
        let person = Person(name: "name", phone: "phone")
        XCTAssertEqual(person.name, "name")
        XCTAssertEqual(person.phone, "phone")
    }

    // проверка фамилии
    func testWhenGivenSurnameSetsSurname() {
        let person = Person(name: "name", surname: "surname", phone: "phone")
        XCTAssertTrue(person.surname == "surname")
    }

    // проверка факта добавления Date
    func testInitPersonWithDate() {
        let person = Person(name: "name", phone: "phone")
        XCTAssertNotNil(person.date)
    }

    // проверка факта добавления Date в полном инициализаторе
    func testInitPersonWithFullNameAndDate() {
        let person = Person(name: "name", surname: "surname", phone: "phone")
        XCTAssertNotNil(person.date)
    }

    // проверка факта добавления картинки
    func testInitPersonWithImage() {
        let person = Person(name: "name", phone: "phone", imageData: imageData)
        XCTAssertNotNil(person.imageData)
    }

    // проверка факта добавления картинки в полном инициализаторе
    func testInitPersonWithFullNameAndImage() {
        let person = Person(name: "name", surname: "surname", phone: "phone", imageData: imageData)
        XCTAssertNotNil(person.imageData)
    }
}
