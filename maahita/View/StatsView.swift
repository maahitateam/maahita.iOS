//
//  StatsView.swift
//  maahita
//
//  Created by Jagan Kumar Mudila on 14/05/2020.
//  Copyright © 2020 Jagan Kumar Mudila. All rights reserved.
//

import UIKit

class StatsView: UIView {
    
    lazy var enrolledValue: UILabel = {
        let enrolled = UILabel()
        enrolled.translatesAutoresizingMaskIntoConstraints = false
        enrolled.font = UIFont(name: "Comfortaa-Bold", size: 18.0)
        enrolled.text = "0"
        enrolled.textAlignment = .center
        enrolled.textColor = .darkGray
        return enrolled
    }()
    
    lazy var attendedValue: UILabel = {
        let attended = UILabel()
        attended.translatesAutoresizingMaskIntoConstraints = false
        attended.font = UIFont(name: "Comfortaa-Bold", size: 18.0)
        attended.text = "0"
        attended.textAlignment = .center
        attended.textColor = .darkGray
        return attended
    }()
    
    lazy var answeredValue: UILabel = {
        let answered = UILabel()
        answered.translatesAutoresizingMaskIntoConstraints = false
        answered.font = UIFont(name: "Comfortaa-Bold", size: 18.0)
        answered.text = "0"
        answered.textAlignment = .center
        answered.textColor = .darkGray
        return answered
    }()
    
    lazy var sessionsEnrolled: UIView = {
        let enrolled = UIView()
        let enrolledLabel = UILabel()
        enrolledLabel.translatesAutoresizingMaskIntoConstraints = false
        enrolledLabel.font = UIFont(name: "Comfortaa-Regular", size: 12.0)
        enrolledLabel.text = "Sessions Enrolled"
        enrolledLabel.numberOfLines = 2
        enrolledLabel.lineBreakMode = .byWordWrapping
        enrolledLabel.textAlignment = .center
        enrolledLabel.textColor = .darkGray
        
        let enrolledStack = UIStackView(arrangedSubviews: [enrolledValue, enrolledLabel])
        enrolledStack.axis = .vertical
        enrolledStack.distribution = .fillEqually
        enrolledStack.translatesAutoresizingMaskIntoConstraints = false
        
        enrolled.addSubview(enrolledStack)
        
        let seperator = UIView()
        seperator.backgroundColor = .darkGray
        seperator.translatesAutoresizingMaskIntoConstraints = false
        enrolled.addSubview(seperator)
        
        NSLayoutConstraint.activate([
            enrolledStack.topAnchor.constraint(equalTo: enrolled.topAnchor),
            enrolledStack.leadingAnchor.constraint(equalTo: enrolled.leadingAnchor),
            enrolledStack.bottomAnchor.constraint(equalTo: enrolled.bottomAnchor),
            seperator.leadingAnchor.constraint(equalTo: enrolledStack.trailingAnchor),
            seperator.widthAnchor.constraint(equalToConstant: 1.0),
            seperator.heightAnchor.constraint(equalTo: enrolled.heightAnchor, multiplier: 0.75),
            seperator.centerYAnchor.constraint(equalTo: enrolled.centerYAnchor),
            seperator.trailingAnchor.constraint(equalTo: enrolled.trailingAnchor)
        ])
        
        enrolled.translatesAutoresizingMaskIntoConstraints = false
        return enrolled
    }()
    
    lazy var sessionsAttended: UIView = {
        let attended = UIView()
        let attendedLabel = UILabel()
        attendedLabel.translatesAutoresizingMaskIntoConstraints = false
        attendedLabel.font = UIFont(name: "Comfortaa-Regular", size: 12.0)
        attendedLabel.text = "Sessions Attended"
        attendedLabel.numberOfLines = 2
        attendedLabel.lineBreakMode = .byWordWrapping
        attendedLabel.textAlignment = .center
        attendedLabel.textColor = .darkGray
        
        let attendedStack = UIStackView(arrangedSubviews: [attendedValue, attendedLabel])
        attendedStack.axis = .vertical
        attendedStack.distribution = .fillEqually
        attendedStack.translatesAutoresizingMaskIntoConstraints = false
        
        attended.addSubview(attendedStack)
        
        let seperator = UIView()
        seperator.backgroundColor = .darkGray
        seperator.translatesAutoresizingMaskIntoConstraints = false
        attended.addSubview(seperator)
        
        NSLayoutConstraint.activate([
            attendedStack.topAnchor.constraint(equalTo: attended.topAnchor),
            attendedStack.leadingAnchor.constraint(equalTo: attended.leadingAnchor),
            attendedStack.bottomAnchor.constraint(equalTo: attended.bottomAnchor),
            seperator.leadingAnchor.constraint(equalTo: attendedStack.trailingAnchor),
            seperator.widthAnchor.constraint(equalToConstant: 1.0),
            seperator.heightAnchor.constraint(equalTo: attended.heightAnchor, multiplier: 0.75),
            seperator.centerYAnchor.constraint(equalTo: attended.centerYAnchor),
            seperator.trailingAnchor.constraint(equalTo: attended.trailingAnchor, constant: -3.0)
        ])
        
        attended.translatesAutoresizingMaskIntoConstraints = false
        return attended
    }()
    
