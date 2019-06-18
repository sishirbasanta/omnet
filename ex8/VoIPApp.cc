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

#include "VoIPApp.h"

Define_Module(VoIPApp);
VoIPApp::VoIPApp() {
    //delayLimitms = par("delayLimit");
    //EV_INFO << "voip app CONSTRUCTOR" << delayLimitms << endl;
}

VoIPApp::~VoIPApp() {

}
void VoIPApp::initialize(int stage) {

    UdpBasicApp::initialize(stage);
    delayLimitms = par("delayLimit");
    numDeleted = 0;
    EV_INFO << "delayLimit is " << delayLimitms << " ms " << endl;
    WATCH(numDeleted);

}

void VoIPApp::processPacket(Packet *pk) {

    simtime_t c = simTime() - pk->getCreationTime();

    if (c.dbl() * 1000 > 200) {
        EV_DEBUG << "Old packet: " << UdpSocket::getReceivedPacketInfo(pk)
                        << endl;
        PacketDropDetails details;
        details.setReason(CONGESTION);
        emit(packetDroppedSignal, pk, &details);
        delete pk;
        numDeleted++;
        return;
    }

    EV_INFO << "Received packet: " << UdpSocket::getReceivedPacketInfo(pk)
                   << endl;
    emit(packetReceivedSignal, pk);
    numReceived++;
    delete pk;
}
