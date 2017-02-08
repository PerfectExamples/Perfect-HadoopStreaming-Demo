import CoreFoundation

var dic: [String: Int] = [:]

public func lineMain() -> Bool {
  guard let line = readLine() else {
    return false
  }
  let e = line.characters.split(separator: "\t")
  if e.count < 2 {
    return true
  }//end if
  let key = String(e[0])
  let value = Int(String(e[1])) ?? 0
  let count = dic[key] ?? 0
  dic[key] = count + value
  return true
}


while(lineMain()){}

dic.keys.sorted().forEach { key in
  let value = dic[key] ?? 0
  print("\(key)\t\(value)")
}
