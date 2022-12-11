//
//  TextBox.swift
//  ImageDrawing
//
//  Created by Jacek Kosiński G on 11/12/2022.
//

import Foundation
import SwiftUI

struct TextBox:Identifiable{
    var id = UUID().uuidString
    var text:String = ""
    var isBold = false
    var offset: CGSize = .zero
    var lastOffset: CGSize = .zero
    var textColor: Color = .red
    var isAdded: Bool = false
}
