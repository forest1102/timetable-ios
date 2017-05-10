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
class TimeTableEachDayViewController: UIViewController {
    // MARK: Properties
    @IBOutlet weak var dayTabBar: DayTabBar!
    @IBOutlet weak var EachDayTimeTable: UITableView!
    var timetables=[Timetable]()
//    var selectedTimetable:Timetable? = nil
    private let disposeBag=DisposeBag()
    
    
    // MARK: Override methods
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        loadSampleTimetables()
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
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        switch (segue.identifier ?? "") {
        case "ShowDetail":
//            print(self.selectedTimetable ?? Timetable())
            
            guard let secondVC=(segue.destination as? DetailTimetableViewController) else{
                fatalError("Unexpected destination: \(segue.destination)")
            }
            guard let indexPath=sender as? IndexPath else {
                fatalError("Unexecpeted indexPath: \(String(describing: sender))")
            }
            let selectedTimetable=self.timetables[indexPath.row]
            secondVC.timetable=selectedTimetable
        default: break
            
        }
    }
    
    // MARK: Actions
    @IBAction func backToTop(segue: UIStoryboardSegue) {
        if let sourceViewController = segue.source as? DetailTimetableViewController,
            let timetable = sourceViewController.timetable {
            
            if let selectedIndexPath = EachDayTimeTable.indexPathForSelectedRow {
                // Update an existing meal.
                WeekOfDay.sharedInstance.curSelectedItem.asObservable()
                    .subscribe(onNext:{
                        TimetableData.sharedInstance.wholeTimetablesVariable.value[$0]?[selectedIndexPath.row]=timetable
                    }).dispose()
            }
        }
    }
 
    
    // MARK: Private Methods
    private func setup(){
        
        TimetableData.sharedInstance.curTimetableDay
            .bindTo(
                self.EachDayTimeTable.rx
                    .items(cellIdentifier: "TimetableViewCell", cellType: timeTableViewCell.self)){
                    (row, elem, cell)->Void in
                    cell.placeLabel.text=elem.place
                    cell.subjectLabel.text=elem.subject
                    cell.teacherLabel.text=elem.teacher
            }
            .addDisposableTo(disposeBag)
        TimetableData.sharedInstance.curTimetableDay
            .subscribe(onNext:{
                [weak self] in
                self?.timetables=$0
            })
            .addDisposableTo(disposeBag)
        self.EachDayTimeTable.rx.itemSelected.subscribe(onNext:{
            [weak self] index in
            self?.performSegue(withIdentifier: "ShowDetail", sender: index)
        })
        
    }
    
    private func loadSampleTimetables(){
        let timetable1:Timetable=Timetable(subject: "Math",teacher:"John",place:"here")
        let timetable2:Timetable=Timetable(subject: "Physics",teacher:"Moris",place:"there")
        TimetableData.sharedInstance.wholeTimetablesVariable.value[.Mon]?[0...1]=[timetable1,timetable2]
    }

}
