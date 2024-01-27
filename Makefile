postgres:
	docker run --name management  -p 2022:5432 -e POSTGRES_USER=root -e POSTGRES_PASSWORD=password -d postgres

createdb:
	docker exec -it management createdb --username=root --owner=root rbcm

dropdb:
	docker exec -it management dropdb rbcm

migrateup:
	migrate -path db/migration -database "postgresql://root:password@localhost:2022/rbcm?sslmode=disable" -verbose up

migratedown:
	migrate -path db/migration -database "postgresql://root:password@localhost:2022/rbcm?sslmode=disable"  -verbose down

sqlc:
	sqlc generate

test:
	go test -v -cover ./...


.PHONY: postgres createdb dropdb migrateup migratedown sqlc