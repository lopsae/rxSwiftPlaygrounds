

import PlaygroundSupport
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


public typealias PrintClosure = (String) -> Void


/// Creates a closure with a `print` function and the given `prefix` as
/// indentation.
public func indent(prefix:String = "  ", closure: ((@escaping PrintClosure) -> Void)) {
  let printer: PrintClosure = { message in
    print("  \(message)")
  }

  closure(printer)
}


/// Prints the given `title` and creates a closure with a `print` function
/// using the default indentation.
public func example(_ title: String, closure: ((@escaping PrintClosure) -> Void)) {
  print("\n\(title)")
  indent(closure: closure)
}


/// Prints the given `title` and creates a closure with a `print` function
/// using the default indentation.
public func asyncExample(_ title: String, closure: @escaping ((@escaping PrintClosure) -> Void)) {
  DispatchQueue.main.asyncAfter(deadline: .now()) {
    example(title, closure: closure)
  }
}


public func done👑() {
  print("\n⚠️ Done executing playground code ~finis coronat opus 👑")
  if PlaygroundPage.current.needsIndefiniteExecution {
    print ("🔄 Playground thread running indefinitely")
  }
}

