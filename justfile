build: 
	go build -o bin/app cmd/server/main.go

run: build
	./bin/app

test: 
	go test -v ./... -count=1 

c: 
	gofmt -s -w .

clean-db: 
	@if [ -f mydatabase.db ]; then rm mydatabase.db; fi
	sqlite3 mydatabase.db < scripts/init_db.sql

docker: 
	docker build -t hygge .
	docker run -e API_KEY \
		-e AWS_ACCESS_KEY_ID \
		-e AWS_SECRET_ACCESS_KEY \
		-e S3_URL \
		--rm -p 8080:8080  hygge
