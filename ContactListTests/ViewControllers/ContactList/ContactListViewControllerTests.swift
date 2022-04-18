//
//  ContactListViewControllerTests.swift
//  ContactListTests
//
//  Created by Martynov Evgeny on 15.04.22.
//

@testable import ContactList
import XCTest

// MARK: - ContactListViewControllerTests

class ContactListViewControllerTests: XCTestCase {
    var sut: ContactListViewController!

    override func setUp() {
        super.setUp()
        // создаем контроллер через UIStoryboard
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        sut = storyboard.instantiateViewController(
            withIdentifier: "ContactListViewController"
        ) as? ContactListViewController
        sut.loadViewIfNeeded() // принудительно инициируем загрузку вью (viewDidLoad)
    }

    override func tearDown() {
        sut = nil
        super.tearDown()
    }

    // проверяем загрузку tableView
    func testWhenViewIsLoadedTableViewIsNotNil() {
        XCTAssertNotNil(sut.tableView)
    }

    // когда вью загружается в память dataSource не должен быть nil
    func testWhenViewIsLoadedContactListDataSourceIsNotNil() {
        XCTAssertNotNil(sut.dataSource)
    }

    // проверим установку dataSource в tableView
    func testWhenViewIsLoadedTableViewDataSourceIsSet() {
        XCTAssertTrue(sut.tableView.dataSource is ContactListDataSource)
    }

    // MARK: - UI TESTS

    // проверяем наличие кнопки "+"
    func testHasAddNewContactButton() {
        // target: AnyObject?
        let target = sut.navigationItem.rightBarButtonItem?.target as? ContactListViewController
        XCTAssertEqual(target, sut)
    }

    // протестируем что после перхода на newContactVC будет доступен nameTextField
    func testOpenNewContactViewController() {
        let newContactVC = presentingNewContactViewController()
        XCTAssertNotNil(newContactVC)
    }

    // проверяем в newContactVC: contactManager на Nil и тип
    func testSharesSameContactManagerWithNewContactVC() {
        let newContactVC = presentingNewContactViewController()
        XCTAssertNotNil(sut.dataSource.personsManager)
        XCTAssertTrue(
            // проверка что они оба ссылаются на 1 объект
            newContactVC?.personsManager === sut.dataSource.personsManager
        )
    }

    // проверка на то что после добавления нов конт и перехода - происходит Reload
    func testWhenViewAppearedTableViewReloaded() {
        let mockTableView = MockTableView()
        sut.tableView = mockTableView

        // имитируем переход
        sut.beginAppearanceTransition(true, animated: true)
        sut.endAppearanceTransition()

        XCTAssertTrue((sut.tableView as! MockTableView).isReloaded)
    }

    // проверим открытие детального экрана с помощью нотификации
    func testTappingCellSendsNotification() {
        let imageData = #imageLiteral(resourceName: "avatar").pngData()
        let person = Person(name: "name", phone: "phone", imageData: imageData)
        // добавляем person
        sut.dataSource.personsManager?.add(person: person)

        // имитируем передачу person при нажатии ячейчи в нотификации

        // expectation forNotification - ожидания для уведомления
        // ждем уведомление с имменем "DidSelectRow notification"
        expectation(forNotification: NSNotification.Name(rawValue: "DidSelectRow notification"), object: nil) { notification -> Bool in
            // достаем из notification - Person
            guard let personFromNotification = notification.userInfo?["person"] as? Person else { return false }
            // сравниваем созданный нами person с person из нотификации
            return person == personFromNotification
        }

        let tableView = sut.tableView
        // имитируем нажатие ячейки
        tableView?.delegate?.tableView!(tableView!, didSelectRowAt: IndexPath(row: 0, section: 0))
        // завершаем ожидание через 1 секунду
        waitForExpectations(timeout: 1)
    }

    // проверяем можем ли мы открыть для этой ячейки DetailVC
    func testSelectedCellHasShownDetailViewController() {
        let mockNavigationController = MockNavigationController(rootViewController: sut)
        UIApplication.shared.windows.filter(\.isKeyWindow).first?.rootViewController = mockNavigationController

        sut.loadViewIfNeeded()

        let imageData = #imageLiteral(resourceName: "avatar").pngData()
        let personOne = Person(name: "name1", phone: "phone1", imageData: imageData)
        let personTwo = Person(name: "name2", phone: "phone2", imageData: imageData)

        sut.dataSource.personsManager?.add(person: personOne)
        sut.dataSource.personsManager?.add(person: personTwo)

        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "DidSelectRow notification"), object: self, userInfo: ["person": personTwo])

        guard let detailVC = mockNavigationController.pushedViewController as? DetailViewController else {
            XCTFail()
            return
        }

        detailVC.loadViewIfNeeded()

        // проверяем nameLabel и сам person
        XCTAssertNotNil(detailVC.nameLabel)
        XCTAssertTrue(detailVC.person == personTwo)
    }

    func presentingNewContactViewController() -> NewContactViewController? {
        // определяем rootViewController на наш sut
        UIApplication.shared.windows.filter(\.isKeyWindow).first?.rootViewController = sut

        // создаем объект кнопки и определяем action
        guard let addNewContactButton = sut.navigationItem.rightBarButtonItem,
              let action = addNewContactButton.action else { return nil }

        // запускаем performSelector
        sut.performSelector(onMainThread: action,
                            with: addNewContactButton,
                            waitUntilDone: true)

        // достаем presentedViewController
        let newContactVC = sut.presentedViewController as! NewContactViewController
        return newContactVC
    }
}

// MARK: - Extension (MockTableView + MockNavigationController)

extension ContactListViewControllerTests {
    class MockTableView: UITableView {
        var isReloaded = false

        override func reloadData() {
            isReloaded = true
        }
    }

    class MockNavigationController: UINavigationController {
        var pushedViewController: UIViewController?

        override func pushViewController(_ viewController: UIViewController, animated: Bool) {
            pushedViewController = viewController
            super.pushViewController(viewController, animated: animated)
        }
    }
}
