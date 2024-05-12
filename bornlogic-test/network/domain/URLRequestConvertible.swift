//
//  URLRequestConvertible.swift
//  bornlogic-test
//
//  Created by João Gabriel Dourado Cervo on 12/05/24.
//

import Foundation

/// Represents a type that can be converted to `URLRequest` type
protocol URLRequestConvertible {
    func asURLRequest() throws -> URLRequest
}

/// Possible error cases when converting to `URLRequest`
enum URLRequestConvertibleError: Error {
    case routerConversionError
}
