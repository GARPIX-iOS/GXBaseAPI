//
//  File.swift
//  
//
//  Created by Danil on 14.01.2022.
//

import Foundation
import OSLog

extension Logger {
    private static var subsystem = Bundle.main.bundleIdentifier!

    static let networkCall = Logger(subsystem: subsystem, category: "networkCall")
}
