

import RxSwift
import RxSwiftPlaygrounds
import PlaygroundSupport


Playarea.example("⭕️ Single Serve Cold Observable") { p in
  p.comment("// This cold observable works like a pasive factory, it will emit '🍦' only when connected")

  p.print("🍦 Creating ColdServe observable")
  let coldServe = Observable<String>.create {
    observer in
    p.print("🍦 ColdServe ⚡️ connected, serving!")
    observer.onNext("🍦")
    observer.onCompleted()
    return Disposables.create()
  }

  p.comment("// This subscription will create one serving")
  coldServe.subscribe(onNext: {
    p.print("❇️ First: \($0)")
  })

  p.comment("// This subscription will create another serving")
  coldServe.subscribe(onNext: {
    p.print("✴️ Second: \($0)")
  })
}


Playarea.asyncExample("⭕️ Interval Cold Observable") { p in
  let interval: TimeInterval = 2

  p.comment("// An observable created with `interval` is also a cold observable")
  p.comment("// Elements are emitted and time counted independently for each connection")

  p.print("❄️ Creating ColdBeat interval observable")
  let coldBeat = Observable<Int>.interval(interval, scheduler: MainScheduler.instance)
    .do(onSubscribed: {
      p.print("❄️ ColdBeat: ⚡️ connected")
    })
    .do(onDispose: {
      p.print("❄️ ColdBeat: 🗑 disposed")
    })


  DispatchQueue.main.asyncAfter(deadline: .now()) {
    p.comment("// This connection will produce some elements")
    coldBeat.take(3).subscribe(onNext: {
      p.print("❇️ First: \($0)")
    })
  }

  DispatchQueue.main.asyncAfter(deadline: .now() + interval * 1.5) {
    p.comment("// This connection will produce new elements in its own independent timeline")
    coldBeat.take(3).subscribe(onNext: {
      p.print("✴️ Delayed: \($0)")
    })
  }
}


PlaygroundPage.current.needsIndefiniteExecution = true
done👑()

