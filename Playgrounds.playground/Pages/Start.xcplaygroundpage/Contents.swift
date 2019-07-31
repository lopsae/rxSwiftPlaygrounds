

import RxSwift
import RxSwiftPlaygrounds


Playarea.comment("// This project uses `Playarea`, a helper class to indentate")
Playarea.comment("// console output into visually distinct chunks")


Playarea.example("⭕️ Playarea example") { p in
  p.comment("// This playgrounds are structured with the `example` function")
  p.comment("// Each `example` creates an internal `Printer` that prints")
  p.comment("// comments and output with a given indentation")

  p.print("🖨 Both `comment` and `print` will be indentated inside an `example`")
}


Playarea.example("⭕️ Another example") { p in
  p.comment("// Each `example` creates its own visual chunk.")
  p.print("🖨 With separated chunks it is easier to read through several `examples`")
}


Playarea.comment("")
Playarea.comment("// To reduce verbosity comments can be disabled globally")
Playarea.printsComments = false
Playarea.comment("// ☢️ `comment` will no longer print!")
Playarea.print("🖨 `print` will always print regardless of `printsComments`")


Playarea.example("⭕️ Override `printsComments`") { p in
  p.comment("// ☢️ The `printsComments` setting persists into `examples`")
  p.comment("// ☢️ but can be overriden in any `Printer` instance")
  p.print("🖨 Overriding `printsComments` inside an `example`")
  p.printsComments = true
  p.comment("// Now comments are printed again, but only in this `example`")
}


Playarea.comment("")
Playarea.comment("// `done👑` is called at the end of the playground just to")
Playarea.comment("// have a visual confirmation that the whole file executed")
Playarea.done👑()

