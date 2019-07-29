

import RxSwift
import RxSwiftPlaygrounds
import PlaygroundSupport


example("⭕️ Single Serve Cold Observable") { print in
  print("// This cold observable works like a pasive factory, it will emit '🍦' only when connected")

  print("🍦 Creating ColdServe observable")
  let coldServe = Observable<String>.create {
    observer in
    print("🍦 ColdServe ⚡️ connected, serving!")
    observer.onNext("🍦")
    observer.onCompleted()
    return Disposables.create()
  }

  print("// This subscription will create one serving")
  coldServe.subscribe(onNext: {
    print("❇️ First: \($0)")
  })

  print("// This subscription will create another serving")
  coldServe.subscribe(onNext: {
    print("✴️ Second: \($0)")
  })
}


asyncExample("⭕️ Interval Cold Observable") { print in
  let interval: TimeInterval = 2

  print("// An observable created with `interval` is also a cold observable")
  print("// Elements are emitted and time counted independently for each connection")

  print("❄️ Creating ColdBeat interval observable")
  let coldBeat = Observable<Int>.interval(interval, scheduler: MainScheduler.instance)
    .do(onSubscribed: {
      print("❄️ ColdBeat: ⚡️ connected")
    })
    .do(onDispose: {
      print("❄️ ColdBeat: 🗑 disposed")
    })


  DispatchQueue.main.asyncAfter(deadline: .now()) {
    print("// This connection will produce some elements")
    coldBeat.take(3).subscribe(onNext: {
      print("❇️ First: \($0)")
    })
  }

  DispatchQueue.main.asyncAfter(deadline: .now() + interval * 1.5) {
    print("// This connection will produce new elements in its own independent timeline")
    coldBeat.take(3).subscribe(onNext: {
      print("✴️ Delayed: \($0)")
    })
  }
}


PlaygroundPage.current.needsIndefiniteExecution = true
done👑()

