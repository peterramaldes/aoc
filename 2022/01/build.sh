#!/bin/bash

set -ex

go build -o main ./main.go
./main input.txt
