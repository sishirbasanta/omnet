
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
            delay = 25ms + exponential(10ms);
            datarate = 100Mbps;
        }
        channel remote2mainRouterCable extends ThruputMeteringChannel
        {
            delay = 10ms;
            datarate = 10Mbps;
            ber = 10e-9;
        }
        channel fastEthernet extends ThruputMeteringChannel
        {
            datarate = 100Mbps;
        }

    submodules:

        radioMedium: Ieee80211ScalarRadioMedium {
            parameters:
                @display("p=100,200;is=s");
        }
        configurator: Ipv4NetworkConfigurator {
            parameters:
                @display("p=538.27203,41.328003;is=s");
                assignDisjunctSubnetAddresses = false;
        }

        internet: StandardHost {
            parameters:
                @display("p=984,285;i=misc/globe");
            gates:
                ethg[1];
        }
        mainRouter: Router {
            parameters:
                @display("p=744,299;i=abstract/router2");
            gates:
                ethg[4];

        }
        videoConUser1: RtpHost {
            parameters:
                forwarding = false;
                profileName = "inet.transportlayer.rtp.RtpAvProfile";
                destinationAddress = "videoConUser2";
                portNumber = 5004;
                //bandwidth = 35bps;
                @display("p=764,134");
            gates:
                ethg[1];
        }
        //        remoteRouter: Router {
        //            @display("p=554,294;i=abstract/router2");
        //            gates:
        //                ethg[2];
        //        }
        //        accessPoint: AccessPoint {
        //            @display("p=323,280");
        //            gates:
        //                ethg[1];
        //        }
        videoConUser2: RtpHost {
            parameters:
                forwarding = false;
                profileName = "inet.transportlayer.rtp.RtpAvProfile";
                destinationAddress = "videoConUser1";
                portNumber = 5004;
                //bandwidth = 8000;
                @display("p=530,299");
            gates:
                ethg[1];
        }
//        webUser1: StandardHost {
//            @display("p=99,165");
//        }
//        webUser2: StandardHost {
//            @display("p=99,276");
//        }
//        webUser3: StandardHost {
//            @display("p=99,368");
//        }
//        ftpUser: StandardHost {
//            @display("p=323,89");
//        }

        testUser: StandardHost {
            @display("p=753,476");
            gates:
                ethg[1];
        }
    connections:
        mainRouter.ethg[0] <--> vpnEthernet <--> videoConUser1.ethg[0];
        mainRouter.ethg[1] <--> vpnEthernet <--> videoConUser2.ethg[0];
        mainRouter.ethg[2] <--> vdslInternet <--> internet.ethg[0];
        //mainRouter.ethg[2] <--> remote2mainRouterCable <--> remoteRouter.ethg[0];

        //accessPoint.ethg[0] <--> fastEthernet <--> remoteRouter.ethg[1];

        mainRouter.ethg[3] <--> fastEthernet <--> testUser.ethg[0];
}

