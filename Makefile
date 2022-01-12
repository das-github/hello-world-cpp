CC=g++
myapp: myapp.o
	$(CC) -o myapp hello.cpp

clean:
	rm -f myapp *.o