    lazy var questionsAnswered: UIView = {
        let answered = UIView()
        
        let answeredLabel = UILabel()
        answeredLabel.translatesAutoresizingMaskIntoConstraints = false
        answeredLabel.font = UIFont(name: "Comfortaa-Regular", size: 12.0)
        answeredLabel.text = "Groups Subscribed"
        answeredLabel.numberOfLines = 2
        answeredLabel.lineBreakMode = .byWordWrapping
        answeredLabel.textAlignment = .center
        answeredLabel.textColor = .darkGray
        
        let answeredStack = UIStackView(arrangedSubviews: [answeredValue, answeredLabel])
        answeredStack.axis = .vertical
        answeredStack.distribution = .fillEqually
        answeredStack.translatesAutoresizingMaskIntoConstraints = false
        
        answered.addSubview(answeredStack)
        
        NSLayoutConstraint.activate([
            answeredStack.topAnchor.constraint(equalTo: answered.topAnchor),
            answeredStack.leadingAnchor.constraint(equalTo: answered.leadingAnchor),
            answeredStack.trailingAnchor.constraint(equalTo: answered.trailingAnchor),
            answeredStack.bottomAnchor.constraint(equalTo: answered.bottomAnchor)
        ])
        
        answered.translatesAutoresizingMaskIntoConstraints = false
        return answered
    }()
    
    lazy var statsDashboard: UIStackView = {
        let dashboard = UIStackView()
        dashboard.axis = .horizontal
        dashboard.distribution = .fillEqually
        dashboard.spacing = 10.0
        dashboard.addArrangedSubview(sessionsEnrolled)
        dashboard.addArrangedSubview(sessionsAttended)
        dashboard.addArrangedSubview(questionsAnswered)
        dashboard.translatesAutoresizingMaskIntoConstraints = false
        return dashboard
    }()
    
    init() {
        super.init(frame: CGRect.zero)
        
        addSubview(statsDashboard)
        
        NSLayoutConstraint.activate([
            statsDashboard.topAnchor.constraint(equalTo: topAnchor),
            statsDashboard.leadingAnchor.constraint(equalTo: leadingAnchor),
            statsDashboard.trailingAnchor.constraint(equalTo: trailingAnchor),
            statsDashboard.bottomAnchor.constraint(equalTo: bottomAnchor)])
        
//        DashboardService.instance.delegate = self
//        UserAuthService.instance.delegates?.append(self)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
//    func fetchdashboard() {
//        DashboardService.instance.dashboard()
//    }
    
    func refreshView(dashboard: Dashboard?) {
        self.enrolledValue.text = "\(dashboard?.enrolled ?? 0)"
        self.attendedValue.text = "\(dashboard?.attended ?? 0)"
        self.answeredValue.text = "\(dashboard?.completed ?? 0)"
    }
}

extension StatsView: DashboardServiceDelegate {
    func refresh(livesessions: [MaahitaSession]?) {
        
    }
    
    func refresh(feedbacksessions: [MaahitaSession]?) {

    }
    
    func refresh(dashboard: Dashboard?) {
//        self.enrolledValue.text = "\(dashboard?.enrolled ?? 0)"
//        self.attendedValue.text = "\(dashboard?.attended ?? 0)"
//        self.answeredValue.text = "\(dashboard?.completed ?? 0)"
    }
}


extension StatsView: AuthServiceDelegate {
    func refreshUser() {
//        self.fetchdashboard()
    }
}
