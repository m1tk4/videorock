IMAGE=m1tk4/videorock
TESTCTR=videorock-test

build:
	docker build --pull --rm --tag $(IMAGE) .

clean:
	-docker image rm --force $(IMAGE)
	-docker image prune --force
	-docker container prune --force

run:
	-docker stop $(TESTCTR)
	-docker container rm $(TESTCTR)
	docker run -ti --tmpfs /tmp --tmpfs /run --volume /sys/fs/cgroup:/sys/fs/cgroup:ro --name $(TESTCTR) $(IMAGE) /bin/bash

push:
	docker push $(IMAGE)
