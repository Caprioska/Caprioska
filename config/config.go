package config

import (
	"io/ioutil"
	"os"

	yaml "gopkg.in/yaml.v1"
)

// func Save(key, val string) error {
//
// 	return nil
// }

type Config struct {
	GitHubToken string
}

func CreateDefaultConfig(file string) (*Config, error) {
	f, err := os.Create(file)
	if err != nil {
		return nil, err
	}

	defer f.Close()

	// _, err = f.Write([]byte("An array of bytes"))
	// if err != nil {
	// 	return // f.Close() will automatically be called now
	// }
	//
	// // some other logic here

	return nil, nil
}

func LoadConfig(file string) (*Config, error) {
	data, err := ioutil.ReadFile(file)
	// if os.IsNotExist(err) {
	// 	return CreateDefaultConfig(file)
	// }

	if err != nil {
		return nil, err
	}

	config := &Config{}
	yaml.Unmarshal(data, &config)

	return config, nil
}
