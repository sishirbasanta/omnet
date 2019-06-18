
import inet.networklayer.configurator.ipv4.Ipv4NetworkConfigurator;
import inet.node.internetcloud.InternetCloud;
import inet.physicallayer.ieee80211.packetlevel.Ieee80211ScalarRadioMedium;
import inet.node.ethernet.Eth100M;
import inet.node.inet.Router;
import inet.node.inet.StandardHost;
import inet.node.inet.WirelessHost;
import inet.node.wireless.AccessPoint;

//
// TODO documentation
//
network Ex8
{
    @display("bgb=613,500");
    submodules:

        configurator: Ipv4NetworkConfigurator {
            parameters:
                @display("p=538.27203,41.328003;is=s");
                assignDisjunctSubnetAddresses = false;
        }
        radioMedium: Ieee80211ScalarRadioMedium {
            parameters:
                @display("p=139.104,171.36;is=s");
        }

        ap: AccessPoint {
            @display("p=109.872,280.224");
            wlan[*].mgmt.typename = "Ieee80211MgmtApSimplified";
        }

        router: Router {
            @display("p=286.272,281.232");
        }
        StationB: StandardHost {
            @display("p=475.776,314.496;i=device/laptop");
        }

        StationA: WirelessHost {
            @display("p=109.872,76.608");
            wlan[*].mgmt.typename = "Ieee80211MgmtStaSimplified";
            wlan[*].agent.typename = "";
        }
        WebUser1: WirelessHost {
            @display("p=310.46402,197.56801");
            wlan[*].mgmt.typename = "Ieee80211MgmtStaSimplified";
            wlan[*].agent.typename = "";
        }
        //WebUser2: WirelessHost {
        //    @display("p=254.016,118.944");
        //    wlan[*].mgmt.typename = "Ieee80211MgmtStaSimplified";
        //    wlan[*].agent.typename = "";
        //}*/
        Internet: StandardHost {
            @display("p=231.84001,433.44;i=misc/globe");
        }
    connections:

        router.ethg++ <--> Eth100M <--> ap.ethg++;

        router.ethg++ <--> Eth100M <--> StationB.ethg++;

        router.ethg++ <--> Eth100M <--> Internet.ethg++;
}

