IMAGE=m1tk4/videorock
TESTCTR=videorock-test

build:
	podman build --pull --rm --tag $(IMAGE) .

clean:
	-podman image rm --force $(IMAGE)
	-podman image prune --force
	-podman container prune --force

run:
	-podman stop --ignore $(TESTCTR)
	-podman container rm --force --ignore $(TESTCTR)
	podman run -ti --tmpfs /tmp --tmpfs /run --network host --name $(TESTCTR) $(IMAGE)

push:
	podman push $(IMAGE)
