//
//  DrawingViewModel.swift
//  ImageDrawing
//
//  Created by Jacek Kosiński G on 10/12/2022.
//

import SwiftUI
import PencilKit
// hold all drawing data
class DrawingViewModel: ObservableObject {
    @Published var showImagePicker = false
    @Published var imageData: Data = Data(count: 0)
    
    //Canvas for drawing ...
    @Published var canvas = PKCanvasView()
    
    @Published var toolPicker = PKToolPicker()
    
//cancel function
    func cancelImageEditing(){
        imageData = Data(count: 0)
       // showImagePicker.toggle()
    }
}



