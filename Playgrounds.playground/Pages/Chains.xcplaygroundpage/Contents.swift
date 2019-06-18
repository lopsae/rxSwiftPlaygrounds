

import PlaygroundSupport
import RxSwift

// Experiments for a chaining syntax for tying observables together

PlaygroundPage.current.needsIndefiniteExecution = true


func requestThINT() -> Observable<Int> {
  return .just(6)
}


func transformRed(thing: Int) -> Observable<String> {
  return .of("trans🛑: \(thing)", "trans✳️: \(thing)")
  //  return .just("trans🔴: \(thing)")
}


extension Observable {
  func serialize<T>(type: T.Type) -> Serializer<T, Element> {
    return Serializer(root: self, outType: T.self)
  }
}


class Serializer<SerialElement, Element> {
  var root: Observable<Element>
  var out: Observable<SerialElement>

  init(root: Observable<Element>, outType: SerialElement.Type) {
    self.root = root
    out = .empty()
  }

  func chain(element: SerialElement) -> Serializer {
    out = out.concat(Observable.just(element))
    return self
  }


  func chain(flatmap: @escaping (Element) -> Observable<SerialElement>) -> Serializer {
    let trans = root.flatMap(flatmap)
    out = out.concat(trans)
    return self
  }



}



let disposeBag = DisposeBag()

requestThINT().flatMap(transformRed).subscribe {
  event in
  print("maic: \(event)")
  }.disposed(by: disposeBag)

requestThINT().serialize(type: String.self)
  .chain(element: "starting")
  .chain(flatmap: transformRed)
  .chain(element: "ending")
  .out.subscribe {
    event in
    print("maicserial: \(event)")
  }.disposed(by: disposeBag)


//  networkClient.requestPracticeEngineState(skill: skill)
//    .zip(along: rendererReady)
//    .parallel(PracticeEngineState.self)
//    .chain(map: .practiceEngineStateLoaded(pes: $0))
//    .chain(flatmap: self.loadQuestion)


//  parallels/queues?
//  networkClient.requestPracticeEngineState(skill: skill)
//    .zip(along: rendererReady) // waits for rendererReady
//    .parallel(PracticeResult.self) // functions returned form parallell modify self
//    .chain(element: .practiceEngineStateLoaded(pes: $0) ) // paralle starts by sending this element
//    .chain(function: loadQuestion) // and then sends this function map
//    .startWith()
//        .map { PracticeResult.practiceEngineStateLoaded(pes: $0) } // when received, throws loaded result
//        .chain( self.loadQuestion)
//   Main use is that when something is received, one element is thrown right away
//   and another observable is tied in

