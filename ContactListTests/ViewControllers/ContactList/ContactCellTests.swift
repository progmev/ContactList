//
//  ContactCellTests.swift
//  ContactListTests
//
//  Created by Martynov Evgeny on 15.04.22.
//

import XCTest

@testable import ContactList

// MARK: - ContactCellTests

class ContactCellTests: XCTestCase {
    
    var cell: ContactCell!

    override func setUp() {
        super.setUp()

        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(
            withIdentifier: "ContactListViewController"
        ) as! ContactListViewController
        viewController.loadViewIfNeeded()
        // указатель на tableView
        let tableView = viewController.tableView
        let dataSource = MockTableViewDataSource()
        tableView?.dataSource = dataSource

        cell = tableView?.dequeueReusableCell(
            withIdentifier: "cell",
            for: IndexPath(row: 0, section: 0)
        ) as? ContactCell
    }

    override func tearDown() {
        cell = nil
        super.tearDown()
    }

    // проверяем содержит ли ячейка nameLabel
    func testCellHasNameLabel() {
        XCTAssertNotNil(cell.nameLabel)
    }

    // isDescendant - содержится ли в cell.contentView - nameLabel
    func testCellHasNameLabelInContentView() {
        XCTAssertTrue(cell.nameLabel.isDescendant(of: cell.contentView))
    }

    // проверка установки name в nameLabel
    func testConfigureSetsName() {
        let person = Person(name: "name", phone: "phone")
        cell.configure(with: person)
        XCTAssertEqual(cell.nameLabel.text, person.name)
    }
}

extension ContactCellTests {
    class MockTableViewDataSource: NSObject, UITableViewDataSource {
        // UITableViewDataSource к VC, а VC к NSObject
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            1
        }

        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            UITableViewCell()
        }
    }
}
