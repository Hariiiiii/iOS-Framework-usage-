//
//  ModelJSON.swift
//  simpsons
//
//  Created by Harinarayanan Janardhanan on 1/19/19.
//  Copyright © 2019 Harinarayanan Janardhanan. All rights reserved.
//

import Foundation
import UIKit

public struct ModelJSON : Decodable{
    public let RelatedTopics : [SimpsonsData]?
}
public struct SimpsonsData : Decodable{
    public let Result : String?
    public let Icon : Icon?
    public let FirstURL : String?
    public let Text : String?
}

public struct Icon : Decodable{
    public let URL : String?
    public let Height : String?
    public let Width : String?
}
