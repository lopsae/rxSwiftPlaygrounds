

import PlaygroundSupport
import Foundation


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

