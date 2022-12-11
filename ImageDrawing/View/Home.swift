//
//  Home.swift
//  ImageDrawing
//
//  Created by Jacek Kosiński G on 09/12/2022.
//

import Foundation
import SwiftUI

struct Home: View {
    @StateObject var model = DrawingViewModel()
    var body: some View {
        ZStack{
            NavigationView{
                VStack{
                    if let _ = UIImage(data: model.imageData){
                     
                        DrawingScreen().environmentObject(model)

                        // extra button to cancel if selected image
                            .toolbar(content:{
                                ToolbarItem(placement: .navigationBarLeading){
                                    Button(action: model.cancelImageEditing, label: {
                                        Image(systemName: "xmark")
                                    })
                                }
                            })
                    } else {
                        //Show picker
                        Button(action: {model.showImagePicker.toggle()}, label: {
                            Image(systemName: "plus")
                                .font(.title)
                                .foregroundColor(.black)
                                .frame(width: 70,height: 70)
                                .background(Color.white)
                                .cornerRadius(10)
                                .shadow(color: Color.black.opacity(0.07), radius: 5, x: 5, y:5)
                                .shadow(color: Color.black.opacity(0.07), radius: 5, x: -5, y:-5)
                        })
                    }
                        
                }
                .navigationTitle("Image Editor")
            }
            
            if model.addNewBox{
                Color.black.opacity(0.75).ignoresSafeArea()
                // add and cancel buttons
                TextField("Type Here", text: $model.textBoxes[model.currentIndex].text)
                    .font(.system(size:35, weight:model.textBoxes[model.currentIndex].isBold ? .bold : .regular))
                    .colorScheme(.dark)
                    .foregroundColor(model.textBoxes[model.currentIndex].textColor)
                    .padding()
                
                HStack{
                    Button(action: {
                        
                        //closing the view ...
                        model.toolPicker.setVisible(true, forFirstResponder: model.canvas)
                        model.canvas.becomeFirstResponder()
                        
                        withAnimation{
                            model.addNewBox = false
                            
                        }
                        
                    }, label: {
                        Text("Add")
                            .fontWeight(.heavy)
                            .foregroundColor(.white)
                            .padding()
                    })
                    
                    Spacer()
                    
                    Button(action: model.cancelTextView, label: {
                        Text("Cancel")
                            .fontWeight(.heavy)
                            .foregroundColor(.white)
                            .padding()
                    })
                }
                .overlay(
                    HStack(spacing: 15){
                        //Color Picker
                        ColorPicker("", selection: $model.textBoxes[model.currentIndex].textColor)
                            .labelsHidden()
                        Button(action: {
                            model.textBoxes[model.currentIndex].isBold.toggle()
                        }, label: {
                            Text(model.textBoxes[model.currentIndex].isBold ? "Normal" : "Bold")
                                .fontWeight(.bold)
                                .foregroundColor(.white)
                        })
                    }
                    
                )
                .frame(maxHeight:.infinity,alignment: .top)
            }
        }
        //Showing picker
        .sheet(isPresented: $model.showImagePicker, content: {
            ImagePicker(showPicker: $model.showImagePicker, imageData: $model.imageData)
        })
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}
