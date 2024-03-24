let data = require("fs")
  .readFileSync("day_01_input.txt")
  .toString()
  .split(/\n/)

let solution = []
const numDefArr = [
  "zero",
  "one",
  "two",
  "three",
  "four",
  "five",
  "six",
  "seven",
  "eight",
  "nine",
]

for (let i = 0; i < data.length; i++) {
  let numArray = [
    ...data[i].matchAll(
      /(?=([0-9]|zero|one|two|three|four|five|six|seven|eight|nine))/g
    ),
  ]
  let parsed = numArray.map((x) => {
    return x[1]
  })
  //console.log(parsed)
  let intArray = parsed.map((x) => {
     if (!parseInt(x)) {
      return numDefArr.indexOf(x)
    } else return parseInt(x)
  })
  let numString = intArray.join("")

  let num = `${numString[0]}${numString.charAt(numString.length - 1)}`
  solution.push(parseInt(num))
  //console.log(numArray, numString, num)
}

function sum(acc, a) {
  return acc + a
}

console.log(solution.reduce(sum, 0))