//
//  Item.swift
//  Todoe
//
//  Created by Marios Effraimiadis on 25/08/2018.
//  Copyright © 2018 Marios. All rights reserved.
//

import Foundation


class Item: Codable {               //Encodable, Decodable
    var title: String = ""
    var done: Bool = false //items will start as not done
}
