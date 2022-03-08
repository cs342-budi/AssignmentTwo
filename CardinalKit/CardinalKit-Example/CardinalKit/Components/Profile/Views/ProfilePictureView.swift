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
    enum State {
        case idle
        case loading
        case failed
        case loaded
    }

    @Published private(set) var state = State.idle
    @Published var downloadedImage: Image?

    func fetchImage() {
        state = .loading

        let storageRef = Storage.storage().reference()

        let profilePictureRef = storageRef.child("profile_pictures/profile_picture.jpg")

        profilePictureRef.getData(maxSize: 1 * 1024 * 1024) { data, error in
            if let error = error {
                print(" Error: Image could not downlioad")
                self.state = .failed
            } else {
                DispatchQueue.main.async {
                    let downloadedUIImage = UIImage(data: data!)
                    self.downloadedImage = Image(uiImage: downloadedUIImage!)
                    self.state = .loaded
                }
            }
        }
    }
}

struct ProfilePictureView: View {
    @ObservedObject var viewModel =  ProfilePictureViewModel()
    @State private var inputImage: UIImage?
    @State private var showingImagePicker = false
    @State private var image: Image?

    var body: some View {
        ZStack {
            switch viewModel.state {
                case .idle:
                    Color.clear.onAppear(perform: viewModel.fetchImage)
                case .loading:
                    Text("Loading...")
                case .failed:
                    if (image != nil) {
                        image?
                            .resizable()
                            .scaledToFit()
                            .clipShape(Circle())
                    } else {
                        Text("Tap to upload your profile picture")
                            .fontWeight(.bold)
         //                   .font(.title2)
                            .foregroundColor(.gray)
                    }
                case .loaded:
                    if (viewModel.downloadedImage != nil) {
                        viewModel.downloadedImage?
                            .resizable()
                            .scaledToFit()
                            .clipShape(Circle())
                            .frame(width: 100, height: 100)
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
