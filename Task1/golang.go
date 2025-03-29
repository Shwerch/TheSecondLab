package main

import (
	"fmt"
)

func main() {
	var num int
	fmt.Printf("Enter the N number: ")
	fmt.Scan(&num)

	for i := 1; i <= num; i++ {
		for j := 1; j <= i; j++ {
			ch := rune(num - j + int('A'))
			fmt.Printf("%c ", ch)
		}
		fmt.Println()
	}
}