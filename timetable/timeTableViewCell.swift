//
//  timeTableViewCell.swift
//  timetable
//
//  Created by 森田一世 on 2017/04/05.
//  Copyright © 2017年 森田一世. All rights reserved.
//

import UIKit

class timeTableViewCell: UITableViewCell {
 
    @IBOutlet weak var subjectLabel: UILabel!
    @IBOutlet weak var teacherLabel: UILabel!
    @IBOutlet weak var placeLabel: UILabel!
    static let identifier="TimetableViewCell"
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Initialization code
        self.selectionStyle = .none
        subjectLabel.text=""
        teacherLabel.text=""
        placeLabel.text=""
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
