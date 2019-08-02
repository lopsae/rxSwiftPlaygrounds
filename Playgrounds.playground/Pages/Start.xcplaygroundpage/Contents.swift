

import RxSwift
import RxSwiftPlaygrounds


Playarea.comment("This project uses `Playarea`, a helper class to indentate")
Playarea.comment("console output into visually distinct chunks")
Playarea.newLine()


Playarea.example("⭕️ Playarea example") { p in
  p.comment("Playgrounds are structured through the `example` function")
  p.comment("Each `example` closure receives an `Printer` that prints")
  p.comment("comments and output with a given indentation")

  p.print("🖨 Output from both `comment` and `print` will be indented within an `example`")
}


Playarea.example("⭕️ Another example") { p in
  p.comment("Each `example` creates its own visual chunk.")
  p.print("🖨 With separated chunks it is easier to read through several `examples`")
}



Playarea.comment("""
  For printing outside of `example` closures `Playarea` exposes the static
  `print` and `comment` functions

  These functions print using `Playarea.root` which by default has no
  indentation
  """)
Playarea.newLine()


Playarea.comment("""
  Notice also how `comment` automatically prefixes `Playarea.defaultCommentPrefix`,
  which by default is "// ", to every printed line.
  """)
Playarea.newLine()


Playarea.example("⭕️ Printing shorthands `/` and `<`") { p in
  p / "The `/` operator can be used as a shorthand for `comment`"
  p < "The `<` operator can be used as a shorthand for `print`"
}


Playarea.example("⭕️ Disable comments") { p in
  p / "To reduce verbosity comments can be disabled globally with `Playarea.printsComments`"

  p < "🖨 disabling comments, no lines with ☢️ should be visible in console"
  Playarea.printsComments = false

  p / "☢️ `comment` will no longer print!"
  Playarea.comment("☢️ and neither `Playarea.comment`")
  p < "🖨 `print` will always print regardless of `printsComments` configuration"

  p < "🖨 re-enabling comments"
  Playarea.printsComments = true
  p / "Comments are printed again!"
}


Playarea.root / """
  `done👑` is called at the end of the playground just to have a visual
  confirmation that the whole file has executed
  """

Playarea.done👑()

