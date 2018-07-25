//
//  LanguageBuilder.swift
//  Alamofire
//
//  Created by YBC on 24/07/18.
//

import Foundation
import Alamofire
import SwiftyJSON

public class LanguageBuilder {
    
    public init() {}
    
    public func setDownloadURL(downloadURL: String) {
        UserDefaults.standard.set(downloadURL, forKey: "downloadLanguage")
    }
    
    public func setAvailableLanguage(listLanguage: Array<String>) {
        UserDefaults.standard.set(listLanguage, forKey: "listLanguage")
    }
}
