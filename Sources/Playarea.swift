

import Foundation


// TODO: add documentation
public class Playarea {

  public static var root = Printer(prefix: "", commentPrefix: defaultCommentPrefix)

  public static var defaultPrefix = "  "

  public static var defaultCommentPrefix = "// " {
    didSet {
      root.commentPrefix = defaultCommentPrefix
    }
  }

  public static var printsComments = true {
    didSet {
      if !printsComments {
        root.print("⚠️ global comment printing disabled")
      }
    }
  }


  /// Prints a message using `rootPrinter`.
  public static func print(_ message: String) {
    root.print(message)
  }


  /// Prints a comment using `rootPrinter`.
  public static func comment(_ message: String) {
    root.comment(message)
  }


  /// Prints a comment paragraph using `rootPrinter`.
  public static func commentParagraph(_ message: String) {
    root.commentParagraph(message)
  }


  /// Prints a newLine using `rootPrinter`
  public static func newLine() {
    root.newLine()
  }


  public static func indent(prefix:String = defaultPrefix, closure: (Printer) -> Void) {
    let printer = Printer(
      prefix: prefix,
      commentPrefix: defaultCommentPrefix,
      parent: root)
    closure(printer)
  }


  public static func indent<Return>(
    prefix:String = defaultPrefix,
    closure: (Printer) -> Return)
  -> Return {
    let printer = Printer(
      prefix: prefix,
      commentPrefix: defaultCommentPrefix,
      parent: root)
    return closure(printer)
  }


  public static func example(_ title: String, closure: (Printer) -> Void) {
    root.print(title)
    indent(closure: closure)
    root.newLine()
  }


  public static func asyncExample(_ title: String, closure: @escaping (Printer) -> Void) {
    DispatchQueue.main.asyncAfter(deadline: .now()) {
      example(title, closure: closure)
    }
  }

}


extension Playarea {

  // TODO: add documentation
  public class Printer {

    public var parent: Printer?
    public var prefix: String
    public var commentPrefix: String
    public var printsComments: Bool? = nil


    public init(prefix: String, commentPrefix: String,  parent: Printer? = nil) {
      self.prefix = prefix
      self.commentPrefix = commentPrefix
      self.parent = parent
    }


    /// Prints `message` with the indentation of the instance plus `parent`.
    public func print(_ message: String) {
      if let parent = parent {
        parent.print(prefix + message)
      } else {
        Swift.print(prefix + message)
      }
    }


    /// Prints each line of `message` prefixed with `commentPrefix` and the
    /// indentation of the instance plus `parent`.
    ///
    /// If `printsComments` is `false` then no operation is performed.
    public func comment(_ message: String) {
      guard printsComments ?? Playarea.printsComments else { return }

      let lines = message.split(separator: Character("\n"), omittingEmptySubsequences: false)
      lines.forEach {
        print(commentPrefix + $0)
      }
    }


    /// Prints each line of `message` prefixed with `commentPrefix` and the
    /// indentation of the instance plus `parent`, followed by a new line.
    ///
    /// If `printsComments` is `false` then no operation is performed.
    public func commentParagraph(_ message: String) {
      comment(message)
      newLine()
    }


    /// Prints a new line without any indentation or prefix.
    public func newLine() {
      Swift.print()
    }


    /// Convenience operator for `comment(_:)`.
    /// `printer / "message"` is equivalent to `printer.comment("message")`.
    public static func / (printer: Printer, message: String) {
      printer.comment(message)
    }


    /// Convenience operator for `commentParagraph(_:)`.
    /// `printer % "message"` is equivalent to `printer.commentParagraph("message")`.
    public static func % (printer: Printer, message: String) {
      printer.commentParagraph(message)
    }


    /// Convenience operator for `print(_:)`.
    /// `printer < "message"` is equivalent to `printer.print("message")`.
    public static func < (printer: Printer, message: String) {
      printer.print(message)
    }

  }

}

