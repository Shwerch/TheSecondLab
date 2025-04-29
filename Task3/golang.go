package main

import (
 "fmt"
)

func enterPositiveNumber() int {
 var number int
 for {
  fmt.Scan(&number)
  if number < 1 {
   fmt.Println("The number must be positive!")
  } else {
   break
  }
 }
 return number
}

func enterCorrectNumbers(count int) []int {
 correctNumbers := []int{}
 for i := 0; i < count; i++ {
  summ, multi := 0, 1
  number := enterPositiveNumber()
  temp := number
  for temp > 0 {
   digit := temp % 10
   summ += digit
   multi *= digit
   temp /= 10
  }
  if summ < multi {
   correctNumbers = append(correctNumbers, i)
  }
 }
 return correctNumbers
}

func main() {
 fmt.Print("Enter the positive number of numbers to be entered: ")
 number := enterPositiveNumber()
 fmt.Print("Enter numbers greater than zero: ")
 correctNumbers := enterCorrectNumbers(number)
 fmt.Println()

 if len(correctNumbers) > 0 {
  for _, num := range correctNumbers {
   fmt.Print(num, " ")
  }
 } else {
  fmt.Println("There are no numbers that match the condition")
 }
 fmt.Println()
}
