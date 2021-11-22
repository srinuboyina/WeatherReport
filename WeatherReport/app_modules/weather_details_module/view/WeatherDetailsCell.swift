//
//  WeatherDetailsCell.swift
//  WeatherReport
//
//  Created by Srinivas on 22/11/21.
//  Copyright © 2021 srini. All rights reserved.
//

import UIKit

class WeatherDetailsCell: UICollectionViewCell {
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var valueLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        self.mainView.layer.cornerRadius = 10
        self.mainView.layer.shadowColor = UIColor.red.cgColor
        self.mainView.layer.shadowOpacity = 1
        self.mainView.layer.shadowOffset = CGSize.zero
        self.mainView.layer.shadowRadius = 5
    }
    
    func setData(name: String, value: String) {
        nameLabel.text = name
        valueLabel.text = value
    }
}
