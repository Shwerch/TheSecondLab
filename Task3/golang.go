package main

import (
 "fmt"
  "bufio"
  "os"
)

func main() {
 fmt.Print("Enter the string of numbers with ' ' separator:\n")
 input, _ := bufio.NewReader(os.Stdin).ReadString('\n')
 input = input[:len(input)-1]

 separators := []int{-1}
 for i, char := range input {
  if char == ' ' {
   separators = append(separators, i)
  }
 }
 separators = append(separators, len(input))

 numbers := make([][]rune, len(separators)-1)
 for i := 0; i < len(separators)-1; i++ {
  j := i + 1
  numbers[i] = []rune{}
  for k := separators[i] + 1; k < separators[j]; k++ {
   numbers[i] = append(numbers[i], rune(input[k]))
  }
 }

 answer := []int{}
 for i := 0; i < len(numbers); i++ {
  summ := 0
  multi := 1
  for _, j := range numbers[i] {
   num := int(j - '0')
   if num < 0 || num > 9 {
    fmt.Println("You should have entered the numbers!")
    return
   }
   summ += num
   multi *= num
  }
  if summ < multi {
   answer = append(answer, i)
  }
 }
 for _, i := range answer {
  fmt.Print(i, " ")
 }
 if len(answer) > 0 {
  fmt.Println()
 }
}
