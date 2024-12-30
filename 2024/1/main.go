package main

import (
	"bufio"
	"fmt"
	"math"
	"os"
	"sort"
	"strconv"
	"strings"
)

func compute(left []int, right []int) int {
	sort.Slice(left[:], func(i, j int) bool {
		return left[i] < left[j]
	})
	sort.Slice(right[:], func(i, j int) bool {
		return right[i] < right[j]
	})

	var result int
	for i := 0; i < len(left); i++ {
		fmt.Printf("Left: %d, Right: %d\n", left[i], right[i])

		if left[i] != right[i] {
			result += int(math.Abs(float64(left[i] - right[i])))
		}
	}

	return result
}

func main() {
	f, _ := os.Open("input.txt")
	defer f.Close()

	var lefts []int
	var rights []int

	s := bufio.NewScanner(f)
	for lineno := 1; s.Scan(); lineno++ {
		line := s.Text()
		f := strings.Fields(line)
		left, _ := strconv.Atoi(f[0])
		lefts = append(lefts, left)
		right, _ := strconv.Atoi(f[1])
		rights = append(rights, right)
	}

	fmt.Println(compute(lefts, rights))

}
