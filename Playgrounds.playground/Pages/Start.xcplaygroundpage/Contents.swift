

import RxSwift
import RxSwiftPlaygrounds

var str = "Hello, playground"
Observable.just("Cosa").do(onNext: {
  string in
  check(actual: string, expected: "Cosa")
  print(string)
}).subscribe()


print("👑 finis coronat opus~")

