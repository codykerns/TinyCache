//
//  Dates.swift
//  TinyCache
//
//  Created by Cody Kerns on 4/26/22.
//

import Foundation

internal extension Date {
    func add(seconds: Int) -> Date {
        return self.addingTimeInterval(TimeInterval(seconds))
    }

    func add(minutes: Int) -> Date {
        return self.add(seconds: 60 * minutes)
    }

    func add(hours: Int) -> Date {
        return self.add(minutes: 60 * hours)
    }

    func add(days: Int) -> Date {
        return self.add(hours: 24 * days)
    }
}
