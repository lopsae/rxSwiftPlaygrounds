

public typealias Printer = (String) -> Void

public func example(_ title: String, closure: ((@escaping Printer) -> Void)) {
  let printer: Printer = { message in
    print("  \(message)")
  }

  print()
  print("⭕️ \(title)")
  closure(printer)
}

