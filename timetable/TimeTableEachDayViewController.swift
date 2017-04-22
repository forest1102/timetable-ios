//
//  TimeTableEachDayViewController.swift
//  timetable
//
//  Created by 森田一世 on 2017/04/10.
//  Copyright © 2017年 森田一世. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift
import os.log
class TimeTableEachDayViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    // MARK: Properties
    @IBOutlet weak var dayTabBar: DayTabBar!
    @IBOutlet weak var EachDayTimeTable: UITableView!
    var timetables=[Timetable]()
    private let disposeBag=DisposeBag()
    
    
    // MARK: Override methods
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        loadSampleTimetables()
        EachDayTimeTable.register(UITableViewCell.self, forCellReuseIdentifier: "timeTableViewCell")
    }
    
    override func viewDidLayoutSubviews() {
        dayTabBar.setUp()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
//        mainStore.unsubscribe(dayTabBar.self)
    }
    
    
    // MARK: - Table view data source
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return timetables.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
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
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    // MARK: Private Methods
    private func setup(){

    }
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
