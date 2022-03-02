//
//  ProfilePictureView.swift
//  CardinalKit_Example
//
//  Created by Lina Fang on 16.02.22.
//  Copyright © 2022 CocoaPods. All rights reserved.
//

import SwiftUI
import Firebase

class ProfilePictureViewModel: ObservableObject {
    @Published var downloadedImage: Image?

    func getImage() {
        let storageRef = Storage.storage().reference()
        
        let profilePictureRef = storageRef.child("profile_pictures/profile_picture.jpg")
        
        profilePictureRef.getData(maxSize: 1 * 1024 * 1024) { data, error in
            if let error = error {
                print(" Error: Image could not downlioad")
            } else {
                let downloadedUIImage = UIImage(data: data!)
                self.downloadedImage = Image(uiImage: downloadedUIImage!)

            }
        }
    }
}

struct ProfilePictureView: View {
    @StateObject private var viewModel = ProfilePictureViewModel()

    @State private var inputImage: UIImage?
    @State private var showingImagePicker = false
    @State private var image: Image?

    var body: some View {
        ZStack {
            if let downloadedImage = viewModel.downloadedImage {
                downloadedImage
                    .resizable()
                    .scaledToFit()
                    .clipShape(Circle())
            } else {
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
            .onAppear {
                viewModel.getImage()
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
