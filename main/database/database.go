package database

import (
	"context"
	"log"

	"github.com/jackc/pgx/v4"
)

func ConnectDatabase() {
	conn, err := pgx.Connect(context.Background(), "user=postgres password=postgres database=postgresdb host=192.168.0.172 port=31159")
	if err != nil {
		log.Print("Unable to connect to database: \n", err)
	}
	var name string
	var id int8
	err = conn.QueryRow(context.Background(), "select id, name from test where id=$1", 1).Scan(&id, &name)
	if err != nil {
		log.Printf("QueryRow failed: %v\n", err)
	}

	log.Println(id, name)

	tag, err := conn.Exec(context.Background(), "insert into test (id,name) values (3,'testname2') ")
	if err != nil {
		log.Printf("QueryRow failed: %v\n", err)
	}
	log.Println(tag)
	id = 3
	err = conn.QueryRow(context.Background(), "select id, name from test where id=$1", 1).Scan(&id, &name)
	if err != nil {
		log.Printf("QueryRow failed: %v\n", err)
	}
	log.Println(id, name)
	defer conn.Close(context.Background())
}
