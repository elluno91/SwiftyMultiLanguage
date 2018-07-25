//
//  Language.swift
//  Alamofire
//
//  Created by YBC on 24/07/18.
//

import Foundation
import Alamofire
import SwiftyJSON

public class Language {
    static var languageEngine: LanguageEngine = LanguageEngine()
    
    public init() {}
    
    public static func build(languageBuilder: LanguageBuilder) {
        Language.languageEngine = LanguageEngine(languageBuilder: languageBuilder)
    }
    
    public static func setMainLanguage(language: String) {
         Language.languageEngine.setMainLanguage(language: language)
    }
    
    public static func getLanguage(language: String) -> String {
        let languageRawString = Language.languageEngine.getLanguage()
        if(languageRawString != nil) {
            let languageJSONParse = JSON.init(parseJSON: languageRawString!)
            if(!languageJSONParse[language].exists()) {
                return language
            } else {
                return languageJSONParse[language].stringValue
            }
        } else {
            return language
        }
    }
    
    public static func resetAllLanguage() {
        Language.languageEngine.resetAllLanguage()
    }
}
