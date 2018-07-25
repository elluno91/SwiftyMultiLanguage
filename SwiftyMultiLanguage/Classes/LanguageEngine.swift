//
//  LanguageEngine.swift
//  Alamofire
//
//  Created by YBC on 24/07/18.
//

import Foundation
import Alamofire
import SwiftyJSON

public class LanguageEngine {
    
    var languageBuilder: LanguageBuilder = LanguageBuilder()
    
    var listDownloadLanguageTask : NSMutableArray = []
    var listFinishedDownloadLanguageTask : NSMutableArray = []
    var resultDownloadFile : Bool = false
    
    public init() {}
    
    public init(languageBuilder: LanguageBuilder) {
        self.languageBuilder = languageBuilder
        self.downloadFileLanguage()
    }
    
    public func setMainLanguage(language: String) {
        UserDefaults.standard.set(language, forKey: "mainLanguage")
    }
    
    public func resetAllLanguage() {
        let listAvailableLanguage = self.getListAvailableLanguage()
        for i in 0 ..< listAvailableLanguage.count {
            if let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
                let fileURL = dir.appendingPathComponent("\(listAvailableLanguage[i]).json")
                do {
                    try FileManager.default.removeItem(at: fileURL)
                } catch {
                    print(error)
                }
            }
        }
        self.downloadFileLanguage()
    }
    
    public func getLanguage() -> String? {
        let mainLanguage = self.getMainLanguage()
        return self.readFile(file: "\(mainLanguage).json")
    }
    
    private func getMainLanguage() -> String {
        return UserDefaults.standard.string(forKey: "mainLanguage")!
    }
    
    private func getDownloadUrlLanguage() -> String {
        return  UserDefaults.standard.string(forKey: "downloadLanguage")!
    }
    
    private func getListAvailableLanguage() -> Array<String> {
        return  UserDefaults.standard.stringArray(forKey: "listLanguage")!
    }
    
    public func downloadFileLanguage() {
        
        let listAvailableLanguage = self.getListAvailableLanguage()
        
        for i in 0 ..< listAvailableLanguage.count {
            
            if let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
                let fileURL = dir.appendingPathComponent("\(listAvailableLanguage[i]).json")
                if(!FileManager.default.fileExists(atPath: fileURL.path)) {
                    Alamofire.request("\(getDownloadUrlLanguage())\(listAvailableLanguage[i])").responseString { response in
                        self.writeToFile(file: "\(listAvailableLanguage[i]).json", content: response.result.value!)
                    }
                }
            }
        }
    }
    
    private func writeToFile(file: String, content: String) {
        if let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
            let fileURL = dir.appendingPathComponent(file)
            do {
                try content.write(to: fileURL, atomically: false, encoding: .utf8)
            }
            catch {
                print("Cannot write to file \(error)")
            }
        }
    }
    
    private func readFile(file: String) -> String? {
        if let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
            let fileURL = dir.appendingPathComponent(file)
            do {
                let content = try String(contentsOf: fileURL, encoding: .utf8)
                return content
            }
            catch {
                print("Cannot read file \(error)")
            }
        }
        return nil
    }
}
