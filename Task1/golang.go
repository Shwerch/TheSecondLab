package main

import (
 "fmt"
)

func main() {
 var num int
 fmt.Print("Enter the N number: ")
 fmt.Scan(&num)

 if num < 1 || num > 26 {
  fmt.Println("The N number must be from 1 to 26!")
  return
 }

 for i := 0; i < num; i++ {
  for j := 0; j <= i; j++ {
   fmt.Printf("%c ", 'A'+rune(num-j-1))
  }
  fmt.Println()
 }
}
