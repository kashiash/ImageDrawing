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
    
    //Alert
    @Published var showAlert = false
    @Published var message = ""
    
    //cancel function
    func cancelImageEditing(){
        imageData = Data(count: 0)
        canvas = PKCanvasView()
        textBoxes.removeAll()
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
        // avoiding the removal; of already added...
        if !textBoxes[currentIndex].isAdded{
            textBoxes.removeLast()
        }
      
    }
    
    func saveImage(){
        //generating image from canvas and textboxes
        UIGraphicsBeginImageContextWithOptions(rect.size, false, 0)
        // canvas
        canvas.drawHierarchy(in: CGRect(origin:.zero,size:rect.size), afterScreenUpdates: true)
        // darwing textboxes
        let SwiftUIView = ZStack{
            ForEach(textBoxes){ [self] box in
                
                Text(textBoxes[currentIndex].id == box.id && addNewBox ? "" : box.text)
                    .font(.system(size:30))
                    .fontWeight(box.isBold ? .bold  : .none)
                    .foregroundColor(box.textColor)
                    .offset(box.offset)
                
            }
        }
        
        let controller = UIHostingController(rootView: SwiftUIView).view!
        controller.frame = rect
        
        //clearing bg...
        controller.backgroundColor = .clear
        canvas.backgroundColor = .clear
        
        controller.drawHierarchy(in: CGRect(origin: .zero
                                            , size: rect.size), afterScreenUpdates: true)
        
        //getting image
        let generatedImage = UIGraphicsGetImageFromCurrentImageContext()
        //ending reender ...
        UIGraphicsEndImageContext()
        if let image = generatedImage{
            //saving image...
            UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
            print("hura !")
            self.message = "Saved Successfully !!!"
            self.showAlert.toggle()
        }
        
    }
}
