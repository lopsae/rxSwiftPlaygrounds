

import PlaygroundSupport
import RxSwift
import RxSwiftPlaygrounds


// TODO: just trying a different name
typealias Binder = Playarea


let dishes = ["🍕", "🥗", "🍣", "🌮", "🌯", "🍜"]
Binder.root % """
  The 👩🏽‍🍳 Chef observable will emit upon subscription three random dishes
  Elements are emmited immediately and syncronously
  Possible dishes are: \(dishes)
  """

Binder.root < "⚙️ Creating 👩🏽‍🍳 Chef observable"
var chef: Observable<String>!
Binder.indent { p in
  chef = Observable<String>.create {
    observer in
    p < "👩🏽‍🍳 Chef ⚡️ subscribed, cooking!"
    for _ in 0...2 {
      let serving = dishes.randomElement()!
      observer.onNext(serving)
    }
    observer.onCompleted()
    return Disposables.create {
      p < "👩🏽‍🍳 Chef 🗑 subscription disposed"
    }
  }
}
Binder.newLine()


Binder.example("⭕️*️⃣ Default Sharing") { p in
  p % "Share with defaults has zero replays and a `.whileConnected` lifetime"
  let sharedChef = chef.share()
    .do(onDispose: { p < "🗑 Share disposed" })

  p / "First subscription will receive all elements"
  sharedChef.subscribe(onNext: {
    p < "❇️ First: \($0)"
  })

  p % """
    The first subscription completes immediately because `chef` is synchronous
    The share resets after the completed subscription since `.whileConnected` is used
    """

  p / "Second subscription will receive all new elements"
  sharedChef.subscribe(onNext: {
    p < "✴️ Second: \($0)"
  })
}


Binder.example("⭕️⏺ Sharing Forever") { p in
  p % "Share with zero replays and a `.forever` lifetime"
  let sharedChef = chef.share(scope: .forever)
    .do(onDispose: { p < "🗑 Share disposed" })

  p / "First subscription will receive all elements"
  sharedChef.subscribe(onNext: {
    p < "❇️ First: \($0)"
  })

  p % """
    The share does not reset after the subscription completes since `.forever` is used
    The share will neither connect again to 👩🏽‍🍳 Chef when reconnected
    """

  p / "Second subscription receives no elements since there is no replay"
  sharedChef.subscribe(onNext: {
    print("✴️ Second: \($0)")
  })
}


Binder.example("⭕️🎦 Forever & Replay Sharing") { p in
  p % "Share with two replays and a `.forever` lifetime"
  let sharedChef = chef.share(replay: 2, scope: .forever)
    .do(onDispose: { p < "🗑 Share disposed" })

  p / "First subscription will receive all elements"
  sharedChef.subscribe(onNext: {
    p < "❇️ First: \($0)"
  })

  p % """
  Since `.forever` is used the share will not reset nor reconnect to 👩🏽‍🍳 Chef
  With the `replay` the next connection will receive the last elements emitted
  """

  p / "Second subscription will receive some replayed elements"
  sharedChef.subscribe(onNext: {
    p < "✴️ Second: \($0)"
  })
}


example("⭕️⏏️ While-connected & Replay Sharing") { print in
  let sharedChef = chef.share(replay: 1, scope: .whileConnected)

  sharedChef.subscribe(onNext: {
    print("❇️ First: \($0)")
  })

  sharedChef.subscribe(onNext: {
    print("✴️ Second: \($0)")
  })
}


example("⭕️ Two subscriptions without sharing") { print in
  // different behaviours with foerever or whileConnected
  let sharedChef = chef.share(scope: .forever)

  let delayed = Observable.just("⏱").delay(0.5, scheduler: MainScheduler.instance)
  let untilDishes = delayed.takeUntil(sharedChef)
  // different behaviours with different order
  let merged = Observable.merge(untilDishes, sharedChef)

  merged.subscribe(onNext: {
    print("🔽 Merge: \($0)")
  })
}

Binder.done👑()

