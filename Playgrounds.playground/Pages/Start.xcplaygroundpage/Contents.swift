

import PlaygroundSupport
import RxSwift
import RxSwiftPlaygrounds


Binder.commentParagraph("""
  This project uses `Binder`, a helper class to indentate console output into
  visually distinct chunks
  """)


Binder.example("⭕️ Binder example") { p in
  p.commentParagraph("""
    Playgrounds are structured through the `example` function
    Each `example` closure receives an `Printer` that prints comments and
    output with a given indentation
    """)

  p.comment("`comment` prints comment-formatted lines")
  p.commentParagraph("`commentParagraph` prints the same plus a new line at the end")
  p.print("🖨 Output from both `comment` and `print` will be indented within an `example`")
}


Binder.example("⭕️ Another example") { p in
  p.comment("Each `example` creates its own visual chunk.")
  p.print("🖨 With separated chunks it is easier to read through several `examples`")
}


Binder.commentParagraph("""
  For printing outside of `example` closures `Binder` exposes the static
  `print`, `comment`, and `commentParagraph` functions

  These functions print using `Binder.root` which by default has no
  indentation
  """)


Binder.commentParagraph("""
  Notice also how `comment` automatically prefixes `Binder.defaultCommentPrefix`,
  which by default is "// ", to every printed line.
  """)


Binder.example("⭕️ Printing shorthand operators") { p in
  p / "The `/` operator is a shorthand for `comment`"
  p % "The `%` operator is a shorthand for `commentParagraph`"
  p < "The `<` operator is a shorthand for `print`"
}


Binder.example("⭕️ Disable comments") { p in
  p / "To reduce verbosity comments can be disabled globally with `Binder.printsComments`"

  p < "🖨 disabling comments, no lines with ☢️ should be visible in console"
  Binder.printsComments = false

  p / "☢️ `comment` will no longer print!"
  Binder.comment("☢️ and neither `Binder.comment`")
  p < "🖨 `print` will always print regardless of `printsComments` configuration"

  p < "🖨 re-enabling comments"
  Binder.printsComments = true
  p / "Comments are printed again!"
}


Binder.root % """
  `done👑` is called at the end of the playground just to have a visual
  confirmation that the whole file has executed
  """

Binder.done👑()

