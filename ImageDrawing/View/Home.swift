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
        NavigationView{
            VStack{
                if let ImageFile = UIImage(data: model.imageData){
                    Image(uiImage: ImageFile)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
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
