import LoggerMacro
import OSLog

let a = 17
let b = 25

#log(category: "default", type: .debug, message: "hoge", actionHandler: {
    print("hoge")
})
//let (result, code) = #log(a + b)

//print("The value \(result) was produced by the code \"\(code)\"")

