//
//  FileStorage.swift
//  PokeMaster
//
//  Created by yl on 2019/10/23.
//  Copyright © 2019 OneV's Den. All rights reserved.
//

import Foundation

@propertyWrapper

struct FileStorage<T: Codable> {
    var value: T?
    
    let directory: FileManager.SearchPathDirectory
    let fileName: String
    
    init(directory: FileManager.SearchPathDirectory, fileName: String) {
        value = try? FileHelper.loadJSON(from: directory, fileName: fileName)
        self.directory = directory
        self.fileName = fileName
    }
    
    var wrappedValue: T?{
        set{
            value = newValue
            if let value = newValue{
                try? FileHelper.writeJSON(value, to: directory, fileName: fileName)
            }else{
                try? FileHelper.delete(from: directory, fileName: fileName)
            }
        }
        
        get { value }
    }
    
}
