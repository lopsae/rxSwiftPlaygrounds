

import PlaygroundSupport
import RxSwift
import RxSwiftPlaygrounds


// TODO: just trying a different name
typealias Binder = Playarea


let subject = PublishSubject<String>()
let broadcast = Binder.indent { p in
  return subject
    .do(onSubscribed: { p < "📺 Broadcast ⚡️ subscribed" } )
    .do(onNext:       { p < "📺 Broadcast 📦 emiting: \($0)" } )
    .do(onCompleted:  { p < "📺 Broadcast ❌ completed" } )
    .do(onDispose:    { p < "📺 Broadcast 🗑 disposed" } )
}


Binder.example("⭕️ example") { p in
  // sports: 🏃🏾‍♀️🏂🤸🏻‍♂️⛹🏿‍♀️🧘🏽‍♂️🏊🏼‍♀️🚴🏽‍♀️
  subject.onNext("🏃🏾‍♀️")
  subject.onNext("🏂")

  broadcast.subscribe(
    onNext:      { p < "❇️ First: \($0)"},
    onCompleted: { p < "❇️ First ❌ completed"},
    onDisposed:  { p < "❇️ First 🗑 disposed"})

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
    onNext:      { p < "⚛️ Last: \($0)"},
    onCompleted: { p < "⚛️ Last ❌ completed"},
    onDisposed:  { p < "⚛️ Last 🗑 disposed"})

  // Ignored
  subject.onNext("🚫")

  subject.dispose()

  p < "is disposed: \(subject.isDisposed)"

  broadcast.subscribe(
    onNext:      { p < "⚛️ Last: \($0)"},
    onCompleted: { p < "⚛️ Last ❌ completed"},
    onDisposed:  { p < "⚛️ Last 🗑 disposed"})

}


PlaygroundPage.current.needsIndefiniteExecution = true
Binder.done👑()

