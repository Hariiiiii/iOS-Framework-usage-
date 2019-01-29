//
//  SimpsonsModel.swift
//  simpsons
//
//  Created by Harinarayanan Janardhanan on 1/21/19.
//  Copyright © 2019 Harinarayanan Janardhanan. All rights reserved.
//

import Foundation

public class SimpsonsModel {
    public var simsTitle : String
    public var simsDescription : String
    public var simsIcon : String
    
    public init(simsTitle : String, simsDescription : String, simsIcon : String) {
        self.simsTitle = simsTitle
        self.simsDescription = simsDescription
        self.simsIcon = simsIcon
    }
}
