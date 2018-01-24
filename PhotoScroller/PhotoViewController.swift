//
//  PhotoViewController.swift
//  PhotoScroller
//
//  Created by Seyed Samad Gholamzadeh on 1/19/18.
//  Copyright © 2018 Seyed Samad Gholamzadeh. All rights reserved.
//

import UIKit

class PhotoViewController: UIViewController {
	
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
		
    }
	
	
	
	
	
	
	
	
	
	
	//MARK: - Image Fetching tools
	
	lazy var imageData: [Any]? = {
		var data: [Any]? = nil
		
		DispatchQueue.global().sync {
			let path = Bundle.main.url(forResource: "ImageData", withExtension: "plist")
			do {
				let plistData = try Data(contentsOf: path!)
				data = try PropertyListSerialization.propertyList(from: plistData, options: PropertyListSerialization.ReadOptions.mutableContainers, format: nil) as? [Any]
				//				return data
			}
			catch {
				print("Unable to read image data: ", error)
			}
			
		}
		return data
	}()
	
	lazy var imageCount: Int = {
		return self.imageData?.count ?? 0
	}()
	
	func imageName(at index: Int) -> String {
		if let info = imageData?[index] as? [String: Any] {
			return info["name"] as? String ?? ""
		}
		return ""
	}
	
	// we use "imageWithContentsOfFile:" instead of "imageNamed:" here to avoid caching
	func image(at index: Int) -> UIImage {
		let name = imageName(at: index)
		if let path = Bundle.main.path(forResource: name, ofType: "jpg") {
			return UIImage(contentsOfFile: path)!
		}
		return UIImage()
	}
	
	func imageSizeAt(index: Int) -> CGSize {
		if let info = imageData?[index] as? [String: Any] {
			return CGSize(width: info["width"] as? CGFloat ?? 0, height: info["height"] as? CGFloat ?? 0)
		}
		return CGSize.zero
	}

}
