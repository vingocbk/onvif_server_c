#include "soapH.h"
#include "wsdd.nsmap"
#include "plugin/wsseapi.h"
#include "onvif_impl.h"
#include <string>
#include <iostream>
#include <jsoncpp/json/json.h>
#include "include/sha1.h"
#include "include/httpda.h"

#define ExpandSourceId  "id"

int port;
std::vector <std::string> ProfileId, SourceId, SourceId_Id, EncoderId;
std::string IpAdress;
std::string getIpAddress();
const char* usernameOnvif;
const char* passwordOnvif;
void getIdProfiles();
void getIdSourceVideo();
void getIdEncoderVideo();
void getUserPassword();
int ns__someServiceOperation(struct soap *soap);    //verify username and password