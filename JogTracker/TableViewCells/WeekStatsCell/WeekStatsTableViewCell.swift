//
//  WeekStatsTableViewCell.swift
//  JogTracker
//
//  Created by Max Sashcheka on 11/18/21.
//

import UIKit

class WeekStatsTableViewCell: UITableViewCell {

    static let reuseIdentifier = "WeekStatsTableViewCell"
    static func nib() -> UINib {
        return UINib(nibName: "WeekStatsTableViewCell", bundle: nil)
    }
    
    @IBOutlet weak var weekNameLabel: UILabel!
    @IBOutlet weak var averageSpeedLabel: UILabel!
    @IBOutlet weak var averageTimeLabel: UILabel!
    @IBOutlet weak var totalDistanceLabel: UILabel!
    @IBOutlet weak var numberOfJogsLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    func setup(withModel model: WeekStatsModel) {
        weekNameLabel.attributedText = "Week \(model.weekNumber): \(model.startDate) - \(model.endDate)".attributedText(mediumString: "Week \(model.weekNumber):", fontSize: 20)
        averageSpeedLabel.attributedText = "Average speed: \(model.averageSpeed) m/s".attributedText(mediumString: "Average speed:", fontSize: 16)
        
        totalDistanceLabel.attributedText = "Total distance: \(model.totalDistance) km".attributedText(mediumString: "Total distance:", fontSize: 16)
        numberOfJogsLabel.attributedText = "Number of jogs: \(model.numberOfJogs) ".attributedText(mediumString: "Number of jogs:", fontSize: 16)
        
        let hours = model.averageTime / 60
        let leftMinutes = model.averageTime % 60
    
        if hours == 0 {
            averageTimeLabel.attributedText = "Average time: \(model.averageTime) min".attributedText(mediumString: "Average time:", fontSize: 16)
        } else if hours == 1 {
            averageTimeLabel.attributedText = "Average time: \(hours) hour \(leftMinutes) min".attributedText(mediumString: "Average time:", fontSize: 16)
        } else {
            averageTimeLabel.attributedText = "Average time: \(hours) hours \(leftMinutes) min".attributedText(mediumString: "Average time:", fontSize: 16)
        }
    }

}
