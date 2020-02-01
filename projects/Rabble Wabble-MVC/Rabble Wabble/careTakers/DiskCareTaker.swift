//
// DiskCareTaker.swift
//  Rabble Wabble
//
//  Created by mostfa on 1/30/20.
//  Copyright © 2020 mostfa. All rights reserved.
//

import Foundation

public final class DiskCareTaker { //CareTaker
    public static let decoder = JSONDecoder()
    public static let encoder = JSONEncoder()
    public static func createDocumentURL( withFileName fileName: String) -> URL {
        let fileManger = FileManager.default
        let url = fileManger.urls(for: .documentDirectory, in: .userDomainMask).first!
        return url.appendingPathComponent(fileName).appendingPathComponent(".json ")
    }
    
    public static func save<T:Codable>(_ object: T, to fileName: String) throws {
        do {
            let url = createDocumentURL(withFileName: fileName)
            let data = try encoder.encode(object)
            try data.write(to: url,options: .atomic)
        } catch (let error) {
            print("Saving failed for oject",object, ",the Error:",error)
        }
    }
    public static func retrieve<T: Codable>(_ type: T.Type, from fileName: String) throws -> T {
        let url = createDocumentURL(withFileName: fileName)
        return try retrieve(T.self, from: url)
    }
    public static func retrieve<T: Codable>(_ type: T.Type, from url: URL) throws -> T {
        do {
            let data = try Data(contentsOf: url)
            return try decoder.decode(T.self, from: data)
            
            
        }catch (let error) {
            throw error
        }
    }
}
