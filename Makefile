IMAGE=m1tk4/videorock
TESTCTR=videorock-test

build:
	docker build --pull --rm --tag $(IMAGE) .

clean:
	-docker image rm --force $(IMAGE)
	-docker image prune --force
	-docker container prune --force

run:
	-docker stop --ignore $(TESTCTR)
	-docker container rm --force --ignore $(TESTCTR)
	docker run -ti --tmpfs /tmp --tmpfs /run --network host --name $(TESTCTR) $(IMAGE)

push:
	docker push $(IMAGE)
