

import PlaygroundSupport
import RxSwiftPlaygrounds


extension Playarea {

  /// Prints a friendly done-executing-code message along some additional
  /// playground configurations.
  ///
  /// Use at the end of a playground to be certain all code was run successfully.
  public static func done👑() {
    print("") // newline
    print("⚠️ Done executing playground code ~finis coronat opus 👑")
    if PlaygroundPage.current.needsIndefiniteExecution {
      print ("🔄 Playground thread running indefinitely")
    }
  }

}

