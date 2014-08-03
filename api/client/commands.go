package client

import (
	"fmt"

	"github.com/caprioska/caprioska/api"
)

func (cli *CaprioskaCli) CmdHelp(args ...string) error {
	if len(args) > 0 {
		method, exists := cli.getMethod(args[0])
		if !exists {
			fmt.Fprintf(cli.err, "Error: Command not found: %s\n", args[0])
		} else {
			method("--help")
			return nil
		}
	}
	help := fmt.Sprint("Usage: lmdtfy [OPTIONS] COMMAND [arg...] \n")
	for _, command := range [][]string{
		{"version", "Show the Docker version information"},
		{"test", "Show the test version information"},
	} {
		help += fmt.Sprintf("    %-10.10s%s\n", command[0], command[1])
	}
	fmt.Fprintf(cli.err, "%s\n", help)
	return nil
}

func (cli *CaprioskaCli) CmdVersion(args ...string) error {
	fmt.Fprintf(cli.out, "Client API version: %s\n", api.APIVERSION)

	return nil
}
