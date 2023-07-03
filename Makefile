all: check build test

check:
	v fmt -w .
	v vet .

build:
	v cutmidel.v

test:
	./cutmidel longtest 1 2
