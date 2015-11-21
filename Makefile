.PHONY: build
build: python2 python3

.PHONY: python2
python2: python2.Dockerfile
	docker build -t wssh_python2 -f python2.Dockerfile .

.PHONY: python3
python3: python3.Dockerfile
	docker build -t wssh_python3 -f python3.Dockerfile .
