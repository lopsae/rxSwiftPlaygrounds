

import PlaygroundSupport


public typealias PrintClosure = (String) -> Void

public func example(_ title: String, closure: ((@escaping PrintClosure) -> Void)) {
  // TODO: make indentation configurable
  let printer: PrintClosure = { message in
    print("  \(message)")
  }

  print() // Separation line
  print(title)
  closure(printer)
}


public func done👑(continueExecution: Bool = false) {
  print("👑 finis coronat opus~ (done executing playground)", terminator: "")
  if continueExecution {
    PlaygroundPage.current.needsIndefiniteExecution = true
    print (" 🔄(but still running)")
  } else {
    print(" 🛑")
  }

}

