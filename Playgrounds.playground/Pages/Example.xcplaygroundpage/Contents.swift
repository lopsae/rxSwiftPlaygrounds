

import PlaygroundSupport
import RxSwift
import RxSwiftPlaygrounds


Binder.example("⭕️ Simple example") { p in
  p % "This is just a simple example to play around"

  let just = Observable<String>.just("🧶")
  just.subscribe(onNext: {
    p < "❇️ First: \($0)"
  })
}


Binder.done👑()

