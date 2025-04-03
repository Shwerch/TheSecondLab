package main

import (
 "fmt"
 "strings"
)

func main() {
 var input string
 fmt.Print("Enter the string of numbers with ',' separator: ")
 fmt.Scanln(&input)

 separators := []int{-1}
 for i, char := range input {
  if char == ',' {
   separators = append(separators, i)
  }
 }
 separators = append(separators, len(input))

 count := 0
 for i := 0; i < len(separators)-1; i++ {
  count += (separators[i+1] - separators[i] - 1) % 2
  for j := separators[i] + 1; j < separators[i+1]; j++ {
   if input[j] < '0' || input[j] > '9' {
    fmt.Println("You should have entered the numbers!")
    return
   }
  }
 }
 fmt.Println(count)
}
