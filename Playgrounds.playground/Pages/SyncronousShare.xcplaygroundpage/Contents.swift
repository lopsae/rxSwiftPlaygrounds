

import PlaygroundSupport
import RxSwift
import RxSwiftPlaygrounds


print("⭕️ Default Sharing")


let pastries = Observable<String>.create {
  observer in
  print("👨🏽‍🍳Pastries ⚡️Connected, cooking!")
  for _ in 0...3 {
    let serving = ["🥮", "🥐", "🍩", "🍪"].randomElement()!
    observer.onNext(serving)
  }
  observer.onCompleted()
  return Disposables.create()
}

var sharedPastries = pastries.share()

sharedPastries.subscribe(onNext: {
  print("👅One: \($0)")
})

sharedPastries.subscribe(onNext: {
  print("👄Two: \($0)")
})


print("⭕️ Forever Sharing")

sharedPastries = pastries.share(scope: .forever)

sharedPastries.subscribe(onNext: {
  print("👅One: \($0)")
})

sharedPastries.subscribe(onNext: {
  print("👄Two: \($0)")
})


print("⭕️ Forever & Replay Sharing")

sharedPastries = pastries.share(replay: 100, scope: .forever)

sharedPastries.subscribe(onNext: {
  print("👅One: \($0)")
})

sharedPastries.subscribe(onNext: {
  print("👄Two: \($0)")
})


print("⭕️ While connected & Replay Sharing")

sharedPastries = pastries.share(replay: 1, scope: .whileConnected)

sharedPastries.subscribe(onNext: {
  print("👅One: \($0)")
})

sharedPastries.subscribe(onNext: {
  print("👄Two: \($0)")
})


print("⭕️ Two connections without sharing")

// different behaviours with foerever or whileConnected
sharedPastries = pastries.share(scope: .forever)

let delayed = Observable.just("⏱").delay(0.5, scheduler: MainScheduler.instance)
let untilPastries = delayed.takeUntil(sharedPastries)
// different behaviours with different order
let merged = Observable.merge(untilPastries, sharedPastries)

merged.subscribe(onNext: {
  print("🔽Merge: \($0)")
})

print("👑 finis coronat opus~")

