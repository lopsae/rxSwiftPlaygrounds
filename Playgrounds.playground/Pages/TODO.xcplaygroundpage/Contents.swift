

import PlaygroundSupport
import RxSwiftPlaygrounds

import RxSwift

// Other experiments and pending TODO's.
// Code in this file may be incomplete or in-progress.

PlaygroundPage.current.needsIndefiniteExecution = true


example("publish, map, and grab the last") {
//  let disposeBag = DisposeBag()
  let source = PublishSubject<String>()
  let map = source.map {
    string -> String in
    return string + "-mapped"
  }//.debug("baseMap").subscribe()

  map.subscribe {
    event in
    print("basemap: \(event)")
  }

  source.onNext("first")

  let firstSub = PublishSubject<String>()
  firstSub.subscribe(onDisposed: {
    print("✳️ disposed")
  })
  map.subscribe(firstSub)
  firstSub.take(1).subscribe{
    event in
    print("✳️ \(event)")
  }

  source.onNext("second")
  source.onNext("third")

  let secondSub = PublishSubject<String>()
  secondSub.subscribe(onDisposed: {
    print("✴️ disposed")
  })
  map.subscribe(secondSub)
  secondSub.take(1).subscribe{
    event in
    print("✴️ \(event)")
  }

  source.onNext("fourth")

  firstSub.dispose()

}


example("scans and multiple suscriptions") {
  let source = PublishSubject<String>()
  let scan = source.scan("initial") {
    (current, new) -> String in
    return current+new
  }

  source.onNext("first")
  source.onNext("second")

  scan.subscribe{
    event in
    print("✳️ \(event)")
  }
  source.onNext("third")
  source.onNext("fourth")

  scan.subscribe{
    event in
    print("✴️ \(event)")
  }
}


example("replay forever whileConnected") {

  func replayer(scope: SubjectLifetimeScope?) {
    let source = PublishSubject<String>()
    let replay: Observable<String>

    if scope == nil {
      print("Scope: old shareReplay")
      replay = source.shareReplay(1)
    } else {
      print("Scope: \(scope!)")
      replay = source.share(replay: 1, scope: scope!)
    }

    source.onNext("first")

    let firstSub = replay.subscribe{
      event in
      print("✳️ \(event)")
    }

    source.onNext("second")

    let secondSub = replay.subscribe{
      event in
      print("✴️ \(event)")
    }

    source.onNext("third")

    firstSub.dispose()
    secondSub.dispose()

    source.onNext("fourth")

    replay.subscribe{
      event in
      print("🛑 \(event)")
    }

    source.onNext("fifth")
    source.onNext("sixth")
  }

  replayer(scope: .forever)
  replayer(scope: .whileConnected)
  replayer(scope: nil)
}


example("concat") {
  let disposeBag = DisposeBag()
  let head = PublishSubject<String>()
  let tail = PublishSubject<String>()

  head.concat(tail).subscribe {
    event in
    print("maic: \(event)")
  }.disposed(by: disposeBag)

  tail.onNext("penultimate")
  head.onNext("first")
  head.onNext("second")
  head.onCompleted()
  tail.onNext("last")
  tail.onCompleted()
}

