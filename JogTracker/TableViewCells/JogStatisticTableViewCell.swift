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
        
    }

    static func nib() -> UINib {
        return UINib(nibName: "JogStatisticTableViewCell", bundle: nil)
    }
    
    func setup(withJog jog: Jog) {
        dateLabel.text = String(jog.date)
        distanceLabel.text = "Distance \(jog.distance)"
        timeLabel.text = "Time: \(jog.time) min"
        
        let speed = jog.distance / Float(jog.time) * 1000
        let roundedSpeed = round(speed * 10) / 10.0
        
        speedLabel.text = "Speed: \(roundedSpeed) m/s"
        
    }
    
}


