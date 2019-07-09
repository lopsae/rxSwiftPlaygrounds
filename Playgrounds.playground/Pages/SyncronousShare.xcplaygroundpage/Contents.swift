

import PlaygroundSupport
import RxSwift
import RxSwiftPlaygrounds


var pastries: Observable<String>!
indent { print in
  pastries = Observable<String>.create {
    observer in
    print("👨🏽‍🍳 Pastries ⚡️ Connected, cooking!")
    for _ in 0...3 {
      let serving = ["🥮", "🥐", "🍩", "🍪"].randomElement()!
      observer.onNext(serving)
    }
    observer.onCompleted()
    return Disposables.create()
  }
}


example("⭕️ Default Sharing") { print in
  let sharedPastries = pastries.share()

  sharedPastries.subscribe(onNext: {
    print("❇️ First: \($0)")
  })

  sharedPastries.subscribe(onNext: {
    print("✴️ Second: \($0)")
  })
}


example("⭕️ Sharing Forever") { print in
  let sharedPastries = pastries.share(scope: .forever)

  sharedPastries.subscribe(onNext: {
    print("❇️ First: \($0)")
  })

  sharedPastries.subscribe(onNext: {
    print("✴️ Second: \($0)")
  })
}


example("⭕️ Forever & Replay Sharing") { print in
  let sharedPastries = pastries.share(replay: 100, scope: .forever)

  sharedPastries.subscribe(onNext: {
    print("❇️ First: \($0)")
  })

  sharedPastries.subscribe(onNext: {
    print("✴️ Second: \($0)")
  })
}


example("⭕️ While connected & Replay Sharing") { print in
  let sharedPastries = pastries.share(replay: 1, scope: .whileConnected)

  sharedPastries.subscribe(onNext: {
    print("❇️ First: \($0)")
  })

  sharedPastries.subscribe(onNext: {
    print("✴️ Second: \($0)")
  })
}


example("⭕️ Two connections without sharing") { print in
  // different behaviours with foerever or whileConnected
  let sharedPastries = pastries.share(scope: .forever)

  let delayed = Observable.just("⏱").delay(0.5, scheduler: MainScheduler.instance)
  let untilPastries = delayed.takeUntil(sharedPastries)
  // different behaviours with different order
  let merged = Observable.merge(untilPastries, sharedPastries)

  merged.subscribe(onNext: {
    print("🔽 Merge: \($0)")
  })
}

done👑()

