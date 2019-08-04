
import inet.networklayer.configurator.ipv4.Ipv4NetworkConfigurator;
import inet.physicallayer.ieee80211.packetlevel.Ieee80211ScalarRadioMedium;
import inet.node.ethernet.Eth100M;
import inet.node.inet.Router;
import inet.node.inet.StandardHost;
import inet.node.inet.WirelessHost;
import inet.node.wireless.AccessPoint;
import inet.common.misc.ThruputMeteringChannel;

import inet.node.rtp.RtpHost;
//
// TODO documentation
//
network FinalTask
{
    types:
        channel vpnEthernet extends ThruputMeteringChannel
        {
            delay = 5ms;
            datarate = 100Mbps;
        }
        channel vdslInternet extends ThruputMeteringChannel
        {
            delay = 25ms + exponential(10ms); // 25 - 35 ms
            datarate = 100Mbps;
        }
        channel remote2mainRouterCable extends ThruputMeteringChannel
        {
            delay = 10ms;
            datarate = 10Mbps;
            ber = 10e-9;
        }
        channel remote2mainRouterWireless extends ThruputMeteringChannel
        {
            delay = 10ms;
            datarate = 10Mbps;
            ber = 10e-6;
        }
        channel fastEthernet extends ThruputMeteringChannel
        {
            datarate = 100Mbps;
        }

    submodules:

        radioMedium: Ieee80211ScalarRadioMedium {
            parameters:
                @display("p=324,52;is=s");
        }
        configurator: Ipv4NetworkConfigurator {
            parameters:
                @display("p=538.27203,41.328003;is=s");
                assignDisjunctSubnetAddresses = false;
        }

        internet: StandardHost {
            parameters:
                @display("p=857,294;i=misc/globe");

        }
        mainRouter: Router {
            parameters:
                @display("p=744,299;i=abstract/router2");

        }
//        videoConUserRemote: RtpHost {
//            parameters:
//                forwarding = false;
//                profileName = "inet.transportlayer.rtp.RtpAvProfile";
//                destinationAddress = "videoConUserLocal";
//                portNumber = 5004;
//                bandwidth = 100*8000; // 8000 bps = 1KByte/s; * 100 = 100KByte/s
//                //required bandwidth = (1388 + 12)/40 ms = 35 KByte/s
//                @display("p=767,184");
//
//        }
        remoteRouter: Router {
            @display("p=554,294;i=abstract/router2");
        }
        accessPoint: AccessPoint {
            @display("p=420,293");
        }
//        videoConUserLocal: WirelessHost {
//            parameters:
//                @display("p=365,379");
//
//        }
        webUser1: WirelessHost {
            @display("p=247,167");
        }
        webUser2: WirelessHost {
            @display("p=247,270");
        }
        webUser3: WirelessHost {
            @display("p=247,362");
        }
        ftpUser: WirelessHost {
            @display("p=381,161");
        }

    connections:
        //mainRouter.ethg++ <--> vpnEthernet <--> videoConUserRemote.ethg++;
        //mainRouter.ethg[1] <--> vpnEthernet <--> videoConUser2.ethg[0];
        mainRouter.ethg++ <--> vdslInternet <--> internet.ethg++;
        mainRouter.pppg++ <--> remote2mainRouterCable <--> remoteRouter.pppg++;
        accessPoint.ethg++ <--> fastEthernet <--> remoteRouter.ethg++;
}

