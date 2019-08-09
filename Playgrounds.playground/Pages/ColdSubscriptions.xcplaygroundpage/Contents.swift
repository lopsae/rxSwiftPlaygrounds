

import PlaygroundSupport
import RxSwift
import RxSwiftPlaygrounds



Playarea.example("⭕️🍦 Single Serve Cold Observable") { p in
  p % """
    The 🍦 ColdServe observable is a cold observable
    It works like a pasive factory: it will emit a sigle `🍦` only when subscribed
    """

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
  let coldInterval: TimeInterval = 2
  let coldElements = 3

  p % """
    The ❄️ ColdBeat observable is created with `interval` which is also a cold observable
    When subscribed an increasing number of "❄️" will be emitted with a pause between each
    Emitted elements and time tracking is independent for each subscription
    """

  p < "⚙️ Creating ❄️ ColdBeat interval observable"
  let coldBeat = Observable<Int>.interval(coldInterval, scheduler: MainScheduler.instance)
    .take(coldElements)
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

  // 1.5 will connect between the first and second element
  DispatchQueue.main.asyncAfter(deadline: .now() + coldInterval * 1.5) {
    p / "This subscription will produce new elements in its own independent timeline"
    coldBeat.subscribe(onNext: {
      p < "✴️ \($0) Delayed"
    })
  }
}


PlaygroundPage.current.needsIndefiniteExecution = true
Playarea.done👑()

