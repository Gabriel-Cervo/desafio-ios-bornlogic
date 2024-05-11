//
//  DIContainer.swift
//  bornlogic-test
//
//  Created by João Gabriel Dourado Cervo on 11/05/24.
//

import Foundation

typealias Factory = (DIContainerService) -> Any

/// An object that can be used as a DI service
protocol ServiceEntryProtocol: AnyObject {
    var factory: Factory { get }
    var instance: Any? { get set }
}

//MARK: - entry implementation

final class ServiceEntry: ServiceEntryProtocol {
    var instance: Any?
    var factory: Factory
    
    weak var container: DIContainer?
    
    init(factory: @escaping Factory) {
        self.factory = factory
    }
}

//MARK: - DIContainer

/// A container that can register and resolve services entries
protocol DIContainerService {
    func register<Service>(type: Service.Type, name: String?, factory: @escaping (DIContainerService) -> Service) -> ServiceEntry
    func resolve<Service>(type: Service.Type, name: String?) -> Service?
}

extension DIContainerService {
    @discardableResult
    func register<Service>(type: Service.Type, name: String? = nil, factory: @escaping (DIContainerService) -> Service) -> ServiceEntry {
        register(type: type, name: name, factory: factory)
    }
    
    func resolve<Service>(type: Service.Type, name: String? = nil) -> Service? {
        resolve(type: type, name: name)
    }
}

//MARK: - Default container

final class DIContainer: DIContainerService {
    private var services: [String: ServiceEntryProtocol] = [:]
    
    init() {}
    
    @discardableResult
    func register<Service>(type: Service.Type, name: String?, factory: @escaping (DIContainerService) -> Service) -> ServiceEntry {
        let entry = ServiceEntry(factory: factory)
        entry.container = self
        
        let key = "\(type)\(name ?? "")"
        services[key] = entry
        
        return entry
    }
    
    func resolve<Service>(type: Service.Type, name: String?) -> Service? {
        let key = "\(type)\(name ?? "")"
        
        guard let entry = services[key] else {
            return nil
        }
        
        var resolvedService: Service?
    
        if let instance = entry.instance {
            resolvedService = instance as? Service
        } else {
            resolvedService = entry.factory(self) as? Service
            entry.instance = resolvedService
        }
        
        return resolvedService
    }
}
