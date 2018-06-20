//
//  SelectMealPlanTableViewController.swift
//  MealPlan
//
//  Created by Shumei Kawagoe on 2018/06/11.
//  Copyright © 2018 Shumei Kawagoe. All rights reserved.
//

import UIKit

protocol SelectMealPlanTableViewControllerDelegate {
    func didSelect(mealPlan: MealPlan)
}

class SelectMealPlanTableViewController: UITableViewController {

    struct PropertyKeys {
        static let mealPlanCell = "MealPlanCell"
        
    }
    var delegate: SelectMealPlanTableViewControllerDelegate?
    var mealPlan: MealPlan?
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return MealPlan.choices.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PropertyKeys.mealPlanCell, for: indexPath)

        
        // Configure the cell...
        let mealPlan = MealPlan.choices[indexPath.row]
        
        if mealPlan == self.mealPlan {
            cell.accessoryType = .checkmark
        } else {
            cell.accessoryType = .none
        }
        
        cell.textLabel?.text = mealPlan.name
        cell.detailTextLabel?.text = "$\(mealPlan.price)"

       
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        mealPlan = MealPlan.choices[indexPath.row]
        delegate?.didSelect(mealPlan: mealPlan!)
        tableView.reloadData()
    }

    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
