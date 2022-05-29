//
//  ViewController.swift
//  Birthday Notes
//
//  Created by  Юлия Григорьева on 29.04.2022.
//

import UIKit

protocol AddBirthdayViewControllerDelegate {
    func addBirthdayViewController(_ addBirthdayViewController: AddBirthdayViewController, didAddBirthday birthday: Birthday)
}

class AddBirthdayViewController: UIViewController {

    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var birthdatePicker: UIDatePicker!
    
    var delegate: AddBirthdayViewControllerDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        birthdatePicker.maximumDate=Date()
    }

    @IBAction func saveTapped(_ sender: UIBarButtonItem) {

        let firstName = firstNameTextField.text ?? ""
        let lastName = lastNameTextField.text ?? ""
        let birthdate = birthdatePicker.date
        let newBirthday = Birthday(firstName: firstName, lastName: lastName, birthdate: birthdate)
        delegate?.addBirthdayViewController(self, didAddBirthday: newBirthday)
        dismiss(animated: true, completion: nil)
    }

    @IBAction func cancelTapped(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }


}

