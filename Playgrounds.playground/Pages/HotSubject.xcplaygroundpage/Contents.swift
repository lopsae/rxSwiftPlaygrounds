

import PlaygroundSupport
import RxSwift
import RxSwiftPlaygrounds


let subject = PublishSubject<String>()
let broadcast = Binder.indent { p in
  return subject.do(
    onNext:       { p < "📺 Broadcast 📦 emiting: \($0)" },
    onCompleted:  { p < "📺 Broadcast ❌ completed" },
    onSubscribed: { p < "📺 Broadcast ⚡️ subscribed" },
    onDispose:    { p < "📺 Broadcast 🗑 disposed" })
}


Binder.example("⭕️ example") { p in
  // sports: 🏃🏾‍♀️🏂🤸🏻‍♂️⛹🏿‍♀️🧘🏽‍♂️🏊🏼‍♀️🚴🏽‍♀️
  subject.onNext("🏃🏾‍♀️")

  broadcast.subscribe(
    onNext:      { p < "❇️ First: \($0)"},
    onCompleted: { p < "❇️ First ❌ completed"},
    onDisposed:  { p < "❇️ First 🗑 disposed"})

  subject.onNext("🏂")

  var disposeBag = DisposeBag()
  broadcast.subscribe(
    onNext:      { p < "✴️ Second: \($0)"},
    onCompleted: { p < "✴️ Second ❌ completed"},
    onDisposed:  { p < "✴️ Second 🗑 disposed"}
  ).disposed(by: disposeBag)

  subject.onNext("⛹🏿‍♀️")

  disposeBag = DisposeBag()

  subject.onNext("🧘🏽‍♂️")

  p < "is disposed: \(subject.isDisposed)"

  subject.onCompleted()

  p < "is disposed: \(subject.isDisposed)"

  broadcast.subscribe(
    onNext:      { p < "⚛️ Third: \($0)"},
    onCompleted: { p < "⚛️ Third ❌ completed"},
    onDisposed:  { p < "⚛️ Third 🗑 disposed"})

  // Ignored?
  subject.onNext("🚫")
  subject.onCompleted()
  subject.onError(RxError.unknown)

  subject.dispose()

  p < "is disposed: \(subject.isDisposed)"

  broadcast.subscribe(
    onNext:      { p < "*️⃣ Last: \($0)"},
    onCompleted: { p < "*️⃣ Last ❌ completed"},
    onDisposed:  { p < "*️⃣ Last 🗑 disposed"})

}


Binder.done👑()

