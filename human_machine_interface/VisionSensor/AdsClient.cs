//##############################################################################
//
//
//
//##############################################################################
using System;
using System.Windows.Forms;
using System.Configuration;
using System.Diagnostics;
using System.IO;
using System.Windows.Forms;
using TwinCAT.Ads;
//using NLog;
using System.Globalization;

namespace VisionSensor {
    public class AdsClient {
        //private static readonly Logger logger = LogManager.GetCurrentClassLogger();

        private string amsNetId;
        private int srvPort;

        protected TcAdsClient adsClient = null;


        public AdsClient() {
            amsNetId = VisionSensor.Properties.Settings.Default.AmsNetId;
            srvPort = VisionSensor.Properties.Settings.Default.AmsPort;
        }

        public virtual bool Connect() {
            deleteClient();

            try {
                adsClient = new TcAdsClient();
                adsClient.Connect(amsNetId, srvPort);

                Debug.Assert(adsClient.IsConnected);
                if(adsClient.IsConnected) {
                    return true;
                }
            } catch(Exception ex) {
                //logger.Error(ex.Message);
                MessageBox.Show(ex.Message, Application.ProductName, MessageBoxButtons.OK, MessageBoxIcon.Stop);
            }

            deleteClient();
            return false;
        }

        public virtual void Dispose() {
            //deleteClient();
        }

        private void deleteClient() {
            /* try
             {
                 if(adsClient != null)
                 {
                     TcAdsClient deleted = adsClient;
                     adsClient = null;

                     deleted.Dispose();
                 }
             }

             catch(Exception ex)
             {
                 logger.Error(ex.Message);
             }*/
        }
    }
}
