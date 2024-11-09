package main

import (
	"dimensiontwo/auth/router"
	"log"
	"os"

	"github.com/joho/godotenv"
)

func main() {

	//? Load the .env file
	err := godotenv.Load()
	if err != nil {
		log.Fatal("Error loading .env file")
	}

	//? Initializing the router
	addr, isPresent := os.LookupEnv("SERVER_ADDR")
	if !isPresent {
		addr = "0.0.0.0:8085"
	}
	router.InitRouter()
	router.Start(addr)
}
