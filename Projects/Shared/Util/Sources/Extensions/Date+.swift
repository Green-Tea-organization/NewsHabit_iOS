//
//  Date+.swift
//  SharedUtil
//
//  Created by 지연 on 10/20/24.
//

import Foundation

extension Date {
    public func formatAsFullDateTime() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy년 M월 d일 HH:00"
        return dateFormatter.string(from: self)
    }
    
    public func formatAsMonthYear() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy년 M월"
        return dateFormatter.string(from: self)
    }

    public func formatAsTimeWithPeriod() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "hh:mm a"
        return dateFormatter.string(from: self)
    }
}
