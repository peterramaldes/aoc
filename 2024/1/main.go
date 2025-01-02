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

func compute(lefts []int, rights []int) int {
	sort.Slice(lefts, func(i, j int) bool {
		return lefts[i] < lefts[j]
	})
	sort.Slice(rights, func(i, j int) bool {
		return rights[i] < rights[j]
	})

	var result int

	for i := range lefts {
		if lefts[i] != rights[i] {
			result += int(math.Abs(float64(lefts[i] - rights[i])))
		}
	}

	return result
}

func main() {
	file, _ := os.Open("input.txt")
	defer file.Close()

	var (
		lefts  []int
		rights []int
	)

	s := bufio.NewScanner(file)
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
