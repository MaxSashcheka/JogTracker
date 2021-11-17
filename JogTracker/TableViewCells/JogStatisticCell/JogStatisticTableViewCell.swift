//
//  JogStatisticTableViewCell.swift
//  JogTracker
//
//  Created by Max Sashcheka on 11/16/21.
//

import UIKit

class JogStatisticTableViewCell: UITableViewCell {
    
    static let reuseIdentifier = "JogStatisticTableViewCell"

    @IBOutlet weak var dateLabel: UILabel!
    
    @IBOutlet weak var speedLabel: UILabel!
    @IBOutlet weak var distanceLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        dateLabel.font = UIFont.sfText(16, .regular)
        dateLabel.textColor = .warmGrey
        
    }

    static func nib() -> UINib {
        return UINib(nibName: "JogStatisticTableViewCell", bundle: nil)
    }
    
    func setup(withJog jog: Jog) {
        
        let jogDate = Date(timeIntervalSince1970: jog.date)
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.YYYY"
        let jogDateString = formatter.string(from: jogDate)
        dateLabel.text = jogDateString
    
        
        let jogDistanceInMeteres = jog.distance * 1000
        let jogTimeInSeconds = Float(jog.time) * 60
        let speed = jogDistanceInMeteres / jogTimeInSeconds
        let roundedSpeed = round(speed * 10) / 10.0
        
        distanceLabel.attributedText = "Distance: \(jog.distance) km".attributedText(mediumString: "Distance:")
        speedLabel.attributedText = "Speed: \(roundedSpeed) m/s".attributedText(mediumString: "Speed")

        
        let hours = jog.time / 60
        let leftMinutes = jog.time % 60
    
        if hours == 0 {
            timeLabel.attributedText = "Time: \(jog.time) min".attributedText(mediumString: "Time:")
        } else if hours == 1{
            timeLabel.attributedText = "Time: \(hours) hour \(leftMinutes) min".attributedText(mediumString: "Time:")
        } else {
            timeLabel.attributedText = "Time: \(hours) hours \(leftMinutes) min".attributedText(mediumString: "Time:")
        }
        
    }
    
    
    
}



