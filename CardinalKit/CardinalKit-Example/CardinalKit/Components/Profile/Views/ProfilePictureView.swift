//
//  ProfilePictureView.swift
//  CardinalKit_Example
//
//  Created by Lina Fang on 16.02.22.
//  Copyright © 2022 CocoaPods. All rights reserved.
//

import SwiftUI

struct ProfilePictureView: View {
    @State private var showingImagePicker = false
    @State private var inputImage: UIImage?
    @State private var image: Image?

    var body: some View {
        ZStack {
            if (image != nil) {
                image?
                               .resizable()
                                    .scaledToFit()
                                    .clipShape(Circle())
            }
            else {
                Text("Tap to upload your profile picture")
                    .fontWeight(.bold)
 //                   .font(.title2)
                    .foregroundColor(.gray)
            }
            Spacer()
        }

            .onTapGesture {
                showingImagePicker = true
            }
            .onChange(of: inputImage) {
                _ in loadImage()
            }
            .sheet(isPresented: $showingImagePicker) {
                ImagePicker(image: $inputImage)
            }
    }
    
    func loadImage() {
        guard let inputImage = inputImage else {
            return
        }
        image = Image(uiImage: inputImage)
    }
    
    func save() {
    }
}

//struct ProfilePictureView_Previews: PreviewProvider {
//    static var previews: some View {
//        ProfilePictureView(inputImage: <#UIImage#>)
//    }
//}
