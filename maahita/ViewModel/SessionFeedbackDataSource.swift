//
//  FeedbackDataSource.swift
//  maahita
//
//  Created by Jagan Kumar Mudila on 23/05/2020.
//  Copyright © 2020 Jagan Kumar Mudila. All rights reserved.
//

import UIKit

class SessionFeedbackDataSource: FeedbackDataSource<Feedback>, UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.value?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.getCell(with: FeedbackCell.self, at: indexPath) as? FeedbackCell else {
            preconditionFailure("Invalid cell type")
        }
//
//        if let feedback = data.value?[indexPath.row] {
//            cell.feedback = FeedbackCellViewModel(feedback: feedback)
//        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UITableViewHeaderFooterView? {
        guard let view = tableView.getHeader(with: UITableViewHeaderFooterView.self) as? UITableViewHeaderFooterView else {
            preconditionFailure("Invalid view type")
        }
        
        let sessionTitleView = SessionView()	
        sessionTitleView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(sessionTitleView)
        
        NSLayoutConstraint.activate([
            sessionTitleView.topAnchor.constraint(equalTo: view.topAnchor),
            sessionTitleView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            sessionTitleView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            sessionTitleView.bottomAnchor.constraint(equalTo: view.bottomAnchor)])
        
        return view
    }
}
