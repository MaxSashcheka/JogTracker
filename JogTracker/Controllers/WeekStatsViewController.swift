//
//  WeekStatsViewController.swift
//  JogTracker
//
//  Created by Max Sashcheka on 11/18/21.
//

import UIKit

class WeekStatsViewController: UIViewController {

    lazy var weekStatsTableView: UITableView = {
        let tableView = UITableView(frame: view.bounds, style: .insetGrouped)
        tableView.register(WeekStatsTableViewCell.nib(), forCellReuseIdentifier: WeekStatsTableViewCell.reuseIdentifier)
        tableView.separatorInset = .zero
        tableView.delegate = self
        tableView.dataSource = self
        
        return tableView
    }()
    
    var jogs: [Jog]!
    var weekStatsModels = [WeekStatsModel]()
    
}

// MARK: - ViewController overrides

extension WeekStatsViewController {
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: self, action: nil)
        navigationController?.navigationBar.backIndicatorImage = UIImage(systemName: "chevron.backward")
        navigationController?.navigationBar.backIndicatorTransitionMaskImage = UIImage(systemName: "chevron.backward")!
        navigationController?.navigationBar.tintColor = .white
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(weekStatsTableView)
        
        setupNavigationBar()
        
        DispatchQueue.main.async {
            self.weekStatsModels = self.calculateWeekStatsModels()
            self.weekStatsTableView.reloadData()
        }
    }
}

// MARK: - Private interface

private extension WeekStatsViewController {
    
    @objc func menuHandler() {
        popBack(3)
    }
    
    func setupNavigationBar() {
        
        let titleLabel = UILabel()
        let attributes: [NSAttributedString.Key : AnyObject] = [NSAttributedString.Key.font: UIFont.sfText(25, .bold),
                                                                NSAttributedString.Key.foregroundColor: UIColor.white]
        titleLabel.attributedText = NSAttributedString(string: "Statistic per weeks", attributes: attributes)
        titleLabel.sizeToFit()
        navigationItem.titleView = titleLabel
        
        let menuButton = UIButton(type: .system)
        menuButton.setImage(UIImage(named: "menu"), for: .normal)
        menuButton.tintColor = .white
        menuButton.addTarget(self, action: #selector(menuHandler), for: .touchUpInside)
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(customView: menuButton)
    }
    
    func calculateWeekStatsModels() -> [WeekStatsModel] {
        let secondsPerWeek = TimeInterval(60 * 60 * 24 * 7)
        
        var maxTimeInterval: TimeInterval = 0
        for jog in jogs {
            if jog.date > maxTimeInterval {
                maxTimeInterval = jog.date
            }
        }
        
        var weekCounter = 1
        var weekStartDateTimeInterval: TimeInterval = 0
        var weekStatsArray = [WeekStatsModel]()
        while (weekStartDateTimeInterval < maxTimeInterval) {
            let weekEndDateTimerInterval = weekStartDateTimeInterval + secondsPerWeek
            
            var jogsMatchedCurrentWeek = [Jog]()
            for jog in jogs {
                if jog.date >= weekStartDateTimeInterval, jog.date <= weekEndDateTimerInterval {
                    jogsMatchedCurrentWeek.append(jog)
                }
            }
            
            if !jogsMatchedCurrentWeek.isEmpty {
                
                var totalDistance: Float = 0
                var totalTime = 0
                
                for jog in jogsMatchedCurrentWeek {
                    totalDistance += jog.distance
                    totalTime += jog.time
                }
                
                let jogTotalDistanceInMeteres = totalDistance * 1000
                let jogTotalTimeInSeconds = Float(totalTime) * 60
                let averageSpeed = jogTotalDistanceInMeteres / jogTotalTimeInSeconds
                let roundedAverageSpeed = round(averageSpeed * 10) / 10.0
                
                let averageTime = Float(totalTime) / Float(jogsMatchedCurrentWeek.count)
                let roundedAverageTime = round(averageTime * 10) / 10.0

                let weekStartDate = Date(timeIntervalSince1970: weekStartDateTimeInterval)
                let weekEndDate = Date(timeIntervalSince1970: weekEndDateTimerInterval)

                let formatter = DateFormatter()
                formatter.dateFormat = "dd.MM.YYYY"
                let weekStartDateString = formatter.string(from: weekStartDate)
                let weekEndDateString = formatter.string(from: weekEndDate)

                
                let currentWeekStats = WeekStatsModel(weekNumber: weekCounter, startDate: weekStartDateString, endDate: weekEndDateString, averageSpeed: String(roundedAverageSpeed), averageTime: Int(roundedAverageTime), totalDistance: String(totalDistance), numberOfJogs: jogsMatchedCurrentWeek.count)
                weekStatsArray.append(currentWeekStats)
                weekCounter += 1
                
            }
            
            weekStartDateTimeInterval = weekEndDateTimerInterval
        }
        
        return weekStatsArray
    }
}

extension WeekStatsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return weekStatsModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: WeekStatsTableViewCell.reuseIdentifier, for: indexPath) as! WeekStatsTableViewCell
        
        let weekStatsModel = weekStatsModels[indexPath.row]
        cell.setup(withModel: weekStatsModel)
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}
