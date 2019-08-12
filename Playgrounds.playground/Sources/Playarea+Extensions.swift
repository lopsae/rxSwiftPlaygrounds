

import PlaygroundSupport
import RxSwiftPlaygrounds


extension Playarea {

  /// Prints a friendly done-executing-code message along some additional
  /// playground configurations.
  ///
  /// Use at the end of a playground to be certain all code was run successfully.
  public static func done👑(needsIndefiniteExecution: Bool? = nil) {
    if let needsIndefiniteExecution = needsIndefiniteExecution {
      PlaygroundPage.current.needsIndefiniteExecution = needsIndefiniteExecution
    }

    root < "👑 Done executing playground code ~finis coronat opus"
    if PlaygroundPage.current.needsIndefiniteExecution {
      root < "🔄 Playground thread running indefinitely"
    }
    root.newLine()
  }

}

