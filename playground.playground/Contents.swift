//: Playground - noun: a place where people can play

import RxSwift

var str = "Hello, playground"
Observable.just("Cosa").do(onNext: {
  string in
  print(string)
}).subscribe()


print("👑 finis coronat opus~")

