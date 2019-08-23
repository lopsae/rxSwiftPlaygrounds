

import PlaygroundSupport
import RxSwift
import RxSwiftPlaygrounds


Binder.root % """
  The 📺 Broadcast subject and observable is a simple publish subject that
  will print most observable interactions as to see how the subject behaves.
  """

Binder.root < "⚙️ Creating 📺 Broadcast subject & observable"
let subject = PublishSubject<String>()
let broadcast = Binder.indent { p in
  return subject.do(
    onNext:       { p < "📺 Broadcast 📦 emiting: \($0)" },
    onCompleted:  { p < "📺 Broadcast ❌ completed" },
    onSubscribed: { p < "📺 Broadcast ⚡️ subscribed" },
    onDispose:    { p < "📺 Broadcast 🗑 disposed" })
}
Binder.root.newLine()


Binder.example("⭕️ Before & First subscription") { p in
  p < "Emitting ⚽️ before any subscriptions"
  subject.onNext("⚽️")

  p % "Before any subscription the element is just a no-op"

  p < "Subscribing ❇️ First"
  broadcast.subscribe(
    onNext:      { p < "❇️ First \($0) received"},
    onCompleted: { p < "❇️ First ❌ completed"},
    onDisposed:  { p < "❇️ First 🗑 disposed"})

  p < "Emitting 🏀"
  subject.onNext("🏀")

  p / "The ❇️ First subscription will remain in place for the rest of examples"
}


Binder.example("⭕️ Disposing a subscription") { p in
  p % """
    For the ✴️ Second subscription a reference to the disposable is kept in
    a DisposeBag
    """

  p < "Subscribing ✴️ Second"
  var disposeBag = DisposeBag()
  broadcast.subscribe(
    onNext:      { p < "✴️ Second \($0) received"},
    onCompleted: { p < "✴️ Second ❌ completed"},
    onDisposed:  { p < "✴️ Second 🗑 disposed"}
  ).disposed(by: disposeBag)

  p < "Emitting ⚾️"
  subject.onNext("⚾️")

  p % "Now both subscription receive elements"

  p < "Disposing ✴️ Second subscription"
  disposeBag = DisposeBag()

  p / "Emitting 🏈"
  subject.onNext("🏈")

  p / "Only ❇️ First receives elements now, after disposing of ✴️ Second "
}


Binder.example("⭕️ Completing the subject") { p in
  p % "Completing the subject will complete all existing subscriptions"

  p < "Completing subject"
  subject.onCompleted()

  p % """
    It is still possible to subscribe after completion, new subscriptions
    New subscriptions will immediately received a completed event
    """

  p < "Subscribing ⚛️ Third after completion"
  broadcast.subscribe(
    onNext:      { p < "⚛️ Third \($0) received"},
    onCompleted: { p < "⚛️ Third ❌ completed"},
    onDisposed:  { p < "⚛️ Third 🗑 disposed"})


  p % "After completion any other emitted events become no-ops"
  subject.onNext("🚫")
  subject.onCompleted()
  subject.onError(RxError.unknown)
}


Binder.example("⭕️ Disposing") { p in
  p % "Disposing a subject will release all its resources"

  p < "Disposing subject"
  subject.dispose()

  p < "Subscribing *️⃣ Last after disposal"
  broadcast.subscribe(
    onNext:      { p < "*️⃣ Last: \($0)"},
    onCompleted: { p < "*️⃣ Last ❌ completed"},
    onDisposed:  { p < "*️⃣ Last 🗑 disposed"})

  p / "Trying to subscribe will still deliver a disposed event along with an error"
}


Binder.done👑()

