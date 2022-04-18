//
//  ContactListAppTests.swift
//  ContactListTests
//
//  Created by Martynov Evgeny on 15.04.22.
//

@testable import ContactList
import XCTest

class ContactListAppTests: XCTestCase {
    override func setUp() {
        super.setUp()
    }

    override func tearDown() {
        super.tearDown()
    }

    // проверим то что InitialViewController -> это ContactListViewController
    func testInitialViewControllerIsContactListViewController() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let navigationController = storyboard.instantiateInitialViewController() as! UINavigationController
        let rootViewController = navigationController.viewControllers.first // первый контроллер

        XCTAssertTrue(rootViewController is ContactListViewController)
    }
}
