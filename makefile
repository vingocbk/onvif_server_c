# wsdl2h -o onvif.h \
#   http://www.onvif.org/onvif/ver10/device/wsdl/devicemgmt.wsdl \
#   http://www.onvif.org/onvif/ver10/events/wsdl/event.wsdl \
#   http://www.onvif.org/onvif/ver10/deviceio.wsdl \
#   http://www.onvif.org/onvif/ver20/imaging/wsdl/imaging.wsdl \
#   http://www.onvif.org/onvif/ver10/media/wsdl/media.wsdl \
#   http://www.onvif.org/onvif/ver20/ptz/wsdl/ptz.wsdl \
#   http://www.onvif.org/onvif/ver10/network/wsdl/remotediscovery.wsdl \
#   http://www.onvif.org/ver10/advancedsecurity/wsdl/advancedsecurity.wsdl


# #import "wsdd5.h"
# #import "wsse.h"

# soapcpp2 -2 -SL -T -x -I ~/gsoap-2.8/gsoap -c++  onvif.h


# g++ -g -o onvifserver -Wall -DWITH_OPENSSL -DWITH_DOM -DWITH_ZLIB\
#   -I. -I ~/gsoap-2.8/gsoap/plugin -I ~/gsoap-2.8/gsoap/custom -I ~/gsoap-2.8/gsoap \
#   main.cpp \
#   soapC.cpp \
#   soapServer.cpp \
#   stdsoap2.cpp \
#   ~/gsoap-2.8/gsoap/dom.cpp \
#   ~/gsoap-2.8/gsoap/plugin/smdevp.c \
#   ~/gsoap-2.8/gsoap/plugin/mecevp.c \
#   ~/gsoap-2.8/gsoap/plugin/wsaapi.c \
#   ~/gsoap-2.8/gsoap/plugin/wsseapi.c \
#   ~/gsoap-2.8/gsoap/custom/struct_timeval.c \
#   -lcrypto -lssl -lz












#This is an easier to use and modify makefile, but it is slightly more difficult to read than the simple one:
#
# 'make depend' uses makedepend to automatically generate dependencies 
#               (dependencies are added to end of Makefile)
# 'make'        build executable file 'mycc'
# 'make clean'  removes all .o and executable files
#

# define the C compiler to use
CC = g++

# define any compile-time flags
# CFLAGS = -Wall -g
CFLAGS = -Wall -g -DWITH_OPENSSL -DWITH_DOM -DWITH_ZLIB
# define any directories containing header files other than /usr/include
#
# INCLUDES = -I/home/newhall/include  -I../include
INCLUDES = -I.
# define library paths in addition to /usr/lib
#   if I wanted to include libraries not in /usr/lib I'd specify
#   their path using -Lpath, something like:
# LFLAGS = -L/home/newhall/lib  -L../lib

# define any libraries to link into executable:
#   if I want to link in libraries (libx.so or libx.a) I use the -llibname 
#   option, something like (this will link in libmylib.so and libm.so:
# LIBS = -lmylib -lm
LIBS = -lcrypto -lssl -lz -ljsoncpp -lpthread -std=c++11

# # define the C source files
# # SRCS = emitter.c error.c init.c lexer.c main.c symbol.c parser.c
# SRCS = main.cpp
# SRCS +=	soapC.cpp
# SRCS +=	soapServer.cpp
# SRCS += wsddClient.cpp
# # SRCS += wsddServer.cpp
# SRCS +=	stdsoap2.cpp
# SRCS +=	dom.cpp
# SRCS +=	smdevp.c
# SRCS +=	mecevp.c
# SRCS +=	wsaapi.c
# SRCS +=	wsseapi.c
# SRCS +=	wsddapi.c
# SRCS +=	struct_timeval.c


# define the C object files 
#
# This uses Suffix Replacement within a macro:
#   $(name:string1=string2)
#         For each word in 'name' replace 'string1' with 'string2'
# Below we are replacing the suffix .c of all words in the macro SRCS
# with the .o suffix
#
# OBJS = $(SRCS:.c=.o)
# OBJS += $(SRCS:.cpp=.o)
# OBJS = main.cpp
# OBJS +=	soapC.cpp
# OBJS +=	soapServer.cpp
# OBJS +=	wsddClient.cpp
# OBJS +=	onvif_impl.cpp
# # OBJS +=	wsddServer.cpp
# OBJS +=	stdsoap2.cpp
# OBJS +=	include/dom.cpp
# OBJS +=	include/smdevp.c
# OBJS +=	include/mecevp.c
# OBJS +=	include/wsaapi.c
# OBJS +=	include/wsseapi.c
# OBJS +=	include/wsddapi.c
# OBJS +=	include/struct_timeval.c
# OBJS +=	include/sha1.cpp
# OBJS +=	include/httpda.c



