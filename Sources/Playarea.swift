

import Foundation


// TODO: add documentation
public class Playarea {

  public static var rootPrinter = Printer(prefix: "")
  public static var defaultPrefix = "  "
  public static var printsComments = true {
    didSet {
      if !printsComments {
        rootPrinter.print("⚠️ global comment printing disabled")
      }
    }
  }


  /// Prints a message using the `rootPrinter`.
  public static func print(_ message: String) {
    rootPrinter.print(message)
  }


  /// Prints a comment using the `rootPrinter`.
  public static func comment(_ message: String) {
    rootPrinter.comment(message)
  }


  public static func indent(prefix:String = defaultPrefix, closure: (Printer) -> Void) {
    let printer = Printer(prefix: prefix, parent: rootPrinter)
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

    private let parent: Printer?
    public let prefix: String
    public let commentPrefix: String = "// "
    public var printsComments: Bool? = nil


    public init(prefix: String, parent: Printer? = nil) {
      self.prefix = prefix
      self.parent = parent
    }


    public func print(_ message: String) {
      if let parent = parent {
        parent.print(prefix + message)
      } else {
        Swift.print(prefix + message)
      }
    }


    public func comment(_ message: String) {
      guard printsComments ?? Playarea.printsComments else {
        return
      }

      print(message)
    }


    public static func / (printer: Printer, message: String) {
      let lines = message.split(separator: Character("\n"), omittingEmptySubsequences: false)
      lines.forEach {
        printer.comment(printer.commentPrefix + $0)
      }
    }

  }

}

