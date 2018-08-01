install:
	go install ./cmd/...

run_tradeclient:
	`go env GOPATH`/bin/tradeclient
