//
//  Data+Ext.swift
//  GHFollowers
//
//  Created by Apple on 9/15/20.
//  Copyright © 2020 MohamedMostafa. All rights reserved.
//

import Foundation

extension Date {
    
    func convertToMonthYearFotmat() -> String {
        let dateFotmatter = DateFormatter()
        dateFotmatter.dateFormat = "MMM yyyy"
        
        return dateFotmatter.string(from: self)
    }
}
