//
//  AddMealPlanTableViewController.swift
//  MealPlan
//
//  Created by Shumei Kawagoe on 2018/06/11.
//  Copyright © 2018 Shumei Kawagoe. All rights reserved.
//

import UIKit

class AddMealPlanTableViewController: UITableViewController, SelectMealPlanTableViewControllerDelegate {
    
    func didSelect(mealPlan: MealPlan) {
        self.mealPlan = mealPlan
        updateMealPlanView()
    }
    

    var mealPlan: MealPlan?
    
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var startDayLabel: UILabel!
    @IBOutlet weak var startDayPicker: UIDatePicker!
    @IBOutlet weak var endDayLabel: UILabel!
    @IBOutlet weak var endDayPicker: UIDatePicker!
    
    @IBOutlet weak var peopleCounterLabel: UILabel!
    @IBOutlet weak var peopleStepper: UIStepper!
    
    @IBOutlet weak var membershipSwitch: UISwitch!
    
    @IBOutlet weak var mealPlanLabel: UILabel!
    
    
    @IBAction func datePickerValueChanged(_ sender: UIDatePicker) {
        updateDateView()
    }
    
    @IBAction func peopleStepperValueChanged(_ sender: UIStepper) {
        updatePeopleView()
    }
    
    
   /* @IBAction func doneButtonTapped(_ sender: UIBarButtonItem) {
        
        let firstName = firstNameTextField.text ?? ""
        let lastName = lastNameTextField.text ?? ""
        let email = emailTextField.text ?? ""
        
        let startDay = startDayLabel.text ?? ""
        let endDay = endDayLabel.text ?? ""
        
        let peopleCount = peopleCounterLabel.text ?? ""
        
        let hasMembership = membershipSwitch.isOn
        
        let mealPlan = mealPlanLabel.text ?? ""
        
        print("First name: \(firstName)")
        print("Last name: \(lastName)")
        print("Email: \(email)")
        print("Start: \(startDay)")
        print("End: \(endDay)")
        print("People: \(peopleCount)")
        print("Membership: \(hasMembership)")
        print("Meal plan: \(mealPlan)")
    }*/
    
    var customerMeal: CustomerMeal? {
        guard let mealPlan = mealPlan else { return nil }
        
        let firstName = firstNameTextField.text ?? ""
        let lastName = lastNameTextField.text ?? ""
        let email = emailTextField.text ?? ""
        
        let startDate = startDayPicker.date
        let endDate = endDayPicker.date
        
        let peopleCounter = peopleStepper.value

        let membership = membershipSwitch.isOn
        
        return CustomerMeal(firstName: firstName, lastName: lastName, email: email, startDate: startDate, endDate: endDate, numberOfPeople: Int(peopleCounter), mealPlan: mealPlan, membership: membership)
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let midnightToday = Calendar.current.startOfDay(for: Date())
        startDayPicker.date = midnightToday
        startDayPicker.minimumDate = midnightToday
        
        updateDateView()
        updatePeopleView()
        updateMealPlanView()

    }
    
    func updateDateView() {
        endDayPicker.minimumDate = startDayPicker.date.addingTimeInterval(86400)
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        
        startDayLabel.text = dateFormatter.string(from: startDayPicker.date)
        endDayLabel.text = dateFormatter.string(from: endDayPicker.date)
        
    }
    
    func updatePeopleView() {
        peopleCounterLabel.text = "\(Int(peopleStepper.value))"
    }

    func updateMealPlanView() {
        
        if let mealPlan = mealPlan {
            mealPlanLabel.text = mealPlan.name
        } else {
            mealPlanLabel.text = "Not set"
        }
    }
    
    let startDayCellIndexPath = IndexPath(row: 1, section: 1)
    let endDayCellIndexPath = IndexPath(row: 3, section: 1)
    
    var isStartDayPickerShown: Bool = false {
        didSet {
            startDayPicker.isHidden = !isStartDayPickerShown
        }
    }
    
    var isEndDayPickerShown: Bool = false {
        didSet {
            endDayPicker.isHidden = !isEndDayPickerShown
        }
    }
    
    //Table view delegate: Height
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch (indexPath.section, indexPath.row) {
        case (startDayCellIndexPath.section, startDayCellIndexPath.row):
            if isStartDayPickerShown {
                return 216.0
            } else {
                return 0.0
            }
        case (endDayCellIndexPath.section, endDayCellIndexPath.row):
            if isEndDayPickerShown {
                return 216.0
            } else {
                return 0.0
            }
        default:
            return 44.0
        }
    }
    
    //Table view delegate: Select
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        switch(indexPath.section, indexPath.row) {
        case (startDayCellIndexPath.section, startDayCellIndexPath.row - 1):
            if isStartDayPickerShown {
                isStartDayPickerShown = false
            } else if isEndDayPickerShown {
                isEndDayPickerShown = false
                isStartDayPickerShown = true
            } else {
                isStartDayPickerShown = true
            }
            tableView.beginUpdates()
            tableView.endUpdates()
            
        case (endDayCellIndexPath.section, endDayCellIndexPath.row - 1):
            if isEndDayPickerShown {
                isEndDayPickerShown = false
            } else if isStartDayPickerShown {
                isStartDayPickerShown = false
                isEndDayPickerShown = true
            } else {
                isEndDayPickerShown = true
            }
            tableView.beginUpdates()
            tableView.endUpdates()
            
        default:
            break
        }
        
    }
    
    @IBAction func cancelButtonTapped(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "SelectMealPlan" {
            let destinationViewController = segue.destination as? SelectMealPlanTableViewController
            destinationViewController?.delegate = self
            destinationViewController?.mealPlan = mealPlan
        }
    }
    

}
