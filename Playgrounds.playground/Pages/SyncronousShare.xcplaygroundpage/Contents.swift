

import PlaygroundSupport
import RxSwift
import RxSwiftPlaygrounds


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


Binder.example("⭕️*️⃣ While-connected Sharing") { p in
  p % """
    Share with defaults has zero replays and a `.whileConnected` lifetime
    This example will behave the same with any amount of `replay`
    """
  let sharedChef = chef.share(replay: 0, scope: .whileConnected) // same as share()
    .do(onDispose: { p < "🗑 Share disposed" })

  p / "First subscription will receive all elements"
  sharedChef.subscribe(onNext: {
    p < "❇️ First: \($0)"
  })

  p % """
    The first subscription completes immediately because `chef` is synchronous
    The share resets after the completed subscription since `.whileConnected` is used
    When the share resets all elements to replay are also removed
    """

  p / "Second subscription will receive all new elements"
  sharedChef.subscribe(onNext: {
    p < "✴️ Second: \($0)"
  })
}


Binder.example("⭕️🎦 Forever & Replay Sharing") { p in
  p % """
    Share with replays and a `.forever` lifetime
    Second subscription will receive elements depending on `replay`
    """
  let sharedChef = chef.share(replay: 2, scope: .forever)
    .do(onDispose: { p < "🗑 Share disposed" })

  p / "First subscription will receive all elements"
  sharedChef.subscribe(onNext: {
    p < "❇️ First: \($0)"
  })

  p % """
    The share does not reset after the subscription completes since `.forever` is used
    The share will neither connect again to 👩🏽‍🍳 Chef when reconnected
    """

  p / "Second subscription receives as many elements as configured in `replay`"
  sharedChef.subscribe(onNext: {
    print("✴️ Second: \($0)")
  })
}


Binder.done👑()

