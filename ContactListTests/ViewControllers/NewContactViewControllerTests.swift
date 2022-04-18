//
//  NewContactViewControllerTests.swift
//  ContactListTests
//
//  Created by Martynov Evgeny on 15.04.22.
//

@testable import ContactList
import XCTest

// MARK: - NewContactViewControllerTests

class NewContactViewControllerTests: XCTestCase {
    var newContactVC: NewContactViewController!

    override func setUp() {
        super.setUp()
        // инициализация
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        newContactVC = storyboard.instantiateViewController(
            withIdentifier: "NewContactViewController") as? NewContactViewController
        // viewDidLoad
        newContactVC.loadViewIfNeeded()
    }

    override func tearDown() {
        newContactVC = nil
        super.tearDown()
    }

    // наличие nameTextField на storyboard
    func testHasNameTextField() {
        XCTAssertTrue(newContactVC.nameTextField.isDescendant(of: newContactVC.view))
    }

    // наличие phoneTextField на storyboard
    func testHasPhoneTextField() {
        XCTAssertTrue(newContactVC.phoneTextField.isDescendant(of: newContactVC.view))
    }

    // наличие surnameTextField на storyboard
    func testHasSurnameTextField() {
        XCTAssertTrue(newContactVC.surnameTextField.isDescendant(of: newContactVC.view))
    }

    // наличие saveButton на storyboard
    func testHasSaveButton() {
        XCTAssertTrue(newContactVC.saveButton.isDescendant(of: newContactVC.view))
    }

    // наличие cancelButton на storyboard
    func testHasCancelButton() {
        XCTAssertTrue(newContactVC.cancelButton.isDescendant(of: newContactVC.view))
    }

    // возможность добавить новый контакт
    func testSaveNewContact() {
        let imageData = #imageLiteral(resourceName: "avatar").pngData()
        let person = Person(name: "name",
                            surname: "surname",
                            phone: "phone",
                            imageData: imageData)
        // заполняем
        newContactVC.nameTextField.text = person.name
        newContactVC.surnameTextField.text = person.surname
        newContactVC.phoneTextField.text = person.phone
        // инициализируем
        newContactVC.personsManager = PersonsManager()
        // вызываем saveButtonPressed
        newContactVC.saveButtonPressed()
        // после сохранения извлекаем этот объект
        let contact = newContactVC.personsManager.person(at: 0)

        // сравним объекты
        XCTAssertEqual(contact, person)
    }

    // MARK: - UI TESTS

    // проверим существование кнопки SaveButton и то что она отрабатывает
    func testSaveButtonHasSaveMethod() {
        // saveButton: UIButton?
        let saveButton = newContactVC.saveButton
        // actions: [String]
        guard let actions = saveButton?.actions(
            forTarget: newContactVC,
            forControlEvent: .touchUpInside) else { XCTFail(); return } // XCTFail если нет actions
        // проверяем наличие saveButtonPressed
        XCTAssertTrue(actions.contains("saveButtonPressed"))
    }

    // проверим существование кнопки CancelButton и то что она отрабатывает
    func testCancelButtonHasCancelMethod() {
        // saveButton: UIButton?
        let cancelButton = newContactVC.cancelButton
        // actions: [String]
        guard let actions = cancelButton?.actions(
            forTarget: newContactVC,
            forControlEvent: .touchUpInside) else { XCTFail(); return }

        XCTAssertTrue(actions.contains("cancelButtonPressed"))
    }
}

// MARK: - Extension

extension NewContactViewControllerTests {
    // проверка метода Dismiss (для этого создадим MockNewContactViewController)
    func testSaveDismissesNewContactViewController() {
        // инициализируем
        let mockNewContactVC = MockNewContactViewController()
        // заполняем
        mockNewContactVC.nameTextField = UITextField()
        mockNewContactVC.nameTextField.text = "name"
        mockNewContactVC.surnameTextField = UITextField()
        mockNewContactVC.surnameTextField.text = "surname"
        mockNewContactVC.phoneTextField = UITextField()
        mockNewContactVC.phoneTextField.text = "phone"
        // инициализируем ContactManager
        mockNewContactVC.personsManager = PersonsManager()
        // сохраняем
        mockNewContactVC.saveButtonPressed()
        // проверяем переход
        XCTAssertTrue(mockNewContactVC.isDismissed)
    }

    // проверка метода Dismiss (для этого создадим MockNewContactViewController)
    func testCancelDismissesNewContactViewController() {
        // инициализируем
        let mockNewContactVC = MockNewContactViewController()
        // cancelButtonPressed
        mockNewContactVC.cancelButtonPressed()
        // проверяем переход
        XCTAssertTrue(mockNewContactVC.isDismissed)
    }

    class MockNewContactViewController: NewContactViewController {
        var isDismissed = false

        override func dismiss(animated flag: Bool, completion: (() -> Void)? = nil) {
            isDismissed = true
        }
    }
}

