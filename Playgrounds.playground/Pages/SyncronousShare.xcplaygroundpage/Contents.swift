

import PlaygroundSupport
import RxSwift
import RxSwiftPlaygrounds


let dishes = ["🍕", "🥗", "🍣", "🌮"]
Playarea.root / """
  The 👩🏽‍🍳 Chef observable will emit upon subscription four random dishes
  Elements are emmited immediately and syncronously
  Possible dishes are: \(dishes)
  """
Playarea.newLine()

Playarea.root < "⚙️ Creating 👩🏽‍🍳 Chef observable"
var chef: Observable<String>!
Playarea.indent { p in
  chef = Observable<String>.create {
    observer in
    p < "👩🏽‍🍳 Chef ⚡️ subscribed, cooking!"
    for _ in 0...3 {
      let serving = dishes.randomElement()!
      observer.onNext(serving)
    }
    observer.onCompleted()
    return Disposables.create {
      p < "👩🏽‍🍳 Chef 🗑 subscription disposed"
    }
  }
}
Playarea.newLine()


Playarea.example("⭕️ Default Sharing") { p in
  p / "Share with defaults has zero replays and a `.whileConnected` lifetime"
  let sharedChef = chef.share()
    .do(onDispose: { p < "🗑 Share disposed" })
  p.newLine()

  p / "First subscription will receive all elements"
  sharedChef.subscribe(onNext: {
    p < "❇️ First: \($0)"
  })

  p / """
    The first subscription completes immediately because `chef` is synchronous
    The share resets after the completed subscription since `.whileConnected` is used
    """
  p.newLine()

  p / "Second subscription will receive all new elements"
  sharedChef.subscribe(onNext: {
    p < "✴️ Second: \($0)"
  })
}


Playarea.example("⭕️ Sharing Forever") { p in
  p / "Share with zero replays and a `.forever` lifetime"
  let sharedChef = chef.share(scope: .forever)
    .do(onDispose: { p < "🗑 Share disposed" })
  p.newLine()

  p / "First subscription will receive all elements"
  sharedChef.subscribe(onNext: {
    p < "❇️ First: \($0)"
  })

  p / """
    The share does not reset after the subscription completes since `.forever` is used
    The share will neither connect again to 👩🏽‍🍳 Chef when reconnected.
    """
  p.newLine()

  p < "Second subscription receives no elements since there is no replay"
  sharedChef.subscribe(onNext: {
    print("✴️ Second: \($0)")
  })
}


example("⭕️ Forever & Replay Sharing") { print in
  let sharedChef = chef.share(replay: 100, scope: .forever)

  sharedChef.subscribe(onNext: {
    print("❇️ First: \($0)")
  })

  sharedChef.subscribe(onNext: {
    print("✴️ Second: \($0)")
  })
}


example("⭕️ While-connected & Replay Sharing") { print in
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

Playarea.done👑()

