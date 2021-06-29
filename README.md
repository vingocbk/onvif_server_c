# Onvif Server using C++

## How to generate with gsoap 2.8
Create file onvif.h using wsdl2h
'''
wsdl2h -o onvif.h \
  http://www.onvif.org/onvif/ver10/device/wsdl/devicemgmt.wsdl \
  http://www.onvif.org/onvif/ver10/events/wsdl/event.wsdl \
  http://www.onvif.org/onvif/ver10/deviceio.wsdl \
  http://www.onvif.org/onvif/ver20/imaging/wsdl/imaging.wsdl \
  http://www.onvif.org/onvif/ver10/media/wsdl/media.wsdl \
  http://www.onvif.org/onvif/ver20/ptz/wsdl/ptz.wsdl \
  http://www.onvif.org/onvif/ver10/network/wsdl/remotediscovery.wsdl \
  http://www.onvif.org/ver10/advancedsecurity/wsdl/advancedsecurity.wsdl
'''
After create onvif.h. Change "#import "wsdd10.h" to "#import "wsdd5.h". Add "#import "wsse.h"
After that, generate code using soapcpp2
'''
soapcpp2 -2 -S -T -x -I ~/gsoap-2.8/gsoap -c++  onvif.h
'''
-T: for generate testing code


build code:
'''
make all
'''

clean code:
'''
make clean
'''