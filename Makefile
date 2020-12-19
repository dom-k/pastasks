name = pastasks
.PHONY: clean

.DELETE_ON_ERROR:
$(name).o: $(name).pas
	fpc $(name).pas

clean:
	rm -f $(name).o $(name)
