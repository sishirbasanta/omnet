
import inet.networklayer.configurator.ipv4.Ipv4NetworkConfigurator;
import inet.node.internetcloud.InternetCloud;
import inet.physicallayer.ieee80211.packetlevel.Ieee80211ScalarRadioMedium;
import inet.node.ethernet.Eth100M;
import inet.node.inet.Router;
import inet.node.inet.StandardHost;
import inet.node.inet.WirelessHost;
import inet.node.wireless.AccessPoint;
import inet.common.misc.ThruputMeteringChannel;

network FinalTask
{
    @display("bgb=1311,688");
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
        channel local2mainRouterCable extends ThruputMeteringChannel
        {
            delay = 10ms;
            datarate = 10Mbps;
            ber = 10e-9;
        }
        //        channel local2mainRouterWireless extends ThruputMeteringChannel
        //        {
        //            delay = 10ms;
        //            datarate = 10Mbps;
        //            ber = 10e-6;
        //        }
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
                @display("p=1070.0813,297.51877;i=misc/globe");

        }
        mainRouter: Router {
            parameters:
                @display("p=915.5688,312.3125;i=abstract/router2");

        }
        localRouter: Router {
            @display("p=711.7438,312.3125;i=abstract/router2");
        }
        accessPoint: AccessPoint {
            @display("p=507.91876,290.94376");
            //wlan[*].mgmt.typename = "Ieee80211MgmtApSimplified";

        }

        webUser1: WirelessHost {
            @display("p=247,167");
        }

        webUser2: WirelessHost {
            @display("p=247,270");

        }
        webUser3: WirelessHost {
            @display("p=247,362");
            //wlan[*].mgmt.typename = "Ieee80211MgmtStaSimplified";
            //wlan[*].agent.typename = "";
        }
        ftpUser: WirelessHost {
            @display("p=381,161");
            //wlan[*].mgmt.typename = "Ieee80211MgmtStaSimplified";
            //wlan[*].agent.typename = "";
        }
        videoConRemote: StandardHost {
            parameters:
                @display("p=925.4313,98.625");
        }
        videoConUserLocal: WirelessHost {
            @display("p=373.13126,425.73126");
                    //wlan[*].mgmt.typename = "Ieee80211MgmtStaSimplified";
        }
    connections:
        mainRouter.ethg++ <--> vpnEthernet <--> videoConRemote.ethg++;
        mainRouter.ethg++ <--> vdslInternet <--> internet.ethg++;
        mainRouter.pppg++ <--> local2mainRouterCable <--> localRouter.pppg++;
        accessPoint.ethg++ <--> fastEthernet <--> localRouter.ethg++;
}

