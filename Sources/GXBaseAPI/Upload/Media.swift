//
//  File.swift
//  
//
//  Created by Danil on 19.01.2022.
//

import Foundation
import UIKit

public struct Media {
    let key: String
    let filename: String
    let data: Data
    let mimeType: String
    
    public init?(withImage image: UIImage, forKey key: String) {
        self.key = key
        self.mimeType = "image/jpeg"
        self.filename = "imagefile.jpg"
        guard let data = image.jpegData(compressionQuality: 0.7) else { return nil }
        self.data = data
    }
}
