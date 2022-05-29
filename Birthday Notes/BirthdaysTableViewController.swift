//
//  BirthdaysTableViewController.swift
//  Birthday Notes
//
//  Created by  Юлия Григорьева on 30.04.2022.
//

import UIKit

class BirthdaysTableViewController: UITableViewController, AddBirthdayViewControllerDelegate {

    var birthdays = [Birthday]()

    let dateFormatter = DateFormatter()

    @IBAction func editTapped(_ sender: UIBarButtonItem) {
        tableView.setEditing(!tableView.isEditing, animated: true)
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            self.tableView.reloadData()
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()


        tableView.backgroundView = UIImageView(image: UIImage(named: "background"))
        tableView.backgroundView?.contentMode = .scaleAspectFill
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none

    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return birthdays.count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "birthdayCellIdentifier", for: indexPath)
        let birthday = birthdays[indexPath.row]
        cell.textLabel?.text = birthday.lastName + " " + birthday.firstName
        cell.detailTextLabel?.text = dateFormatter.string(from: birthday.birthdate)

        return cell
    }

    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
            return .delete
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        tableView.beginUpdates()
        self.birthdays.remove(at: indexPath.row)
        tableView.deleteRows(at: [indexPath], with: .automatic)
        tableView.endUpdates()
    }

    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {

        return true
    }

    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

        let elementToMove = birthdays[fromIndexPath.row]
        birthdays.remove(at: fromIndexPath.row)
        birthdays.insert(elementToMove, at: to.row)

        tableView.reloadData()
    }


    // MARK: - Navigation


    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let navigationController = segue.destination as! UINavigationController
        let addBirthdayViewController = navigationController.topViewController as! AddBirthdayViewController
        addBirthdayViewController.delegate = self
    }


    //MARK: - AddBirthdayViewControllerDelegate

    func addBirthdayViewController(_ addBirthdayViewController: AddBirthdayViewController, didAddBirthday birthday: Birthday) {
        birthdays.append(birthday)
        tableView.reloadData()
    }

}
