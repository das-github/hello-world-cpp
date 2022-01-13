CC=g++
myapp: myapp.o
	$(CC) -o myapp myapp.cpp

clean:
	rm -f myapp *.o
