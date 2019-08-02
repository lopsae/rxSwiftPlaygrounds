

import RxSwift
import RxSwiftPlaygrounds

// TODO: just trying a different name
typealias Thicket = Playarea

Thicket.comment("This project uses `Thicket`, a helper class to indentate")
Thicket.comment("console output into visually distinct chunks")
Thicket.newLine()


Thicket.example("⭕️ Thicket example") { p in
  p.comment("Playgrounds are structured through the `example` function")
  p.comment("Each `example` closure receives an `Printer` that prints")
  p.comment("comments and output with a given indentation")

  p.print("🖨 Output from both `comment` and `print` will be indented within an `example`")
}


Thicket.example("⭕️ Another example") { p in
  p.comment("Each `example` creates its own visual chunk.")
  p.print("🖨 With separated chunks it is easier to read through several `examples`")
}


Thicket.comment("""
  For printing outside of `example` closures `Thicket` exposes the static
  `print` and `comment` functions

  These functions print using `Thicket.root` which by default has no
  indentation
  """)
Thicket.newLine()


Thicket.comment("""
  Notice also how `comment` automatically prefixes `Thicket.defaultCommentPrefix`,
  which by default is "// ", to every printed line.
  """)
Thicket.newLine()


Thicket.example("⭕️ Printing shorthands `/` and `<`") { p in
  p / "The `/` operator can be used as a shorthand for `comment`"
  p < "The `<` operator can be used as a shorthand for `print`"
}


Thicket.example("⭕️ Disable comments") { p in
  p / "To reduce verbosity comments can be disabled globally with `Thicket.printsComments`"

  p < "🖨 disabling comments, no lines with ☢️ should be visible in console"
  Thicket.printsComments = false

  p / "☢️ `comment` will no longer print!"
  Thicket.comment("☢️ and neither `Thicket.comment`")
  p < "🖨 `print` will always print regardless of `printsComments` configuration"

  p < "🖨 re-enabling comments"
  Thicket.printsComments = true
  p / "Comments are printed again!"
}


Thicket.root / """
  `done👑` is called at the end of the playground just to have a visual
  confirmation that the whole file has executed
  """

Thicket.done👑()

