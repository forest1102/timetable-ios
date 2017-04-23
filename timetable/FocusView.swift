//
//  focusView.swift
//  timetable
//
//  Created by 森田一世 on 2017/04/23.
//  Copyright © 2017年 森田一世. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift
import os.log
class FocusView: UILabel {
    var padding: UIEdgeInsets=UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    let disposeBag=DisposeBag()
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    // MARK: Setup methods
    private func setup(){
//        roundTop()
        self.textAlignment = .center
        TabBarSetting.sharedInstance.selectedTextColorVariable.asObservable()
            .subscribe(onNext:{
                [unowned self] in
                self.textColor=$0
            }).addDisposableTo(disposeBag)
        
        TabBarSetting.sharedInstance.selectedBackgroundVariable.asObservable()
            .subscribe(onNext:{
                [unowned self] in
                self.backgroundColor=$0
            }).addDisposableTo(disposeBag)
    }
    
    private func roundTop(){
        let maskPath = UIBezierPath(roundedRect: self.frame, byRoundingCorners: [.topLeft, .topRight], cornerRadii: CGSize(width: 5, height: 5))
        let maskLayer = CAShapeLayer()
        maskLayer.path = maskPath.cgPath
        self.layer.mask=maskLayer
    }
    
    // MARK: override properties
    override var frame: CGRect{
        didSet{
            roundTop()
        }
    }
    override func drawText(in rect: CGRect) {
        let newRect = UIEdgeInsetsInsetRect(rect, padding)
        super.drawText(in: newRect)
    }
    
    override var intrinsicContentSize: CGSize {
        var contentSize = super.intrinsicContentSize
        contentSize.height += padding.top + padding.bottom
        contentSize.width += padding.left + padding.right
        return contentSize
    }
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
