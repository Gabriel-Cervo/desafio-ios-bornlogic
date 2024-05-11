//
//  DefaultCodableStrategy.swift
//  bornlogic-test
//
//  Created by João Gabriel Dourado Cervo on 11/05/24.
//

import Foundation

/// Provides a default value for missing `Decodable` data.
///
/// Inspired by: http://marksands.github.io/2019/10/21/better-codable-through-property-wrappers.html
///
/// `DefaultCodableStrategy` provides a generic strategy type that the `DefaultCodable` property wrapper can use to provide a reasonable default value for missing Decodable data.
public protocol DefaultCodableStrategy {
    associatedtype RawValue: Codable

    static var defaultValue: RawValue { get }
}

/// Decodes values with a reasonable default value
///
/// `@Defaultable` attempts to decode a value and falls back to a default type provided by the generic `DefaultCodableStrategy`.
@propertyWrapper
public struct DefaultCodable<Default: DefaultCodableStrategy>: Codable {
    public var wrappedValue: Default.RawValue

    public init(wrappedValue: Default.RawValue) {
        self.wrappedValue = wrappedValue
    }

    public init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        self.wrappedValue = (try? container.decode(Default.RawValue.self)) ?? Default.defaultValue
    }

    public func encode(to encoder: Encoder) throws {
        try wrappedValue.encode(to: encoder)
    }
}

extension DefaultCodable: Equatable where Default.RawValue: Equatable { }
extension DefaultCodable: Hashable where Default.RawValue: Hashable { }

// MARK: - KeyedDecodingContainer

extension KeyedDecodingContainer {

    /// Default implementation of decoding a DefaultCodable
    ///
    /// Decodes successfully if key is available if not fallsback to the default value provided.
    func decode<P>(_: DefaultCodable<P>.Type, forKey key: Key) throws -> DefaultCodable<P> {
        if let value = try decodeIfPresent(DefaultCodable<P>.self, forKey: key) {
            return value
        } else {
            return DefaultCodable(wrappedValue: P.defaultValue)
        }
    }
}

// MARK: - Int and Double Default implementations

struct DefaultIntStrategy: DefaultCodableStrategy {
    public static var defaultValue: Int { return 0 }
}

/// Decodes `Int` returning `0` instead of nil if applicable
typealias DefaultInt = DefaultCodable<DefaultIntStrategy>

struct DefaultDoubleStrategy: DefaultCodableStrategy {
    public static var defaultValue: Double { return 0.0 }
}

/// Decodes `Double` returning `0.0` instead of nil if applicable
typealias DefaultDouble = DefaultCodable<DefaultDoubleStrategy>

// MARK: - String Default implementation

struct DefaultStringStrategy: DefaultCodableStrategy {
    public static var defaultValue: String { return "" }
}

/// Decodes `String` returning an empty `String` instead of nil if applicable
typealias DefaultString = DefaultCodable<DefaultStringStrategy>

// MARK: -  Array Default implementation

struct DefaultEmptyArrayStrategy<T: Codable>: DefaultCodableStrategy {
    public static var defaultValue: [T] { return [] }
}

/// Decodes Arrays returning an empty array instead of nil if applicable
typealias DefaultEmptyArray<T> = DefaultCodable<DefaultEmptyArrayStrategy<T>> where T: Codable

// MARK: - Bool Default implementation

struct DefaultFalseStrategy: DefaultCodableStrategy {
    public static var defaultValue: Bool { return false }
}

/// Decodes Bools defaulting to `false` if applicable
typealias DefaultFalse = DefaultCodable<DefaultFalseStrategy>
