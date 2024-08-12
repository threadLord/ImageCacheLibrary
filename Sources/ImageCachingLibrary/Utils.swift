//
//  File.swift
//  
//
//  Created by Marko on 12.8.24..
//

import Foundation


public class Utils {
    public static func createKey(from url: URL) -> String? {
        return url.absoluteString.components(separatedBy:"/").last
    }
    
    public static func createKeyFrom(urlString: String) -> String? {
        return urlString.components(separatedBy:"/").last
    }
}
