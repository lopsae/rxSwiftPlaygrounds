

import PlaygroundSupport
import RxSwift
import RxSwiftPlaygrounds


// TODO: add script to display TODO's as warnings
// TODO: add static functions for print and comment
Playarea.rootPrinter.comment("// The 👩🏽‍🍳 Chef observable will emit upon subscription four random dishes")
Playarea.rootPrinter.comment("// Elements are emmited immediately and syncronously")
let dishes = ["🍕", "🥗", "🍣", "🌮"]
Playarea.rootPrinter.comment("// Dishes: \(dishes)")

Playarea.rootPrinter.print("⚙️ Creating 👩🏽‍🍳 Chef observable")
var chef: Observable<String>!
Playarea.indent { p in
  chef = Observable<String>.create {
    observer in
    p.print("👩🏽‍🍳 Chef ⚡️ subscribed, cooking!")
    for _ in 0...3 {
      let serving = dishes.randomElement()!
      observer.onNext(serving)
    }
    observer.onCompleted()
    return Disposables.create {
      p.print("👩🏽‍🍳 Chef 🗑 disposed")
    }
  }
}


Playarea.example("⭕️ Default Sharing") { p in
  p.comment("// Share by default has zero replays and a `.whileConnected` lifetime")
  let sharedChef = chef.share()

  p.comment("// First subscription will receive all elements")
  sharedChef.subscribe(onNext: {
    p.print("❇️ First: \($0)")
  })

  p.comment("// The first subscription completes immediately because `chef` is synchronous")
  p.comment("// The share resets after the subscription completes since `.whileConnected` is used")

  p.comment("// Second subscription will receive all new elements")
  sharedChef.subscribe(onNext: {
    p.print("✴️ Second: \($0)")
  })
}


example("⭕️ Sharing Forever") { print in
  let sharedChef = chef.share(scope: .forever)

  sharedChef.subscribe(onNext: {
    print("❇️ First: \($0)")
  })

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

done👑()

