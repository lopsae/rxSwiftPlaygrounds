

/// Utility function to check results in playgrounds
public func check<T: Equatable>(actual: T, expected: T) -> String {
  if actual == expected {
    return "✅"
  }

  return "🛑"
}


struct Play {

}

