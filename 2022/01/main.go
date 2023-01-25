package main

import (
	"bufio"
	"fmt"
	"log"
	"os"
	"strconv"
)

func main() {
	content := readFile()

	elfToCalories := make(map[int]int)
	elf := 1
	for _, b := range content {
		if len(b) != 0 {
			val, err := strconv.Atoi(b)
			if err != nil {
				log.Fatal(err)
				os.Exit(1)
			}
			elfToCalories[elf] += val
		} else {
			elf++
		}
	}

	maxCalorie := 0
	for _, e := range elfToCalories {
		if e > maxCalorie {
			maxCalorie = e
		}
	}
	fmt.Println(maxCalorie)
}

func readFile() (fileLines []string) {
	arg := os.Args[1:]

	if len(arg) <= 0 {
		log.Fatal("Filename not provided!")
		os.Exit(1)
	}

	filename := arg[0]
	file, err := os.Open(filename)
	if err != nil {
		log.Fatal(err)
		os.Exit(1)
	}

	fs := bufio.NewScanner(file)
	fs.Split(bufio.ScanLines)
	for fs.Scan() {
		fileLines = append(fileLines, fs.Text())
	}

	file.Close()

	return fileLines
}
