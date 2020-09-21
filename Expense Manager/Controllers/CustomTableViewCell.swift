//
//  CustomTableViewCell.swift
//  Expense Manager
//
//  Created by Rukhsar on 22/09/2020.
//  Copyright © 2020 Rukhsar. All rights reserved.
//

import UIKit

class CustomTableViewCell: UITableViewCell {
    @IBOutlet weak var calenderImage: UIImageView!
    @IBOutlet weak var dayLabel: UILabel!
    
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var currencyLabel: UILabel!
    @IBOutlet weak var incomeExpenceLabel: UILabel!
    @IBOutlet weak var arrowRight: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        arrowImageTint()
        calenderImageTint()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func arrowImageTint() {
        let Image =   arrowRight.image?.withRenderingMode(.alwaysTemplate)
        arrowRight.image = Image
        arrowRight.tintColor = UIColor(named: "AllLabelColor")
        }
    func calenderImageTint () {
        let Image =   calenderImage.image?.withRenderingMode(.alwaysTemplate)
        calenderImage.image = Image
        calenderImage.tintColor = UIColor(named: "AllLabelColor")
    }

}
