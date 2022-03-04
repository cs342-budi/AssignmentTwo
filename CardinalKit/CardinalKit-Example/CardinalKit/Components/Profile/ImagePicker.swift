//
//  ImagePicker.swift
//  CardinalKit_Example
//
//  Created by Lina Fang on 16.02.22.
//  Copyright © 2022 CocoaPods. All rights reserved.
//

import PhotosUI
import SwiftUI
import Firebase

struct ImagePicker: UIViewControllerRepresentable {
    @Binding var image: UIImage?

    func makeUIViewController(context: Context) -> PHPickerViewController {
        var config = PHPickerConfiguration()
        config.filter = .images
        let picker = PHPickerViewController(configuration: config)
        picker.delegate = context.coordinator
        return picker
    }

    func updateUIViewController(_ uiViewController: PHPickerViewController, context: Context) {

    }

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    class Coordinator: NSObject, PHPickerViewControllerDelegate {
        let parent: ImagePicker

        init(_ parent: ImagePicker) {
            self.parent = parent
        }

        func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
            picker.dismiss(animated: true)

            guard let provider = results.first?.itemProvider else { return }

            if provider.canLoadObject(ofClass: UIImage.self) {
                provider.loadObject(ofClass: UIImage.self) { image, _ in
                    if (image != nil) {
                        self.parent.image = image as? UIImage

                        let profileImagesRef = Storage.storage().reference().child("profile_pictures/profile_picture.jpg")
                        
                        // convert image to data
                        guard let uploadData = (image as! UIImage).jpegData(compressionQuality: 0.3) else { return }
                        
                        // save data to Firebase storage
                        profileImagesRef.putData(uploadData, metadata: nil, completion: { (metadata, error) in
                            if let error = error { return }

                            // After the image has been successfully uploaded we need to grab its download url
                            profileImagesRef.downloadURL(completion: { (downloadURL, error) in
                                if let error = error { return }

                                guard let downloadURL = downloadURL else { return }

                                print("successfully fetched download URL: \(downloadURL.absoluteString)")
                            })
                        })
                    }
                    
                }
            }
        }
    }
}