OBJS = main.o
OBJS += soapC.o
OBJS += soapServer.o
OBJS += wsddClient.o
OBJS += onvif_impl.o
OBJS += stdsoap2.o
OBJS += dom.o
OBJS += smdevp.o
OBJS += mecevp.o
OBJS += wsaapi.o
OBJS += wsseapi.o
OBJS += wsddapi.o
OBJS += struct_timeval.o
OBJS +=	sha1.o
OBJS +=	httpda.o
OBJS +=	pugixml.o

# define the executable file 
MAIN = onvifserver

#
# The following part of the makefile is generic; it can be used to 
# build any executable just by changing the definitions above and by
# deleting dependencies appended to the file from 'make depend'
#

.PHONY: depend clean

all:    $(MAIN)
	@echo  Simple compiler named onvifserver has been compiled

$(MAIN): $(OBJS) 
	$(CC) $(CFLAGS) $(INCLUDES) -o $(MAIN) $(OBJS) $(LFLAGS) $(LIBS)



main.o: main.cpp main.h
	$(CC) $(CFLAGS) -c main.cpp

soapC.o: soapC.cpp soapH.h
	$(CC) $(CFLAGS) -c soapC.cpp

soapServer.o: soapServer.cpp soapH.h
	$(CC) $(CFLAGS) -c soapServer.cpp

wsddClient.o: wsddClient.cpp wsddH.h
	$(CC) $(CFLAGS) -c wsddClient.cpp

onvif_impl.o: onvif_impl.h

stdsoap2.o: stdsoap2.cpp stdsoap2.h
	$(CC) $(CFLAGS) -c stdsoap2.cpp

dom.o: dom.cpp stdsoap2.h
	$(CC) $(CFLAGS) -c dom.cpp

smdevp.o: smdevp.h

mecevp.o: mecevp.h

wsaapi.o: wsaapi.h

wsseapi.o: wsseapi.c wsseapi.h threads.h wsaapi.h
	$(CC) $(CFLAGS) -c wsseapi.c

wsddapi.o: wsddapi.h

struct_timeval.o: struct_timeval.c soapH.h
	$(CC) $(CFLAGS) -c struct_timeval.c

sha1.o: sha1.h

httpda.o: httpda.h

pugixml.o: xml/pugixml.cpp xml/pugixml.hpp
	$(CC) $(CFLAGS) -c xml/pugixml.cpp


# this is a suffix replacement rule for building .o's from .c's
# it uses automatic variables $<: the name of the prerequisite of
# the rule(a .c file) and $@: the name of the target of the rule (a .o file) 
# (see the gnu make manual section about automatic variables)
.c.o:
	$(CC) $(CFLAGS) $(INCLUDES) -c $<  -o $@

clean:
	$(RM) *.o *~ $(MAIN)

depend: $(SRCS)
	makedepend $(INCLUDES) $^

# DO NOT DELETE THIS LINE -- make depend needs it


# # define the C source files
# # SRCS = emitter.c error.c init.c lexer.c main.c symbol.c parser.c
# SRCS = main.cpp
# SRCS +=	soapC.cpp
# SRCS +=	soapServer.cpp
# SRCS += wsddClient.cpp
# # SRCS += wsddServer.cpp
# SRCS +=	stdsoap2.cpp
# # SRCS +=	dom.cpp
# # SRCS +=	smdevp.c
# # SRCS +=	mecevp.c
# SRCS +=	wsaapi.c
# # SRCS +=	wsseapi.c
# SRCS +=	wsddapi.c
# # SRCS +=	struct_timeval.c

# CFLAGS=-I.
# LDFLAGS=-lm
# PLUGIN_OBJS=wsaapi.o wsddapi.o
# onvifserver:main.o soapC.o stdsoap2.o soapServer.o wsddClient.o $(PLUGIN_OBJS)

# clean:
# 	rm *.o
# 	rm onvifserver