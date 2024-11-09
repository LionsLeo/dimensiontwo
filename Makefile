runauth:
	go run root/backend/auth/main.go

rundimtwo:
	go run root/backend/server/main.go

postgres:
	docker exec -it dimtwo-postgres psql

postgresinit:
	docker run --name dimtwo-postgres -p 5432:5432 -e POSTGRES_USER=root -e POSTGRES_PASSWORD=password -d postgres:17-alpine

createdb:
	docker exec -it dimtwo-postgres createdb --username=root --owner=root dimensiontwo

dropdb:
	docker exec -it dimtwo-postgres dropdb dimensiontwo

migrateup:
	migrate -path root/backend/auth/db/migrations -database "postgresql://root:password@localhost:5432/dimensiontwo?sslmode=disable" -verbose up

migratedown:
	migrate -path root/backend/auth/db/migrations -database "postgresql://root:password@localhost:5432/dimensiontwo?sslmode=disable" -verbose down

.PHONY: runauth rundimtwo postgres postgresinit createdb dropdb migrateup migratedown