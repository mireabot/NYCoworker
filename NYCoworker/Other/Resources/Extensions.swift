//
//  Extensions.swift
//  NYCoworker
//
//  Created by Mikhail Kolkov on 1/27/23.
//

import Foundation


//MARK: - String
extension String {
    
    var withSingleTrailingSpace:  String {
        appending(" ")
    }
    
    var withSingleLeadingSpace:  String {
        " " + self
    }
}
