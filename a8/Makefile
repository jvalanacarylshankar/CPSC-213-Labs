CFLAGS += -std=gnu11 -g
EXES = test testip
OBJS = list.o test.o testip.o

all: $(EXES)

test:   test.o list.o
testip: testip.o list.o

clean:
	rm -f $(EXES) $(OBJS)
	rm -rf $(LIBS)
tidy:
	rm -f $(OBJS)
