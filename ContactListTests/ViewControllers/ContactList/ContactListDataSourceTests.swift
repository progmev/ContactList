//
//  ContactListDataSourceTests.swift
//  ContactListTests
//
//  Created by Martynov Evgeny on 15.04.22.
//

@testable import ContactList
import XCTest

// MARK: - ContactListDataSourceTests

class ContactListDataSourceTests: XCTestCase {
    var dataSource: ContactListDataSource!
    var mockTableView: MockTableView!
//    var contactListVC: ContactListViewController!
    var person: Person!

    override func setUp() {
        super.setUp()
        dataSource = ContactListDataSource()
        dataSource.personsManager = PersonsManager()

        mockTableView = MockTableView.mockTableView(withDataSource: dataSource)
        person = Person(name: "name1", phone: "phone1")
//
//        let storyboard = UIStoryboard(name: "Main", bundle: nil)
//        contactListVC = storyboard.instantiateViewController(
//            withIdentifier: "ContactListViewController"
//        ) as? ContactListViewController
//
//        contactListVC.loadViewIfNeeded()
    }

    override func tearDown() {
        dataSource = nil
        mockTableView = nil
//        contactListVC = nil
        person = nil
        super.tearDown()
    }

    // сколько секций содержится в таблице (1 секция)
    func testHasOneSection() {
        let numberOfSection = mockTableView.numberOfSections
        XCTAssertEqual(numberOfSection, 1)
    }

    // количество строк в таблице соответствует кол-ву контактов
    func testNumberOfRowsEqualsContactListCount() {
        dataSource.personsManager?.add(person: person)
        mockTableView.reloadData()
        XCTAssertEqual(mockTableView.numberOfRows(inSection: 0), 1)

        // проверим при добавлении нового контакта
        dataSource.personsManager?.add(
            person: Person(name: "name2", phone: "phone2")
        )
        mockTableView.reloadData()
        XCTAssertEqual(mockTableView.numberOfRows(inSection: 0), 2)
    }

    // проверяем что ячейка имеет тип ContactCell
    func testCellForRowAtIndexPathReturnsContactCell() {
        dataSource.personsManager?.add(person: person)
        mockTableView.reloadData()
        let cell = mockTableView.cellForRow(at: IndexPath(row: 0, section: 0))
        XCTAssertTrue(cell is ContactCell)
    }

    // действительно ли перееиспользуется наша ячейча
    // слайды + Mock таблица в extension
    func testCellForRowDequeuesCellFromTableView() {
        dataSource.personsManager?.add(person: person)
        mockTableView.reloadData()
        _ = mockTableView.cellForRow(at: IndexPath(row: 0, section: 0))
        // вызов cellForRow инициирует вызов dequeueReusableCell
        XCTAssert(mockTableView.cellIsDequeued)
    }

    // создаем moc объект для ячейки и пробуем присвоть в ячейку нашу модель
    func testCellForRowCallsConfigureCell() {
        dataSource.personsManager?.add(person: person)
        mockTableView.reloadData()

        // достаем 1 ячейку
        let cell = mockTableView.cellForRow(at: IndexPath(row: 0, section: 0)) as! MockContactCell

        // сравним person в ячейке с person
        XCTAssertEqual(cell.person, person)
    }
}

// MARK: - ContactListDataSourceTests extension

extension ContactListDataSourceTests {
    //  Mock таблица
    class MockTableView: UITableView {
        // ячейка была переопределена?
        var cellIsDequeued = false

        static func mockTableView(withDataSource dataSource: UITableViewDataSource) -> MockTableView {
            let mockTableView = MockTableView()
            mockTableView.dataSource = dataSource
            mockTableView.register(MockContactCell.self, forCellReuseIdentifier: "cell")
            return mockTableView
        }

        override func dequeueReusableCell(withIdentifier identifier: String, for indexPath: IndexPath) -> UITableViewCell {
            // если происходит вызов dequeueReusableCell меняем cellIsDequeued
            cellIsDequeued = true
            return super.dequeueReusableCell(withIdentifier: identifier, for: indexPath)
        }
    }

    //  Mock ячейка
    class MockContactCell: ContactCell {
        var person: Person?

        override func configure(with person: Person) {
            self.person = person
        }
    }
}
