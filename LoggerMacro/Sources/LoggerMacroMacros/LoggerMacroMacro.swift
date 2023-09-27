import SwiftCompilerPlugin
import SwiftSyntax
import SwiftSyntaxBuilder
import SwiftSyntaxMacros
import OSLog

/// Implementation of the `stringify` macro, which takes an expression
/// of any type and produces a tuple containing the value of that expression
/// and the source code that produced the value. For example
///
public struct LoggerMacro: ExpressionMacro {
    public static func expansion(
        of node: some FreestandingMacroExpansionSyntax,
        in context: some MacroExpansionContext
    ) -> ExprSyntax {
        guard let category = node.argumentList.first(where: { $0.label?.text == "category" })?.expression,
                     let typeArg = node.argumentList.first(where: { $0.label?.text == "type" })?.expression,
                     let message = node.argumentList.first(where: { $0.label?.text == "message" })?.expression,
                     let handler = node.argumentList.first(where: { $0.label?.text == "actionHandler" })?.expression else {
//                   throw CustomError.message("Invalid arguments for logWithOSLogger macro.")
                    fatalError("compiler bug: the macro does not have any arguments")
               }

        return """
        {
          Logger(subsystem: "", category: \(category)).debug(\(message))
          (\(handler))()
        }()
        """
    }
}

@main
struct LoggerMacroPlugin: CompilerPlugin {
    let providingMacros: [Macro.Type] = [
        LoggerMacro.self,
    ]
}
