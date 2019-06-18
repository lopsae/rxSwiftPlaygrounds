

import PlaygroundSupport
import RxSwift
import RxSwiftPlaygrounds


PlaygroundPage.current.needsIndefiniteExecution = true

print("⭕️ Single Serve Cold Observable")

// This cold observable is like a pasive factory that will create
// 🍦 only until connected.
let coldServe = Observable<String>.create {
  observer in
  print("🍦ColdCream ⚡️Connected, serving!")
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

// The interval for this cold observable will only start until connected
let coldBeat = Observable<Int>.interval(1, scheduler: MainScheduler.instance)
.do(onSubscribed: {
  print("❄️ColdBeat: ⚡️connected")
})
.do(onDispose: {
  print("❄️ColdBeat: 🚮disposed")
})


DispatchQueue.main.asyncAfter(deadline: .now()) {
  // This connection will produce some elements
  coldBeat.take(2).subscribe(onNext: {
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

