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
    //Tool picker
    @Published var toolPicker = PKToolPicker()
    //List of textboxes
    @Published var textBoxes : [TextBox] = []
    
    @Published var addNewBox = false
    
    //Current textBox index
    @Published var currentIndex: Int = 0
    
    //Saving image frame size
    @Published var rect: CGRect = .zero
    
    //cancel function
    func cancelImageEditing(){
        imageData = Data(count: 0)
        canvas = PKCanvasView()
        // showImagePicker.toggle()
    }
    func cancelTextView(){
        //showing again toolpicker
        toolPicker.setVisible(true, forFirstResponder: canvas)
        canvas.becomeFirstResponder()
        // hide add new text box screen
        withAnimation{
            addNewBox = false
        }
        //removing if cancelled ...
        textBoxes.removeLast()
    }
    
    func saveImage(){
        //generating image from canvas and textboxes
        UIGraphicsBeginImageContextWithOptions(rect.size, false, 1)
        // canvas
        canvas.drawHierarchy(in: CGRect(origin:.zero,size:rect.size), afterScreenUpdates: true)
        //getting image
        let generatedImage = UIGraphicsGetImageFromCurrentImageContext()
        //ending reender ...
        UIGraphicsEndImageContext()
        if let image = generatedImage{
            //saving image...
            UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
            print("hura !")
        }
        
    }
}
