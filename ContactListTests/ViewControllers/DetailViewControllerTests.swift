//
//  DetailViewControllerTests.swift
//  ContactListTests
//
//  Created by Martynov Evgeny on 15.04.22.
//

@testable import ContactList
import XCTest

class DetailViewControllerTests: XCTestCase {
    var detailVC: DetailViewController!

    override func setUp() {
        super.setUp()
        // инициализируем
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        detailVC = storyboard.instantiateViewController(
            withIdentifier: "DetailViewController"
        ) as? DetailViewController
        // viewDidLoad
        detailVC.loadViewIfNeeded()
    }

    override func tearDown() {
        detailVC = nil
        super.tearDown()
    }

    // есть ли в class и на storyboard nameLabel?
    func testHasNameLable() {
        XCTAssertTrue(detailVC.nameLabel.isDescendant(of: detailVC.view))
    }

    // есть ли в class и на storyboard phoneLabel?
    func testHasPhoneLable() {
        XCTAssertTrue(detailVC.phoneLabel.isDescendant(of: detailVC.view))
    }

    // есть ли в class и на storyboard surnameLabel?
    func testHasSurnameLable() {
        XCTAssertTrue(detailVC.surnameLabel.isDescendant(of: detailVC.view))
    }

    // есть ли в class и на storyboard imageView?
    func testHasImageView() {
        XCTAssertTrue(detailVC.imageView.isDescendant(of: detailVC.view))
    }

    // проверяем содержимое nameLabel
    func testSetValueToNameLabel() {
        setupContactAndAppearanceTrancition()
        XCTAssertEqual(detailVC.nameLabel.text, "name")
    }

    // проверяем содержимое surname
    func testSetValueToSurnameLabel() {
        setupContactAndAppearanceTrancition()
        XCTAssertEqual(detailVC.surnameLabel.text, "surname")
    }

    // проверяем содержимое phone
    func testSetValueToPhoneLabel() {
        setupContactAndAppearanceTrancition()
        XCTAssertEqual(detailVC.phoneLabel.text, "phone")
    }

//    // Нельзя сраванить UIImage
//    func testSetValueToImageView() {
//        setupContactAndAppearanceTrancition()
//        XCTAssertEqual(detailVC.imageView.image, #imageLiteral(resourceName: "avatar")) // fail
//    }

    // проверяем содержимое imageData
    func testSetValueToImageView() {
        setupContactAndAppearanceTrancition()
        let imageData = #imageLiteral(resourceName: "avatar").pngData()
        XCTAssert(detailVC.person.imageData == imageData)
    }

    // обычная func
    func setupContactAndAppearanceTrancition() {
        let image = #imageLiteral(resourceName: "avatar")
        let imageData = image.pngData()
        let person = Person(name: "name",
                            surname: "surname",
                            phone: "phone",
                            imageData: imageData)
        // передаем в detailVC
        detailVC.person = person
        // beginAppearanceTransition - запускает методы viewWillAppear....
        detailVC.beginAppearanceTransition(true, animated: true)
        // endAppearanceTransition сообщает об оончании перехода
        detailVC.endAppearanceTransition()
    }
}
