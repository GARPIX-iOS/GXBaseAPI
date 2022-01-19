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
    let compressionQuality: CGFloat
    
    public init?(withImage image: UIImage, forKey key: String, compressionQuality: CGFloat = 0.3) {
        self.key = key
        self.mimeType = "image/jpeg"
        self.filename = "imagefile.jpg"
        self.compressionQuality = compressionQuality
        guard let data = image.jpegData(compressionQuality: compressionQuality) else { return nil }
        self.data = data
    }
}
