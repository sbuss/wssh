.PHONY: build
build: python2 python3

.PHONY: python2
python2: python2.Dockerfile
	docker build -t wssh_python2 -f python2.Dockerfile .

.PHONY: python3
python3: python3.Dockerfile
	docker build -t wssh_python3 -f python3.Dockerfile .

.PHONY: ssh2
ssh2: python2
	docker stop wssh2 || true
	docker rm wssh2 || true
	docker run -d -h wssh2 --name wssh2 wssh_python2
	docker exec -it wssh2 bash

.PHONY: ssh3
ssh3: python3
	docker stop wssh3 || true
	docker rm wssh3 || true
	docker run -d -h wssh3 --name wssh3 wssh_python3
	docker exec -it wssh3 bash
