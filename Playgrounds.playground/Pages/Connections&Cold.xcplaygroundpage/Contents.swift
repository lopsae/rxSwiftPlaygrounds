

import PlaygroundSupport
import RxSwift
import RxSwiftPlaygrounds


PlaygroundPage.current.needsIndefiniteExecution = true

print("⭕️ Single Serve Cold Observable")

// This cold observable is a pasive factory that will create a "🍦" only until
// connected.
let coldServe = Observable<String>.create {
  observer in
  print("🍦ColdServe ⚡️Connected, serving!")
  observer.onNext("🍦")
  observer.onCompleted()
  return Disposables.create()
}

// This will create one serving
coldServe.subscribe(onNext: {
  print("1️⃣One: \($0)")
})

// This will create another serving
coldServe.subscribe(onNext: {
  print("2️⃣Two: \($0)")
})


print("⭕️ Interval Cold Observable")

// The observable created with `interval` is also a cold observable. Elements
// are emitted and time counted only until there is a connection, and for
// every individual connection.
let coldBeat = Observable<Int>.interval(1, scheduler: MainScheduler.instance)
.do(onSubscribed: {
  print("❄️ColdBeat: ⚡️connected")
})
.do(onDispose: {
  print("❄️ColdBeat: 🚮disposed")
})


DispatchQueue.main.asyncAfter(deadline: .now()) {
  // This connection will produce some elements
  coldBeat.take(3).subscribe(onNext: {
    print("✳️Observer: \($0)")
  })
}

DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
  // This connection will produce its own elements
  coldBeat.take(3).subscribe(onNext: {
    print("✴️Observer: \($0)")
  })
}


print("👑 finis coronat opus~ (but still running)")
