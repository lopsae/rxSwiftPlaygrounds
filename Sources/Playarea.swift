

import Foundation


// TODO: add documentation
public class Playarea {

  public static var rootPrinter = Printer(prefix: "")


  /// Prints a message using the `rootPrinter`.
  public static func print(_ message: String) {
    rootPrinter.print(message)
  }


  /// Prints a comment using the `rootPrinter`.
  public static func comment(_ message: String) {
    rootPrinter.comment(message)
  }


  public static func indent(prefix:String = Printer.defaultPrefix, closure: (Printer) -> Void) {
    let printer = Printer(prefix: prefix)
    closure(printer)
  }


  public static func example(_ title: String, closure: (Printer) -> Void) {
    Swift.print("\n\(title)")
    indent(closure: closure)
  }


  public static func asyncExample(_ title: String, closure: @escaping (Printer) -> Void) {
    DispatchQueue.main.asyncAfter(deadline: .now()) {
      example(title, closure: closure)
    }
  }

}


extension Playarea {

  // TODO: add documentation
  public class Printer {
    private typealias `Self` = Printer

    // TODO: rename to global?
    public static var printsComments = true
    public static let defaultPrefix = "  "

    private let parent: Printer?
    public let prefix: String
    public var instancePrintsComments: Bool? = nil


    public init(prefix: String = defaultPrefix, parent: Printer? = nil) {
      self.prefix = prefix
      self.parent = parent
    }


    public func print(_ message: String) {
      let output = prefix + message
      if let parent = parent {
        parent.print(output)
      } else {
        Swift.print(output)
      }
    }


    // TODO: what cases there are?
    // static printsComments
    // parent printsComments
    // instance printsComments
    public func comment(_ message: String) {
      guard instancePrintsComments ?? parent?.instancePrintsComments ?? Self.printsComments else {
        return
      }

      if let parent = parent {
        parent.comment(message, overridePrintsComment: instancePrintsComments)
      } else {
        print(message)
      }
    }


    private func comment(_ message: String, overridePrintsComment: Bool?) {
      guard overridePrintsComment ?? Self.printsComments else {
        return
      }

      if let parent = parent {
        parent.comment(message, overridePrintsComment: overridePrintsComment)
      } else {
        print(message)
      }

    }

  }

}

