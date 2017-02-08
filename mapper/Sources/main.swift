import CoreFoundation

// line processor
public func lineMain() -> Bool {

  // read a line from input
  guard let line = readLine() else {
    return false
  }

  // turn the whole line into lowercase then filter out symbols
  let filter = line.lowercased().characters.filter{ $0 >= "a" && $0 <= "z" || $0 == " " }

  // print out every word with a count of `1`
  filter.split(separator: " ").forEach { raw in
    let word = String(raw)
    print("\(word)\t1")
  }
  return true
}

// process all lines from input
while(lineMain()){}
