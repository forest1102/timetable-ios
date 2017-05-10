//
//  DetailTimetableViewController.swift
//  timetable
//
//  Created by 森田一世 on 2017/04/30.
//  Copyright © 2017年 森田一世. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import Eureka
import  os.log
class DetailTimetableViewController: FormViewController {
    var timetable:Timetable?
    
    private enum SubjectInfoType:String{
        case Subject,Teacher,Place
    }
    
    @IBOutlet weak var cancelButton: UIBarButtonItem!
    
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    private let disposeBag=DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func setup(){
//        print(timetable?.place ?? "")
        form +++ Section("教科情報")
            <<< TextRow(){
                $0.title="教科名"
                $0.tag=SubjectInfoType.Subject.rawValue
                $0.placeholder="subject's name"
                $0.value=timetable?.subject
        }
            <<< TextRow(){
                $0.title="教師名"
                $0.tag=SubjectInfoType.Teacher.rawValue
                $0.placeholder = "teacher's name"
                $0.value=timetable?.teacher
        }
            <<< TextRow(){
                $0.title="場所"
                $0.tag=SubjectInfoType.Place.rawValue
                $0.placeholder="place's name"
                $0.value=timetable?.place
        }
        
        cancelButton.rx.tap
            .subscribe(onNext:{
                [weak self] _ in
                if (self?.presentingViewController is UINavigationController){
                    self?.dismiss(animated: true, completion: nil)
                }
                else if let owningNavigationController = self?.navigationController{
                    owningNavigationController.popViewController(animated: true)
                }
                else {
                    fatalError("The MealViewController is not inside a navigation controller.")
                }
            })
            .addDisposableTo(disposeBag)
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        guard let button = sender as? UIBarButtonItem, button === saveButton else {
            os_log("The save button was not pressed, cancelling", log: OSLog.default, type: .debug)
            return
        }
        form.values().forEach{
            (key,value) in
            switch key {
                case SubjectInfoType.Teacher.rawValue:
                    if let teacher=value as? String{
                        timetable?.teacher=teacher
                }
                case SubjectInfoType.Subject.rawValue:
                    if let subject=value as? String{
                        timetable?.subject=subject
                }
                case SubjectInfoType.Place.rawValue:
                    if let place = value as? String{
                        timetable?.place=place
                }
            default:
                print("unknown form row \(key)")
            }
        }
        print(timetable ?? Timetable())
    }
 

}
