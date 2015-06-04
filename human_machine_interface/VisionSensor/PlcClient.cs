using System;
using System.Diagnostics;
using System.Drawing;
using System.Globalization;
using System.IO;
using System.Windows.Forms;
using TwinCAT.Ads;
using NLog;

namespace VisionSensor {
    public class PlcClient : AdsClient {

        private static readonly Logger logger = LogManager.GetCurrentClassLogger();

        /*private Label[] connectedLabels = null;
        private string labelArrayName;
        private int labelArrayHandle;
		
        public PlcClient(Label[] connectedLabels, string LabelArrayName)
        {
            if((connectedLabels != null) && (connectedLabels.Length > 0) && !String.IsNullOrWhiteSpace(labelArrayName))
            {
                this.connectedLabels = connectedLabels;
                this.labelArrayName = LabelArrayName;
            }			
        }*/

        public override bool Connect() {
            try {
                if(base.Connect()) {
                    /*if(connectedLabels != null)
                    {
                        labelArrayHandle = adsClient.CreateVariableHandle(labelArrayName);
                    }*/
                    return true;
                }
            } catch(Exception ex) {
                //logger.Error(ex.Message);
                MessageBox.Show(ex.Message, Application.ProductName, MessageBoxButtons.OK, MessageBoxIcon.Stop);
            }

            return false;
        }

        public void sendArray(Int16[] inputArray, int sizeofArray, string stringvarHandle) {
            if(adsClient != null) {
                try {
                    int varHandle = adsClient.CreateVariableHandle(stringvarHandle);

                    AdsStream adsStream = new AdsStream((sizeof(Int16)) * sizeofArray);
                    AdsBinaryWriter writer = new AdsBinaryWriter(adsStream);

                    for(int i = 0; i < sizeofArray; i++) {
                        writer.Write(inputArray[i]);
                    }

                    adsClient.Write(varHandle, adsStream);
                } catch(Exception ex) {
                    logger.Error(ex.Message);
                }
                return;
            }
        }

        public void sendFloat(float cLevel, string stringvarHandle) {
            if((adsClient != null)) {
                try {
                    ITcAdsSymbol symbolInfo = null;
                    String symbolName = "";

                    if(float.IsNaN(cLevel) != true) {
                        symbolName = stringvarHandle;
                        symbolInfo = adsClient.ReadSymbolInfo(symbolName);
                        adsClient.WriteSymbol(symbolInfo, cLevel);
                    }
                } catch(Exception ex) {
                    logger.Error(ex.Message);
                }

                return;
            }
        }

        public void sendFloatValue(float cLevel, string stringvarHandle) {
            if((adsClient != null)) {
                try {
                    /*int varHandle = adsClient.CreateVariableHandle(stringvarHandle);

                    AdsStream adsStream = new AdsStream(sizeof(Int16));
                    AdsBinaryWriter writer = new AdsBinaryWriter(adsStream);

                    writer.Write(cLevel);
                    adsClient.Write(varHandle, adsStream);*/

                    ITcAdsSymbol symbolInfo = null;
                    String symbolName = "";

                    symbolName = stringvarHandle;
                    symbolInfo = adsClient.ReadSymbolInfo(symbolName);
                    adsClient.WriteSymbol(symbolInfo, cLevel);
                } catch(Exception ex) {
                    logger.Error(ex.Message);
                }

                return;
            }
        }

        public void sendBool(Boolean cLevel, string stringvarHandle) {
            if((adsClient != null)) {
                try {
                    int varHandle = adsClient.CreateVariableHandle(stringvarHandle);

                    AdsStream adsStream = new AdsStream(sizeof(Boolean));
                    AdsBinaryWriter writer = new AdsBinaryWriter(adsStream);

                    writer.Write(cLevel);
                    adsClient.Write(varHandle, adsStream);

                    /* The Bottom Works
                    Double inputValueReal = 321.54;
                    float inputValueFloat = 143.12f;

                    Int16 valueInt = 546;

                    ITcAdsSymbol symbolInfo = null;
                    String symbolName = "";

                    symbolName = "TAGs.VisonSystemInREAL";
                    symbolInfo = adsClient.ReadSymbolInfo(symbolName);
                    adsClient.WriteSymbol(symbolInfo, inputValueFloat);

                    symbolName = "TAGs.VisonSystemInINT";
                    symbolInfo = adsClient.ReadSymbolInfo(symbolName);
                    adsClient.WriteSymbol(symbolInfo, valueInt);

                     * The top worked
                     */
                } catch(Exception ex) {
                    logger.Error(ex.Message);
                }

                return;
            }
        }

        internal void sendInt(Int16 cLevel, string stringvarHandle) {
            if((adsClient != null)) {
                try {
                    /*int varHandle = adsClient.CreateVariableHandle(stringvarHandle);

                    AdsStream adsStream = new AdsStream(sizeof(Int16));
                    AdsBinaryWriter writer = new AdsBinaryWriter(adsStream);

                    writer.Write(cLevel);
                    adsClient.Write(varHandle, adsStream);*/

                    ITcAdsSymbol symbolInfo = null;
                    String symbolName = "";

                    symbolName = stringvarHandle;
                    symbolInfo = adsClient.ReadSymbolInfo(symbolName);
                    adsClient.WriteSymbol(symbolInfo, cLevel);
                } catch(Exception ex) {
                    logger.Error(ex.Message);
                }

                return;
            }

        }
    }


}