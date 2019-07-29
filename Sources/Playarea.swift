

import Foundation


// TODO: add documentation
public class Playarea {

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

    public static var printsComments = true
    public static let defaultPrefix = "  "

    public let prefix: String
    public var instancePrintsComments: Bool? = nil


    public init(prefix: String = defaultPrefix) {
      self.prefix = prefix
    }


    public func print(_ message: String) {
      Swift.print(prefix + message)
    }


    public func comment(_ message: String) {
      guard instancePrintsComments ?? Self.printsComments else {
        return
      }

      print(message)
    }

  }

}

