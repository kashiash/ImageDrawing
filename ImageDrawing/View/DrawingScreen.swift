//
//  DrawingScreen.swift
//  ImageDrawing
//
//  Created by Jacek Kosiński G on 10/12/2022.
//

import SwiftUI
import PencilKit

struct DrawingScreen: View {
    @EnvironmentObject var model: DrawingViewModel
    var body: some View {
        ZStack{
            //UIkit pencil darwing view
            
            
            GeometryReader{ proxy -> AnyView in
                
                let size = proxy.frame(in:   .global   ).size
                
                return AnyView(
                    ZStack{
                        CanvasView(canvas: $model.canvas,imageData: $model.imageData,toolPicker: $model.toolPicker, rect: size)
                        //custome text and objets
                        
                    }
                )
            }
            
            
        }
        .toolbar(content: {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: {}, label: {
                    Text("Save")
                })
            }
            ToolbarItem(placement: .navigationBarTrailing) {
              Button(action: {}, label: {
                  Image(systemName: "v.circle")
              })
            }
            ToolbarItem(placement: .navigationBarTrailing) {
              Button(action: {}, label: {
                Image(systemName: "a.circle")
              })
            }
        })
    }
}

struct DrawingScreen_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}




struct CanvasView: UIViewRepresentable {
    
    @Binding var canvas: PKCanvasView
    @Binding var imageData: Data
    @Binding var toolPicker: PKToolPicker
    
    // rect size
    
    var rect: CGSize
    
    
    
    
    
    
    func makeUIView(context: Context) ->  PKCanvasView {
        canvas.isOpaque = false
        canvas.backgroundColor = .clear
        canvas.drawingPolicy = .anyInput
        
        if let image = UIImage(data: imageData){
            let imageView = UIImageView(image: image)
            imageView.frame = CGRect(x: 0, y: 0, width: rect.width, height: rect.height)
            imageView.contentMode = .scaleAspectFit
            imageView.clipsToBounds = true;
            
            let subView = canvas.subviews[0]
            subView.addSubview(imageView)
            subView.sendSubviewToBack(imageView)
            
            toolPicker.setVisible(true,forFirstResponder: canvas)
            toolPicker.addObserver(canvas)
            canvas.becomeFirstResponder()
        }
        
        return canvas
        
    }
    func updateUIView(_ uiView: PKCanvasView, context: Context) {
        
    }
}


