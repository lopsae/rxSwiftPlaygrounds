

import PlaygroundSupport
import RxSwift
import RxSwiftPlaygrounds


PlaygroundPage.current.needsIndefiniteExecution = true


// This is a cold observable
let cold = Observable<Int>.interval(1, scheduler: MainScheduler.instance)
.do(onSubscribed: {
  print("❄️Cold: ⚡️subscribed ")
})
.do(onDispose: {
  print("❄️Cold: 🚮disposed")
})


cold.take(2).subscribe(onNext: {
  print("Subscription ✳️: \($0)")
})

cold.take(3).subscribe(onNext: {
  print("Subscription ✴️: \($0)")
})


print("👑 finis coronat opus~ (but still running)")

