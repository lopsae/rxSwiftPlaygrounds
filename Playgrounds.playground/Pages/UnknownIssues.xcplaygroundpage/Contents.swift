

import PlaygroundSupport
import RxSwift
import RxSwiftPlaygrounds


// TODO: just trying a different name
typealias Binder = Playarea


Binder.example("⭕️ startWith vs from") { p in
  let subject = PublishSubject<String>()
  var disposable = Disposables.create()

  let justAndStart = subject.flatMap {
    string -> Observable<String> in
    switch string {
    case "one":
      return Observable.just("first").startWith("prefix")
    case "two":
      return .just("second")
    default:
      return .error(RxError.unknown)
    }
  }

  disposable = justAndStart.subscribe(
    onNext: { p < "justAndStart: \($0)" })
  subject.onNext("one")
  subject.onNext("two")
  disposable.dispose()


  let fromAndJust = subject.flatMap {
    string -> Observable<String> in
    switch string {
    case "one":
      return Observable.from(["prefix", "first"])
    case "two":
      return .just("second")
    default:
      return .error(RxError.unknown)
    }
  }

  disposable = fromAndJust.subscribe(
    onNext: { p < "fromAndJust: \($0)" })
  subject.onNext("one")
  subject.onNext("two")
  disposable.dispose()

}


//flatmap
//  + just(first).startWith(prefix)
//  + just(second)
//  -> prefix first second
//
//flatmap
//  + from(prefix, first)
//  + just(second)
//  -> prefix second first


Binder.done👑(needsIndefiniteExecution: true)

