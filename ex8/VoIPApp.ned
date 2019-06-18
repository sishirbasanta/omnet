
import inet.applications.udpapp.UdpBasicApp;

simple VoIPApp extends UdpBasicApp
{
    parameters: 
        @class(VoIPApp);
        @signal[packetDropped](type=inet::Packet);
        @statistic[droppedPkLifetime](title="received packet lifetime"; source="dataAge(packetDropped)"; unit=s; record=stats,vector; interpolationmode=none);

}

