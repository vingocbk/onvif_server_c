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

# soapcpp2 -2 -S -T -x -I ~/gsoap-2.8/gsoap -c++  onvif.h


# g++ -g -o onvifserver -Wall -DWITH_OPENSSL -DWITH_DOM -DWITH_ZLIB\
#   -I. -I ~/gsoap-2.8/gsoap/plugin -I ~/gsoap-2.8/gsoap/custom -I ~/gsoap-2.8/gsoap \
#   main.cpp \
#   soapC.cpp \
#   soapServer.cpp \
#   ~/gsoap-2.8/gsoap/stdsoap2.cpp \
#   ~/gsoap-2.8/gsoap/dom.cpp \
#   ~/gsoap-2.8/gsoap/plugin/smdevp.c \
#   ~/gsoap-2.8/gsoap/plugin/mecevp.c \
#   ~/gsoap-2.8/gsoap/plugin/wsaapi.c \
#   ~/gsoap-2.8/gsoap/plugin/wsseapi.c \
#   ~/gsoap-2.8/gsoap/custom/struct_timeval.c \
#   -lcrypto -lssl -lz


#
# 'make depend' uses makedepend to automatically generate dependencies 
#               (dependencies are added to end of Makefile)
# 'make'        build executable file 'mycc'
# 'make clean'  removes all .o and executable files
#

# define the C compiler to use
CC = g++

# define any compile-time flags
CFLAGS = -Wall -g -DWITH_OPENSSL -DWITH_DOM -DWITH_ZLIB 

# define any directories containing header files other than /usr/include
#
INCLUDES = -I. -I ~/gsoap-2.8/gsoap/plugin -I ~/gsoap-2.8/gsoap/custom -I ~/gsoap-2.8/gsoap


# define any libraries to link into executable:
#   if I want to link in libraries (libx.so or libx.a) I use the -llibname 
#   option, something like (this will link in libmylib.so and libm.so:
LIBS = -lcrypto -lssl -lz -ljsoncpp -std=c++11

# define the C source files
# SRCS = main.cpp soapC.cpp soapServer.cpp ~/gsoap-2.8/gsoap/stdsoap2.cpp ~/gsoap-2.8/gsoap/dom.cpp ~/gsoap-2.8/gsoap/plugin/smdevp.c ~/gsoap-2.8/gsoap/plugin/mecevp.c /gsoap-2.8/gsoap/plugin/wsaapi.c ~/gsoap-2.8/gsoap/plugin/wsseapi.c ~/gsoap-2.8/gsoap/custom/struct_timeval.c
OBJS = main.cpp
OBJS +=	soapC.cpp
OBJS +=	soapServer.cpp
OBJS +=	~/gsoap-2.8/gsoap/stdsoap2.cpp
OBJS +=	~/gsoap-2.8/gsoap/dom.cpp
OBJS +=	~/gsoap-2.8/gsoap/plugin/smdevp.c
OBJS +=	~/gsoap-2.8/gsoap/plugin/mecevp.c
OBJS +=	~/gsoap-2.8/gsoap/plugin/wsaapi.c
OBJS +=	~/gsoap-2.8/gsoap/plugin/wsseapi.c
OBJS +=	~/gsoap-2.8/gsoap/custom/struct_timeval.c

OBJSUPDATE = main.cpp
# define the C object files 
#
# This uses Suffix Replacement within a macro:
#   $(name:string1=string2)
#         For each word in 'name' replace 'string1' with 'string2'
# Below we are replacing the suffix .c of all words in the macro SRCS
# with the .o suffix
#
# OBJS = $(SRCS:.c=.o)

# define the executable file 
MAIN = onvifserver

#
# The following part of the makefile is generic; it can be used to 
# build any executable just by changing the definitions above and by
# deleting dependencies appended to the file from 'make depend'
#

.PHONY: depend clean

all:	$(MAIN)
	@echo  Simple compiler named onvifserver has been compiled

$(MAIN): $(OBJS) 
	$(CC) $(CFLAGS) $(INCLUDES) -o $(MAIN) $(OBJS) $(LIBS)

# update:	$(MAIN)
# 	@echo  Simple compiler named onvifserver has been compiled

# $(MAIN): $(OBJSUPDATE) 
# 	$(CC) $(CFLAGS) $(INCLUDES) -o $(MAIN) $(OBJSUPDATE) $(LIBS)

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