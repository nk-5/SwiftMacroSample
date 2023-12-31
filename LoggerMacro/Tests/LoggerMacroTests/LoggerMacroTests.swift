import SwiftSyntaxMacros
import SwiftSyntaxMacrosTestSupport
import XCTest

// Macro implementations build for the host, so the corresponding module is not available when cross-compiling. Cross-compiled tests may still make use of the macro itself in end-to-end tests.
#if canImport(LoggerMacroMacros)
import LoggerMacroMacros

let testMacros: [String: Macro.Type] = [
    "log": LoggerMacro.self,
]
#endif

final class LoggerMacroTests: XCTestCase {
    func testMacro() throws {
        #if canImport(LoggerMacroMacros)
        assertMacroExpansion(
            """
            #log(type: .debug)
            """,
            expandedSource: """
            Logger(subsystem: "", category: "").debug("hogehoge")
            """,
            macros: testMacros
        )
        #else
        throw XCTSkip("macros are only supported when running tests for the host platform")
        #endif
    }

    func testMacroWithStringLiteral() throws {
        #if canImport(LoggerMacroMacros)
        assertMacroExpansion(
            #"""
            #log("Hello, \(name)")
            """#,
            expandedSource: #"""
            ("Hello, \(name)", #""Hello, \(name)""#)
            """#,
            macros: testMacros
        )
        #else
        throw XCTSkip("macros are only supported when running tests for the host platform")
        #endif
    }
}
