//
//  DrawingViewModel.swift
//  ImageDrawing
//
//  Created by Jacek Kosiński G on 10/12/2022.
//

import SwiftUI
// hold all drawing data
class DrawingViewModel: ObservableObject {
    @Published var showImagePicker = false
    @Published var imageData: Data = Data(count: 0)
    
//cancel function
    func cancelImageEditing(){
        imageData = Data(count: 0)
        showImagePicker.toggle()
    }
}



