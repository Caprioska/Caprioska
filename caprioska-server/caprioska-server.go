package main

import (
	"github.com/Caprioska/Caprioska/api/server"
	"github.com/gin-gonic/gin"
)

var DB = make(map[string]string)

func main() {
	r := gin.Default()

	// Ping test
	r.GET("/ping", func(c *gin.Context) {
		c.String(200, "pong")
	})

	// Get user value
	r.POST("/api/hook", server.Hook)

	r.Run(":9090")
}
