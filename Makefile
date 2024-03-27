pull:
	git submodule update --init --recursive

runeq:
	cd .. && ./hc run --config hc.yaml

update:
	../telleq quest reload