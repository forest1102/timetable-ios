//
//  timetablesTableViewController.swift
//  timetable
//
//  Created by 森田一世 on 2017/04/06.
//  Copyright © 2017年 森田一世. All rights reserved.
//

import UIKit

class timetablesTableViewController: UITableViewController {
    // MARK: Properties
    var timetables=[Timetable]()
    override func viewDidLoad() {
        super.viewDidLoad()
        loadSampleTimetables()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return timetables.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "TimetableViewCell", for: indexPath) as? timeTableViewCell else{
              fatalError("The dequeued cell is not an instance of timeTableViewCell.")
        }
        // Configure the cell...
        let t=timetables[indexPath.row]
        cell.subjectLabel.text=t.subject
        cell.teacherLabel.text=t.teacher
        cell.placeLabel.text=t.place
        return cell
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
    
    // MARK: Private Methods
    private func loadSampleTimetables(){
        guard let timetable1=Timetable(subject: "Math",teacher:"John",place:"here") else {
            fatalError("Unable to instantiate timetable1")
        }
        guard let timetable2=Timetable(subject: "Physics",teacher:"Moris",place:"there") else {
            fatalError("Unable to instantiate timetable2")
        }
        timetables+=[timetable1,timetable2]
    }

}
