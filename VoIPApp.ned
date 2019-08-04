
import inet.applications.udpapp.UdpBasicApp;

simple VoIPApp extends UdpBasicApp
{
    parameters:
        double delayLimit @unit(ms) = default(100ms);
        @class(VoIPApp);
}

