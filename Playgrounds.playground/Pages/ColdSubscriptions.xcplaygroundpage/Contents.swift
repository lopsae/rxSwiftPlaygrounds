

import PlaygroundSupport
import RxSwift
import RxSwiftPlaygrounds



Playarea.example("⭕️🍦 Single Serve Cold Observable") { p in
  p % "This cold observable works like a pasive factory, it will emit `🍦` only when subscribed"

  p < "⚙️ Creating 🍦 ColdServe observable"
  let coldServe = Observable<String>.create {
    observer in
    p < "🍦 ColdServe ⚡️ subscribed, serving!"
    observer.onNext("🍦")
    observer.onCompleted()
    return Disposables.create {
      p < "🍦 ColdServe 🗑 subscription disposed"
    }
  }

  p / "This subscription will create one serving"
  coldServe.subscribe(onNext: {
    p < "❇️ First: \($0)"
  })

  p / "This subscription will create another serving"
  coldServe.subscribe(onNext: {
    p < "✴️ Second: \($0)"
  })
}


Playarea.asyncExample("⭕️❄️ Interval Cold Observable") { p in
  let interval: TimeInterval = 2

  p % """
    An observable created with `interval` is also a cold observable"
    Elements are emitted and time is tracked independently for each subscription
    """

  p < "⚙️ Creating ❄️ ColdBeat interval observable"
  let coldBeat = Observable<Int>.interval(interval, scheduler: MainScheduler.instance)
    .take(3)
    .map { count in
      return Array(repeating: "❄️", count: count + 1).joined()
    }
    .do(onSubscribed: {
      p < "❄️ ColdBeat ⚡️ subscribed"
    })
    .do(onDispose: {
      p < "❄️ ColdBeat 🗑 disposed"
    })


  DispatchQueue.main.asyncAfter(deadline: .now()) {
    p / "This subscription will produce some elements"
    coldBeat.subscribe(onNext: {
      p < "❇️ \($0) First"
    })
  }

  DispatchQueue.main.asyncAfter(deadline: .now() + interval * 1.5) {
    p / "This subscription will produce new elements in its own independent timeline"
    coldBeat.subscribe(onNext: {
      p < "✴️ \($0) Delayed"
    })
  }
}


PlaygroundPage.current.needsIndefiniteExecution = true
Playarea.done👑()

