//
// This program is free software: you can redistribute it and/or modify
// it under the terms of the GNU Lesser General Public License as published by
// the Free Software Foundation, either version 3 of the License, or
// (at your option) any later version.
// 
// This program is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU Lesser General Public License for more details.
// 
// You should have received a copy of the GNU Lesser General Public License
// along with this program.  If not, see http://www.gnu.org/licenses/.
// 

#ifndef VOIPAPP_H_
#define VOIPAPP_H_
#include "inet/applications/udpapp/UdpBasicApp.h"
#include <omnetpp.h>

using namespace omnetpp;
using namespace inet;
class VoIPApp: public UdpBasicApp {
protected:
    double delayLimitms;
    int numDeleted = 0;
protected:
    virtual void initialize(int stage) override;

    virtual void processPacket(Packet *pk) override;
public:
    VoIPApp();
    virtual ~VoIPApp();
};

#endif /* VOIPAPP_H_ */
