

import RxSwift
import RxSwiftPlaygrounds
import PlaygroundSupport


example("⭕️ Single Serve Cold Observable") { print in
  // This cold observable is a pasive factory that will create a "🍦" only until
  // connected.
  let coldServe = Observable<String>.create {
    observer in
    print("🍦 ColdServe ⚡️ Connected, serving!")
    observer.onNext("🍦")
    observer.onCompleted()
    return Disposables.create()
  }

  // This will create one serving
  coldServe.subscribe(onNext: {
    print("1️⃣ One: \($0)")
  })

  // This will create another serving
  coldServe.subscribe(onNext: {
    print("2️⃣ Two: \($0)")
  })
}


example("⭕️ Interval Cold Observable") { print in
  let interval: TimeInterval = 2

  // The observable created with `interval` is also a cold observable. Elements
  // are emitted and time counted only until there is a connection, and for
  // every individual connection.
  let coldBeat = Observable<Int>.interval(interval, scheduler: MainScheduler.instance)
    .do(onSubscribed: {
      print("❄️ ColdBeat: ⚡️ connected")
    })
    .do(onDispose: {
      print("❄️ ColdBeat: 🚮 disposed")
    })


  DispatchQueue.main.asyncAfter(deadline: .now()) {
    // This connection will produce some elements
    coldBeat.take(3).subscribe(onNext: {
      print("✳️ Observer: \($0)")
    })
  }

  DispatchQueue.main.asyncAfter(deadline: .now() + interval * 1.5) {
    // This connection will produce new elements in its own independent timeline
    coldBeat.take(3).subscribe(onNext: {
      print("✴️ Observer: \($0)")
    })
  }
}


PlaygroundPage.current.needsIndefiniteExecution = true
done👑()

