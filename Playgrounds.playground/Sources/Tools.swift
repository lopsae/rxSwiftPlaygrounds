

import PlaygroundSupport


public typealias PrintClosure = (String) -> Void

public func example(_ title: String, closure: ((@escaping PrintClosure) -> Void)) {
  // TODO: make indentation configurable
  let printer: PrintClosure = { message in
    print("  \(message)")
  }

  print("\n\(title)")
  closure(printer)
}


public func done👑() {
  print("👑 done executing playground code ~finis coronat opus")
  if PlaygroundPage.current.needsIndefiniteExecution {
    print ("🔄 but running indefinitely")
  }
}

