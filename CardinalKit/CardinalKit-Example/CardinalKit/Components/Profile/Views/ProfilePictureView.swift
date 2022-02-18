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
                                   // .contentShape(Circle())
                                    .clipShape(Circle())
            }
            else {
                Text("TAP TO UPLOAD YOUR PROFILE PICTURE")
                    .fontWeight(.bold)
                    .font(.title2)
                    .foregroundColor(.black)
            }
//            Text("TAP TO UPLOAD YOUR PROFILE PICTURE")
//                                .fontWeight(.bold)
//                                .font(.title2)
//                                .foregroundColor(.white)
//            image?
//                                .resizable()
//                                .scaledToFit()
            Spacer()
        }
        //.frame(height: 60)
//
//            .frame(maxWidth: .infinity)
//            .padding()
//            .padding(.top, Metrics.PADDING_VERTICAL_MAIN*2.5)
//            .padding(.bottom, Metrics.PADDING_VERTICAL_MAIN*2.5)
//            .background(Color.gray)
//            .cornerRadius(10)
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
