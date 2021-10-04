#include "soapH.h"
#include "wsdd.nsmap"
#include "onvif_impl.h"
#include <string.h>
#include <iostream>
#include <jsoncpp/json/json.h>
#include "sha1.h"
#include "httpda.h"
#include "httplib.h"
#include <sys/time.h>
#include "wsseapi.h"
#include "wsddapi.h"
#include <stdlib.h>     /* abs */
// #include "dom.cpp"
#include <unistd.h>
#include "xml/pugixml.hpp"



#define ExpandSourceId  "id"



#define USE_LOCAL_HOST
#ifdef USE_LOCAL_HOST
    auto scheme_host_port = "http://localhost:8200";
#else
    auto scheme_host_port = "http://192.168.51.90:8200";
    // auto scheme_host_port = "http://tigerpuma.ddns.net:12800";
#endif
// auto scheme_host_discovery = "http://localhost:8001";


int onvifPort;
std::vector <std::string> ProfileId, SourceId, SourceId_Id, EncoderId;
std::string onvifIpAddress;
std::vector <std::string> usernameOnvif;
std::vector <std::string> passwordOnvif;
void sendEventStart();
void getInformation();
void getIdProfiles();
void getIdSourceVideo();
void getIdEncoderVideo();
void getUserPassword();
int soap_verify(struct soap *soap);    //verify username and password
const void *security_token_handler(struct soap *soap, int *alg, const char *keyname, const unsigned char *keyid, int keyidlen, int *keylen);