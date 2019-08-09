

import PlaygroundSupport
import RxSwift
import RxSwiftPlaygrounds


// TODO: just trying a different name
typealias Binder = Playarea


Binder.asyncExample("⭕️⏰ Async Snooze Sharing") { p in
  let snoozeInterval: TimeInterval = 2
  let snoozeElements = 3

  p % """
    The ⏰ Snooze observable will emit a number of "⏰" with a pause between each
    """

  p < "⚙️ Creating ⏰ Snooze observable"
  let snooze = Observable<Int>.interval(snoozeInterval, scheduler: MainScheduler.instance)
    .take(snoozeElements)
    .map { count in
      return Array(repeating: "⏰", count: count + 1).joined()
    }
    .do(onSubscribed: {
      p < "⏰ Snooze ⚡️ subscribed"
    })
    .do(onDispose: {
      p < "⏰ Snooze 🗑 disposed"
    })
  p.newLine()

  let snoozeReplay = 1
  let snoozeScope:SubjectLifetimeScope = .whileConnected
  p % """
    Different settings will change the elements delivered to each subscription
    Try different values to see how share behaves and where connections and diposals occurr
    The ⏰ Snooze observable is shared with
    replay: \(snoozeReplay)
    scope:  \(snoozeScope)
    """
  let sharedSnooze = snooze.share(replay: snoozeReplay, scope: snoozeScope)

  DispatchQueue.main.asyncAfter(deadline: .now()) {
    p / "This subscription will start the snooze elements"
    sharedSnooze.subscribe(
      onNext: { p < "❇️ \($0) First" },
      onCompleted: { p < "❇️ ❌ Completed" })
  }

  DispatchQueue.main.asyncAfter(deadline: .now() + snoozeInterval * 2.5) {
    p / "This subscription will connect after two element has been emitted"
    sharedSnooze.subscribe(
      onNext: { p < "✴️ \($0) Delayed" },
      onCompleted: { p < "✴️ ❌ Completed" })
  }

  DispatchQueue.main.asyncAfter(deadline: .now() + snoozeInterval * 3.5) {
    p / "This subscription will connect after all elements have been emited"
    sharedSnooze.subscribe(
      onNext: { p < "⚛️ \($0) Afterwards" },
      onCompleted: { p < "⚛️ ❌ Completed" })
  }
}


PlaygroundPage.current.needsIndefiniteExecution = true
Binder.done👑()

