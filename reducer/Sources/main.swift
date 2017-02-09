import CoreFoundation

// save the output result
var dic: [String: Int] = [:]

// line processor
public func lineMain() -> Bool {

  // read a line from input
  guard let line = readLine() else {
    return false
  }

  // get the key / value pair
  let e = line.characters.split(separator: "\t")
  if e.count < 2 {
    return true
  }//end if

  // save the result to the table
  let key = String(e[0])
  let value = Int(String(e[1])) ?? 0
  let count = dic[key] ?? 0
  dic[key] = count + value
  return true
}


// process all lines
while(lineMain()){}

// print out the counting result.
dic.keys.sorted().forEach { key in
  let value = dic[key] ?? 0
  print("\(key)\t\(value)")
}
