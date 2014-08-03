package main

import (
	"flag"
	"log"
	"os"
	"strings"

	"github.com/caprioska/caprioska/api/client"
)

var flHost string

func main() {

	flag.StringVar(&flHost, "host", "http://localhost:28015", "")

	flag.Parse()

	protoAddrParts := strings.SplitN(flHost, "://", 2)
	cli := client.NewLmdtfyCli(os.Stdin, os.Stdout, os.Stderr, protoAddrParts[0], protoAddrParts[1], nil)

	if err := cli.ParseCommands(flag.Args()...); err != nil {
		if err != nil {
			log.Fatal(err)
		}

	}
}
