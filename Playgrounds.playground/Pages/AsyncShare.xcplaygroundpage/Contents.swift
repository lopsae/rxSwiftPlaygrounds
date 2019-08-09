

import PlaygroundSupport
import RxSwift
import RxSwiftPlaygrounds


// TODO: just trying a different name
typealias Binder = Playarea


Binder.asyncExample("⭕️⏰ Async Snooze Sharing") { p in
  let snoozeInterval: TimeInterval = 2

  p % """
    TODO: description
    """

  p < "⚙️ Creating ⏰ Snooze observable"
  let snooze = Observable<Int>.interval(snoozeInterval, scheduler: MainScheduler.instance)
    .take(3)
    .map { count in
      return Array(repeating: "⏰", count: count + 1).joined()
    }
    .do(onSubscribed: {
      p < "⏰ Snooze ⚡️ subscribed"
    })
    .do(onDispose: {
      p < "⏰ Snooze 🗑 disposed"
    })

  // Experiment with different sharing settings
//  let sharedSnooze = snooze.share(replay: 0, scope: .whileConnected)
//  let sharedSnooze = snooze.share(replay: 1, scope: .whileConnected)
//  let sharedSnooze = snooze.share(replay: 0, scope: .forever)
  let sharedSnooze = snooze.share(replay: 1, scope: .forever)

  DispatchQueue.main.asyncAfter(deadline: .now()) {
    p / "This subscription will start the snooze elements"
    sharedSnooze.subscribe(
      onNext: { p < "❇️ \($0) First" },
      onCompleted: { p < "❇️ ❌ Completed" })
  }

  DispatchQueue.main.asyncAfter(deadline: .now() + interval * 2.5) {
    p / "This subscription will connect after two element has been emitted"
    sharedSnooze.subscribe(
      onNext: { p < "✴️ \($0) Delayed" },
      onCompleted: { p < "✴️ ❌ Completed" })
  }

  DispatchQueue.main.asyncAfter(deadline: .now() + interval * 3.5) {
    p / "This subscription will connect after all elements have been emited"
    sharedSnooze.subscribe(
      onNext: { p < "⚛️ \($0) Afterwards" },
      onCompleted: { p < "⚛️ ❌ Completed" })
  }
}


PlaygroundPage.current.needsIndefiniteExecution = true
Binder.done👑()

