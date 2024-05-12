//
//  KeychainHelper.swift
//  bornlogic-test
//
//  Created by João Gabriel Dourado Cervo on 12/05/24.
//

import Foundation

/// Helper class for reading and storing data to `Keychain` api
final class KeychainHelper {
    static let shared = KeychainHelper()
    
    private init() {}
    
    /// Saves data to keychain
    ///
    /// - Parameters:
    ///   - data: An object `Data`
    ///   - service: The service that is using this information
    ///   - account: The account owner for this info
    func save(_ data: Data, service: String, account: String) {
        let query = [
            kSecValueData: data,
            kSecAttrService: service,
            kSecAttrAccount: account,
            kSecClass: kSecClassGenericPassword
        ] as CFDictionary
        
        let status = SecItemAdd(query, nil)
            
        if status != errSecDuplicateItem {
            return
        }
        
        let updateQuery = [
            kSecAttrService: service,
            kSecAttrAccount: account,
            kSecClass: kSecClassGenericPassword
        ] as CFDictionary
        
        let attributesToUpdate = [kSecValueData: data] as CFDictionary
        SecItemUpdate(updateQuery, attributesToUpdate)
    }
    
    /// Saves an Object to keychain
    ///
    /// It's just a helper method that underline uses the `save(_ data:)` method.
    ///
    /// - Parameters:
    ///   - item: A `Codable` object to be saved on Keychain
    ///   - service: The service that is using this information
    ///   - account: The account owner for this info
    func save(_ item: some Codable, service: String, account: String) {
        do {
            let data = try JSONEncoder().encode(item)
            save(data, service: service, account: account)
        } catch {
            #if DEBUG
            print("Error saving to keychain: \(error)")
            #endif
        }
    }
    
    /// Reads ana data from keychain
    ///
    /// - Parameters:
    ///   - service: The service that is using this information
    ///   - account: The account owner for this info
    ///
    /// - Returns:
    ///    A Data object for this query or `nil` if none was found
    func read(service: String, account: String) -> Data? {
        let query = [
            kSecAttrService: service,
            kSecAttrAccount: account,
            kSecClass: kSecClassGenericPassword,
            kSecReturnData: true
        ] as CFDictionary
        
        var result: AnyObject?
        SecItemCopyMatching(query, &result)
        
        return (result as? Data)
    }
    
    /// Reads ana data from keychain
    ///
    /// It's just a helper method that underline uses the `read` method but instead returns the data as an `Object`
    ///
    /// - Parameters:
    ///   - service: The service that is using this information
    ///   - account: The account owner for this info
    ///   - type: The type to be decoded to
    ///
    /// - Returns:
    ///    A Data object decoded to `type` for this query or `nil` if none was found or the conversion wasn't possible
    func read(service: String, account: String, type: (some Codable).Type) -> (any Codable)? {
        guard let data = read(service: service, account: account) else {
            return nil
        }
        
        do {
            let item = try JSONDecoder().decode(type, from: data)
            return item
        } catch {
            #if DEBUG
            print("Error decoding from keychain: \(error)")
            #endif
            
            return nil
        }
    }

    /// Deletes data from keychain
    ///
    /// - Parameters:
    ///   - service: The service that is using this information
    ///   - account: The account owner for this info
    func delete(service: String, account: String) {
        let query = [
            kSecAttrService: service,
            kSecAttrAccount: account,
            kSecClass: kSecClassGenericPassword,
        ] as CFDictionary
        
        SecItemDelete(query)
    }
}
