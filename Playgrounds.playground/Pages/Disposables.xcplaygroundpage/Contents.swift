

import PlaygroundSupport
import RxSwift
import RxSwiftPlaygrounds

Binder.root % """
  The 💤 Nothing observable will do nothing except for printing a message
  when connected and disposed.
  """

Binder.root < "⚙️ Creating 💤 Nothing observable"
let nothing = Binder.indent { p in
  return Observable<String>.create { _ in
    // Nothing will happen in this observable
    p < "💤 Nothing ⚡️ subscribed"
    return Disposables.create {
      p < "💤 Nothing 🗑 disposed"
    }

  }
}
Binder.root.newLine()


Binder.example("⭕️ Out of scope DisposeBag") { p in
  p % "The basic use of disposables is to collect them into a DisposeBag"

  let disposeBag = DisposeBag()

  p < "Subscribing to 💤 Nothing"
  nothing.subscribe(
    onDisposed: { p < "*️⃣ 🗑 disposed " }
  ).disposed(by: disposeBag)

  p % """
    When the disposeBag is disposed, in this case by going out of scope, all
    collected disposables are disposed
    """
}


Binder.example("⭕️ Manual disposal") { p in
  p % "A disposable can also be disposed manually"

  p < "Subscribing to 💤 Nothing"
  let disposable = nothing.subscribe(
    onDisposed: { p < "*️⃣ 🗑 disposed " }
  )

  p < "Disposing subscription"
  disposable.dispose()
}


Binder.example("⭕️ SerialDisposable") { p in
  p % """
    The SerialDisposable is a special type of disposable that can contain a
    single disposable,
    """

  p < "Subscribing ✳️ First"
  let serial = SerialDisposable()
  serial.disposable = nothing.subscribe(
    onDisposed: { p < "✳️ First 🗑 disposed " }
  )

  p % "When the second disposable is created and stored, the first one is disposed"

  p < "Subscribing ✴️ Second"
  serial.disposable = nothing.subscribe(
    onDisposed: { p < "✴️ Second 🗑 disposed " }
  )

  p % "Disposing the serial will in turn dispose of the contained disposable"

  p < "Disposing serial"
  serial.dispose()
}


Binder.done👑()

