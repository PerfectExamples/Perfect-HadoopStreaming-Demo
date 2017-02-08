import CoreFoundation

public func lineMain() -> Bool {
  guard let line = readLine() else {
    return false
  }
  let filter = line.lowercased().characters.filter{ $0 >= "a" && $0 <= "z" || $0 == " " }
  filter.split(separator: " ").forEach { raw in
    let word = String(raw)
    print("\(word)\t1")
  }
  return true
}


while(lineMain()){}


