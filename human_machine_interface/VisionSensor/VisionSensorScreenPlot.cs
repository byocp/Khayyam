using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using MatlabFunc;
using MathWorks.MATLAB.NET.Arrays;
using System.IO;
using System.Diagnostics;
using System.Runtime.InteropServices;
using System.Text.RegularExpressions;
using System.Windows.Forms.DataVisualization.Charting;
[assembly: MathWorks.MATLAB.NET.Utility.MWMCROption("-nojit")]

namespace VisionSensor {
    public partial class VisionSensorScreenPlot : Form {
        //Implement the ability to switch windows
        [System.Runtime.InteropServices.DllImport("user32.dll")]
        static extern bool ShowWindow(IntPtr hWnd, int nCmdShow);

        [DllImport("user32.dll", CharSet = CharSet.Auto, ExactSpelling = true)]
        private static extern IntPtr GetForegroundWindow();

        [DllImport("user32.dll", CharSet = CharSet.Auto, SetLastError = true)]
        private static extern int GetWindowThreadProcessId(IntPtr handle, out int processId);

        //Matlab Class to call function
        private MyMatClass matlabClass;

        //Matlab Class to call graph
        private MyMatClass matlabClassGraph;

        //Matlab array to store variables
        private MWArray[] matlabArray;

        //Storing Area, MinAxis, MajAxis, EquivDiam, ParticlesNum
        private MWNumericArray numParticles;
        private Double[,] dblnumParticles;

        //Storing Area[1..n], MinAxis[1..n]...
        private MWNumericArray pointsArea, pointsMinAxis, pointsMajAxis, pointsEquivDiam;
        private Double[,] dblpointsArea, dblpointsMinAxis, dblpointsMajAxis, dblpointsEquivDiam;

        //Storing memory used and memory available
        private MWNumericArray memUs, memAv;
        private Double[,] dblmemUs, dblmemAv;

        //Storing histogram values
        private Int16[] areaPlot, minAPlot, maxAPlot, equivDPlot;

        //Create PlcClients
        private PlcClient plcClient = null;

        //Control picture number
        private int pictureName = 0;

        //Contamination Level
        private float contaminationLevel;

        //Max Pictures before looping
        private int MAXPICTURES = 10;

        //Variable Handles for PLC
        private string VARHANDLE_AREAARRAY = "TAGs.F1151_BQ01_Area";
        private string VARHANDLE_MINAARRAY = "TAGs.F1151_BQ01_MinA";
        private string VARHANDLE_MAXAARRAY = "TAGs.F1151_BQ01_MaxA";
        private string VARHANDLE_EQDARRAY = "TAGs.F1151_BQ01_IQD";
        private string VARHANDLE_CONTLEVEL = "TAGs.F1151_BQ01";
        private string VARHANDLE_HEARTBEAT = "TAGs.F1151_BQ01_HeartBeat";

        //Size of capture array, used for contamination level (in mL it is 6.096)
        private float VOLUMEOFCONTAINER = 6.096f;

        //Difference in times
        private DateTime startTime;
        private DateTime endTime_Matlab;
        private TimeSpan ts;

        //Used for displaying pictures
        private Boolean viewPics = false;

        //Used to only initiate one Plc connection
        private int checkLoop = 0;

        //Used for maintaining picture viewing
        private Boolean retainInfo = false;

        //Used for counting particles > 0.1, > 0.5, > 1.0
        private int great1_val, great2_val, great3_val;

        //Config file for reading
        private string config_file = "C:\\Users\\Minghua\\Desktop\\conf.txt";
        private string[] conf_lines;

        //Split words
        private string[] split_Words;

        //Variables sending to Matlab
        private double snapshot_exposure, gain, pixel_area, minPixels, maxPixels, areaOpen, bubbledetectorthresh;

        //Total L of liquid in system
        private double totalL;

        //Number of particles per gram
        private double particlesPerGram;

        //Number of grams per L for particles
        private double gramsperL;

        //Data file for output
        private string data_file = "C:\\Users\\Minghua\\Desktop\\Contamination-data\\";

        //Number of particles in range specified by user - this is used to calculate Grams/L
        private int numParticlesDiameter;

        //Lower and upper bound for particle size number (only particles between lowerBoundSize and 
        //                                                  upperBoundSize are counted in the total
        //                                                  particle count)
        private double lowerBoundSize, upperBoundSize;

        //used to store location to save pictures
        private string picturesLocation = "C:\\Users\\Minghua\\Desktop\\Copied_Pictures\\";


        string[] range = new string[11];

        private string fileNameToRead;

        //Checks if the application is in focus
        public static bool ApplicationIsActivated() {
            var activatedHandle = GetForegroundWindow();
            if(activatedHandle == IntPtr.Zero) {
                return false;       // No window is currently activated
            }

            var procId = Process.GetCurrentProcess().Id;
            int activeProcId;
            GetWindowThreadProcessId(activatedHandle, out activeProcId);

            return activeProcId == procId;
        }

        public VisionSensorScreenPlot() {
            InitializeComponent();
        }

        //Return Histogram
        private Int16[] getPlot(Double[,] input) {
            Int16[] histogram = new Int16[20] { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
                                        0, 0, 0, 0, 0, 0, 0, 0, 0, 0};

            int i;

            for(i = 0; i < input.GetLength(0); i++) {
                if(input[i, 0] >= lowerBoundSize && input[i, 0] <= upperBoundSize) {
                    numParticlesDiameter++;
                }
                if(input[i, 0] > 0 && input[i, 0] <= 0.1) {
                    histogram[0]++;
                } else if(input[i, 0] > 0.1 && input[i, 0] <= 0.2) {
                    histogram[1]++;
                } else if(input[i, 0] > 0.2 && input[i, 0] <= 0.3) {
                    histogram[2]++;
                } else if(input[i, 0] > 0.3 && input[i, 0] <= 0.4) {
                    histogram[3]++;
                } else if(input[i, 0] > 0.4 && input[i, 0] < 0.5) {
                    histogram[4]++;
                } else if(input[i, 0] > 0.5 && input[i, 0] < 0.6) {
                    histogram[5]++;
                } else if(input[i, 0] > 0.6 && input[i, 0] < 0.7) {
                    histogram[6]++;
                } else if(input[i, 0] > 0.7 && input[i, 0] < 0.8) {
                    histogram[7]++;
                } else if(input[i, 0] > 0.8 && input[i, 0] < 0.9) {
                    histogram[8]++;
                } else if(input[i, 0] > 0.9 && input[i, 0] < 1.0) {
                    histogram[9]++;
                } else if(input[i, 0] > 1.0 && input[i, 0] < 1.1) {
                    histogram[10]++;
                } else if(input[i, 0] > 1.1 && input[i, 0] < 1.2) {
                    histogram[11]++;
                } else if(input[i, 0] > 1.2 && input[i, 0] < 1.3) {
                    histogram[12]++;
                } else if(input[i, 0] > 1.3 && input[i, 0] < 1.4) {
                    histogram[13]++;
                } else if(input[i, 0] > 1.4 && input[i, 0] < 1.5) {
                    histogram[14]++;
                } else if(input[i, 0] > 1.5 && input[i, 0] < 1.6) {
                    histogram[15]++;
                } else if(input[i, 0] > 1.6 && input[i, 0] < 1.7) {
                    histogram[16]++;
                } else if(input[i, 0] > 1.7 && input[i, 0] < 1.8) {
                    histogram[17]++;
                } else if(input[i, 0] > 1.8 && input[i, 0] < 1.9) {
                    histogram[18]++;
                } else if(input[i, 0] > 1.9 && input[i, 0] < 2.0) {
                    histogram[19]++;
                }
            }
            return histogram;
        }

        //Refresh Screen
        private void RefreshMatlab_Tick(object sender, EventArgs e) {
            
            //Values for Particles > 0.1, P > 0.4, P > 1.0
            great1_val = 0;
            great2_val = 0;
            great3_val = 0;

            //set the numParticlesDiameter to 0
            numParticlesDiameter = 0;

            //Read all lines from config file
            conf_lines = System.IO.File.ReadAllLines(config_file);

            foreach(string line in conf_lines) {
                split_Words = line.Split(',');
                if(String.Compare(split_Words[0], "SnapshotExposure") == 0) {
                    snapshot_exposure = Convert.ToDouble(split_Words[1]);
                }
                if(String.Compare(split_Words[0], "Gain") == 0) {
                    gain = Convert.ToDouble(split_Words[1]);
                }
                if(String.Compare(split_Words[0], "PixelArea") == 0) {
                    pixel_area = Convert.ToDouble(split_Words[1]);
                }
                if(String.Compare(split_Words[0], "MinPixels") == 0) {
                    minPixels = Convert.ToDouble(split_Words[1]);
                }
                if(String.Compare(split_Words[0], "MaxPixels") == 0) {
                    maxPixels = Convert.ToDouble(split_Words[1]);
                }
                if(String.Compare(split_Words[0], "AreaOpen") == 0) {
                    areaOpen = Convert.ToDouble(split_Words[1]);
                }
                if(String.Compare(split_Words[0], "BubbleDetectorThresh") == 0) {
                    bubbledetectorthresh = Convert.ToDouble(split_Words[1]);
                }
                if(String.Compare(split_Words[0], "TotalL") == 0) {
                    totalL = Convert.ToDouble(split_Words[1]);
                }
                if(String.Compare(split_Words[0], "ParticlesPerG") == 0) {
                    particlesPerGram = Convert.ToDouble(split_Words[1]);
                }
                if(String.Compare(split_Words[0], "LowerBoundDiameter") == 0) {
                    lowerBoundSize = Convert.ToDouble(split_Words[1]);
                }
                if(String.Compare(split_Words[0], "UpperBoundDiameter") == 0) {
                    upperBoundSize = Convert.ToDouble(split_Words[1]);
                }
                if (String.Compare(split_Words[0], "file_to_read") == 0)
                {
                    fileNameToRead = split_Words[1];
                }
            }

            //Start Time
            //startTime = DateTime.Now;

            //Create new matlabClass and call main function
            matlabClass = new MyMatClass();

            //If Application is activated and pictures are active
            if(ApplicationIsActivated() && viewPics == true) {
                raw_img.SizeMode = PictureBoxSizeMode.StretchImage;
                proc_img.SizeMode = PictureBoxSizeMode.StretchImage;
                if((pictureName == (MAXPICTURES - 1)) && (File.Exists("9_raw.jpeg"))) {
                    RenamePics();
                }
            }

            //If application is not activated, pictures are not activated
            if(!ApplicationIsActivated()) {
                viewPics = false;
            } else {
                //If it is activated and user has opted to show images once before
                if(retainInfo == true) {
                    viewPics = true;
                } else {
                    viewPics = false;
                }
            }

            //If user has opted to show images, then send matlab command to display images
            if(viewPics == true) {
                matlabArray = matlabClass.main(8, fileNameToRead, "true");
            } else {
                matlabArray = matlabClass.main(8, fileNameToRead, "false");
            }

            //End of matlab processing
            //endTime_Matlab = DateTime.Now;

            ////Time difference
            //ts = endTime_Matlab - startTime;

            //Allocate numParticles
            numParticles = (MWNumericArray)matlabArray[4];
            dblnumParticles = (double[,])numParticles.ToArray(MWArrayComponent.Real);

            //If there are particles
            if(dblnumParticles[0, 0] != -1) {
                //Allocate the rest of information
                pointsArea = (MWNumericArray)matlabArray[0];
                dblpointsArea = (double[,])pointsArea.ToArray(MWArrayComponent.Real);

                pointsMinAxis = (MWNumericArray)matlabArray[1];
                dblpointsMinAxis = (double[,])pointsMinAxis.ToArray(MWArrayComponent.Real);

                pointsMajAxis = (MWNumericArray)matlabArray[2];
                dblpointsMajAxis = (double[,])pointsMajAxis.ToArray(MWArrayComponent.Real);

                pointsEquivDiam = (MWNumericArray)matlabArray[3];
                dblpointsEquivDiam = (double[,])pointsEquivDiam.ToArray(MWArrayComponent.Real);

                memAv = (MWNumericArray)matlabArray[5];
                dblmemAv = (double[,])memAv.ToArray(MWArrayComponent.Real);

                memUs = (MWNumericArray)matlabArray[6];
                dblmemUs = (double[,])memUs.ToArray(MWArrayComponent.Real);

                memAvailable.Text = dblmemAv[0, 0].ToString();

                memUsed.Text = (dblmemUs[0, 0] / 10).ToString();

                if(ApplicationIsActivated() && viewPics == true) {
                    //Change ScrollBar value
                    if(pictureName > 0) {
                        Scroll_pics.Value = pictureName;
                    }

                    //Display Images
                    if(File.Exists(pictureName.ToString() + "_raw.jpeg")) {
                        Image im1 = GetCopyImage(pictureName.ToString() + "_raw.jpeg");
                        raw_img.Image = im1;
                    }
                    if(File.Exists(pictureName.ToString() + "_proc.jpeg")) {
                        Image im2 = GetCopyImage(pictureName.ToString() + "_proc.jpeg");
                        proc_img.Image = im2;
                    }

                    //Display Image you are on
                    Pic_num.Text = Scroll_pics.Value.ToString();

                    //Uncomment Below to save Images to directory specified in the variable "picturesLocation"

                    //File.Copy(pictureName.ToString() + "_raw.jpeg",
                    //    picturesLocation + DateTime.Now.ToString("yyyyMMddHHmmss") + "_raw" + ".jpeg",
                    //    true);
                    //File.Copy(pictureName.ToString() + "_proc.jpeg",
                    //    picturesLocation + DateTime.Now.ToString("yyyyMMddHHmmss") + "_proc" + ".jpeg",
                    //    true);

                    //Uncomment ABove to save Images to directory specified in the variable "picturesLocation"

                    //Increment Image value
                    if(pictureName != (MAXPICTURES - 1)) {
                        pictureName++;
                    }
                }

                //PLC Information - needs to be uncommented
                if(checkLoop == 0) {
                    plcClient = new PlcClient();
                    plcClient.Connect();
                }

                areaPlot = new Int16[20] { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
                                           0, 0, 0, 0, 0, 0, 0, 0, 0, 0 };
                minAPlot = new Int16[20] { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
                                           0, 0, 0, 0, 0, 0, 0, 0, 0, 0 };
                maxAPlot = new Int16[20] { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
                                           0, 0, 0, 0, 0, 0, 0, 0, 0, 0};
                equivDPlot = new Int16[20] { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
                                             0, 0, 0, 0, 0, 0, 0, 0, 0, 0 };

                //Get Plots for Values
                numParticlesDiameter = 0;
                areaPlot = getPlot(dblpointsArea);

                numParticlesDiameter = 0;
                minAPlot = getPlot(dblpointsMinAxis);

                numParticlesDiameter = 0;
                maxAPlot = getPlot(dblpointsMajAxis);

                numParticlesDiameter = 0;
                equivDPlot = getPlot(dblpointsEquivDiam);

                Console.WriteLine(numParticlesDiameter.ToString());

                //Volumeofcontainer is in mL so convert to L
                //contaminationLevel = (float)(dblnumParticles[0, 0] / (VOLUMEOFCONTAINER/1000));
                contaminationLevel = (float)(numParticlesDiameter / (VOLUMEOFCONTAINER / 1000));

                gramsperL = (contaminationLevel) / particlesPerGram;
                g_per_L.Text = ((contaminationLevel) / particlesPerGram).ToString();
                particles_per_L.Text = contaminationLevel.ToString();
                particles.Text = dblnumParticles[0, 0].ToString();

                //Send data to PLC for Contamination Level
                plcClient.sendFloatValue((float)contaminationLevel, VARHANDLE_CONTLEVEL);

                //Console.Write("Area,");
                //for(int i = 0; i < dblpointsArea.GetLength(0); i++) {
                //    Console.Write(dblpointsArea[i, 0]);
                //    Console.Write(",");
                //}
                //Console.Write("\n");

                //Console.Write("MinAxis,");
                //for(int i = 0; i < dblpointsMinAxis.GetLength(0); i++) {
                //    Console.Write(dblpointsMinAxis[i, 0]);
                //    Console.Write(",");
                //}
                //Console.Write("\n");

                //Console.Write("MajAxis,");
                //for(int i = 0; i < dblpointsMajAxis.GetLength(0); i++) {
                //    Console.Write(dblpointsMajAxis[i, 0]);
                //    Console.Write(",");
                //}
                //Console.Write("\n");

                //Console.Write("EquivD,");
                for(int i = 0; i < dblpointsEquivDiam.GetLength(0); i++) {
                    //Console.Write(dblpointsEquivDiam[i, 0]);
                    //Console.Write(",");
                    if(dblpointsEquivDiam[i, 0] >= 0.1) {
                        great1_val++;
                    }
                    if(dblpointsEquivDiam[i, 0] >= 0.4) {
                        great2_val++;
                    }
                    if(dblpointsEquivDiam[i, 0] >= 1.0) {
                        great3_val++;
                    }
                }

                //Console.Write("\n");
                //Send the arrays to PLC
                plcClient.sendArray(areaPlot, 10, VARHANDLE_AREAARRAY);
                plcClient.sendArray(minAPlot, 10, VARHANDLE_MINAARRAY);
                plcClient.sendArray(maxAPlot, 10, VARHANDLE_MAXAARRAY);
                plcClient.sendArray(equivDPlot, 10, VARHANDLE_EQDARRAY);

                //Don't connect to PLC again
                checkLoop++;

                //Send to PLC
                plcClient.sendInt((Int16)checkLoop, VARHANDLE_HEARTBEAT);

                using(StreamWriter sw = File.AppendText(data_file + DateTime.Now.ToString("yyyyMMdd") + ".txt")) {
                    //sw.WriteLine("Contamination_per_mL," + DateTime.Now.ToString("h:mm:ss tt") + "," + contaminationLevel.ToString() + "," + great1_val.ToString() + "," + great2_val.ToString() + "," + great3_val.ToString());

                    //sw.WriteLine("Points>0.1," + DateTime.Now.ToString("h:mm:ss tt") + "," + great1_val.ToString());
                    //sw.WriteLine("Points>0.5," + DateTime.Now.ToString("h:mm:ss tt") + "," + great2_val.ToString());
                    //sw.WriteLine("Points>1.0," + DateTime.Now.ToString("h:mm:ss tt") + "," + great3_val.ToString());

                    sw.WriteLine("Contamination_per_L," + DateTime.Now.ToString("h:mm:ss tt") + "," + DateTime.Now.ToString("yyyyMMdd") + "," + contaminationLevel);
                    sw.WriteLine("Grams_per_L," + DateTime.Now.ToString("h:mm:ss tt") + "," + DateTime.Now.ToString("yyyyMMdd") + "," + gramsperL);

                    sw.Write("EquivD," + DateTime.Now.ToString("h:mm:ss tt") + "," + DateTime.Now.ToString("yyyyMMdd"));
                    for(int i = 0; i < 20; i++) {
                        sw.Write("," + equivDPlot[i].ToString());
                    }
                    //Write newline
                    sw.WriteLine();

                    //sw.Write("EquivD," + DateTime.Now.ToString("h:mm:ss tt"));
                    //for(int i = 0; i < dblpointsEquivDiam.GetLength(0); i++) {
                    //    sw.Write("," + dblpointsEquivDiam[i, 0]);
                    //}
                    //sw.WriteLine();

                    sw.Write("Area," + DateTime.Now.ToString("h:mm:ss tt") + "," + DateTime.Now.ToString("ddmmyyyy"));
                    for(int i = 0; i < 20; i++) {
                        sw.Write("," + areaPlot[i].ToString());
                    }
                    sw.WriteLine();

                    //    sw.Write("MinorAxis," + DateTime.Now.ToString("h:mm:ss tt"));
                    //    for (int i = 0; i < 20; i++)
                    //    {
                    //        sw.Write("," + minAPlot[i].ToString());
                    //    }
                    //    sw.WriteLine();

                    //    sw.Write("MajorAxis," + DateTime.Now.ToString("h:mm:ss tt"));
                    //    for (int i = 0; i < 20; i++)
                    //    {
                    //        sw.Write("," + maxAPlot[i].ToString());
                    //    }
                    //    sw.WriteLine();

                    sw.Close();
                }

                great1.Text = great1_val.ToString();
                great2.Text = great2_val.ToString();
                great3.Text = great3_val.ToString();

                //Dispose Matlab class
                matlabClass.Dispose();
            } else {
                //Do what you want here, this is if the camera is not connected
                memAv = (MWNumericArray)matlabArray[5];
                dblmemAv = (double[,])memAv.ToArray(MWArrayComponent.Real);

                memUs = (MWNumericArray)matlabArray[6];
                dblmemUs = (double[,])memUs.ToArray(MWArrayComponent.Real);

                memAvailable.Text = dblmemAv[0, 0].ToString();

                memUsed.Text = dblmemUs[0, 0].ToString();

                matlabClass.Dispose();
            }
        }

        //Rename all Pictures
        private void RenamePics() {
            int i;
                for(i = MAXPICTURES; i > 1; i--) {
                    System.IO.File.Delete((MAXPICTURES - i).ToString() + "_raw.jpeg");
                    System.IO.File.Delete((MAXPICTURES - i).ToString() + "_proc.jpeg");
                    System.IO.File.Move((MAXPICTURES - (i - 1)).ToString() + "_raw.jpeg", (MAXPICTURES - i).ToString() + "_raw.jpeg");
                    System.IO.File.Move((MAXPICTURES - (i - 1)).ToString() + "_proc.jpeg", (MAXPICTURES - i).ToString() + "_proc.jpeg");
                }
        }

        //Display image
        private Image GetCopyImage(string path) {
            using(Image im = Image.FromFile(path)) {
                Bitmap bm = new Bitmap(im);
                return bm;
            }
        }

        //Scrolling Event
        private void hScroller_Scroll(object sender, ScrollEventArgs e) {
            if(String.Compare(e.Type.ToString(), "EndScroll") == 0) {
                //Matlab_time.Text = Scroll_pics.Value.ToString();

                Image im = GetCopyImage(Scroll_pics.Value + "_raw.jpeg");
                raw_img.Image = im;

                Image im2 = GetCopyImage(Scroll_pics.Value + "_proc.jpeg");
                proc_img.Image = im2;

            }
        }

        //Set values for load
        private void VisionSensorScreen_Load_1(object sender, EventArgs e) {
            Scroll_pics.Minimum = 0;
            Scroll_pics.Maximum = MAXPICTURES + 8;

            Scroll_pics.Scroll += new System.Windows.Forms.ScrollEventHandler(hScroller_Scroll);

            RefreshMatlab.Start();

            //The bottom removes the minimize bar, etc.
            //this.Text = string.Empty;
            //this.ControlBox = false;
            //this.FormBorderStyle = FormBorderStyle.None;
            this.BackColor = Color.LightGray;
        }

        private void exit_btn_Click_1(object sender, EventArgs e) {
            this.Close();
        }

        //Button to go back to Kex-C
        private void Return_KexC_Click(object sender, EventArgs e) {
            //Reset the picture value back to 0
            pictureName = 0;

            try {
                Process[] procs = Process.GetProcesses();
                foreach(Process theProcess in procs) {
                    ShowWindow(theProcess.MainWindowHandle, 2);
                }
                foreach(Process theProcess in procs) {
                    if(theProcess.ProcessName.ToUpper().Contains("KEX-C-AQ")) {
                        ShowWindow(theProcess.MainWindowHandle, 9);
                    }
                }
            } catch(Exception ex) {
                Console.WriteLine(ex.Message);
            }
        }

        private void Start_btn_Click(object sender, EventArgs e) {
            //User has opted not to show pictures
            if(viewPics == true) {
                viewPics = false;
                Start_btn.Text = "Start";
                retainInfo = false;
            }
                //User has selected to view pictures
            else {
                Start_btn.Text = "Pause";
                viewPics = true;
                retainInfo = true;
            }
        }

        private void stopBtn_Click(object sender, EventArgs e) {
            RefreshMatlab.Stop();
        }

        private void plotHist_Click(object sender, EventArgs e) {

            string time_entered;
            string[] split_times1;
            string[] split_times2;
            string[] split_file1;
            string[] split_file2;
            string[] split_file3;
            string line;

            string[] seriesArray = {"0.4-0.5", "0.5-0.6",
                                   "0.6-0.7", "0.7-0.8",
                                   "0.8-0.9", "0.9-1.0",
                                   "1.0-1.1", "1.1-1.2",
                                   "1.2-1.3", "1.3-1.4",
                                   "1.4-1.5"};

            //Declare series
            Series series;

            //Get time entered - this is case sensitive and looks like "5:45 PM" or "3:12 PM" (ie. "x:xx (PM|AM)")
            time_entered = time.Text;

            //Copy File to use
            File.Copy(data_file + DateTime.Now.ToString("yyyyMMdd") + ".txt",
                data_file + DateTime.Now.ToString("yyyyMMdd") + "Histogram" + ".txt",
                true);

            //Removes all elements
            hist_plot.Series.Clear();

            //Create new Series
            series = new Series {
                Name = "particleDist"
            };

            //Add the series
            hist_plot.Series.Add(series);

            //Display all x-axis labels
            hist_plot.ChartAreas["ChartArea1"].AxisX.Interval = 1;

            //Set X and Y Axis Titles
            hist_plot.ChartAreas["ChartArea1"].AxisX.Title = "Size Range (mm)";
            hist_plot.ChartAreas["ChartArea1"].AxisY.Title = "Number of Particles";

            //Check if null
            if(time_entered != "") {
                if(!(Regex.IsMatch(time_entered, @"\d:\d\d ((PM)|(AM))"))) {
                    Console.WriteLine("Not correct");
                } 
                else {
                    split_times1 = time_entered.Split(' ');         //Contains [5:05:45,PM]
                    split_times2 = split_times1[0].Split(':');      //Contains [5,05,45]

                    System.IO.StreamReader file = 
                        new System.IO.StreamReader(data_file + DateTime.Now.ToString("yyyyMMdd") + "Histogram" + ".txt");

                    while((line = file.ReadLine()) != null) {
                        split_file1 = line.Split(',');                  //Contains [EquivD,5:05:45 PM,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]
                        if(String.Compare(split_file1[0], "EquivD") == 0) {
                            split_file2 = split_file1[1].Split(' ');    //Contains [5:05:45,PM]
                            split_file3 = split_file2[0].Split(':');    //Contains [5,05,45]

                            if (String.Compare(split_times1[1],split_file2[1]) == 0 &&      //Compare PM or AM
                                String.Compare(split_times2[0],split_file3[0]) == 0 &&      //Compare hour (5)
                                String.Compare(split_times2[1],split_file3[1]) == 0)        //Compare minute (05)
                            {
                                Console.WriteLine(line);
                                for(int i = 0; i < range.Length; i++) {
                                    //Add series to chart - "i + 6" corresponds to the 0.4-0.5 range
                                    Console.WriteLine(Convert.ToInt32(split_file1[i + 7]));
                                    series.Points.AddXY(seriesArray[i], Convert.ToInt32(split_file1[i + 7]));
                                }
                                break;
                            }
                        }
                    }
                    file.Close();
                }
            }
        }

        private void plotGrams_Click(object sender, EventArgs e) {

            string[] split_file1;
            string line;

            //Declare series
            Series series;

            //Copy File to use
            File.Copy(data_file + DateTime.Now.ToString("yyyyMMdd") + ".txt",
                data_file + DateTime.Now.ToString("yyyyMMdd") + "Grams" + ".txt",
                true);

            //Removes all elements
            grams_plot.Series.Clear();

            //Create new Series
            series = new Series {
                Name = "particleDist"
            };

            series.ChartType = SeriesChartType.Line;

            //Add the series
            grams_plot.Series.Add(series);

            //Set X and Y Axis Titles
            grams_plot.ChartAreas["ChartArea1"].AxisX.Title = "Time";
            grams_plot.ChartAreas["ChartArea1"].AxisY.Title = "Grams/L";

            grams_plot.ChartAreas["ChartArea1"].AxisY.Minimum = 0;
            grams_plot.ChartAreas["ChartArea1"].AxisY.Maximum = 2;

            System.IO.StreamReader file =
                        new System.IO.StreamReader(data_file + DateTime.Now.ToString("yyyyMMdd") + "Grams" + ".txt");

            while((line = file.ReadLine()) != null) {
                split_file1 = line.Split(',');                  //Contains [EquivD,5:05:45 PM,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]
                if(String.Compare(split_file1[0], "Grams_per_L") == 0) {
                    Console.WriteLine(split_file1[1].ToString());
                    series.Points.AddXY(split_file1[1].ToString(), Convert.ToDouble(split_file1[3]));
                }
            }
            file.Close();

        }

        private void proc_img_Click(object sender, EventArgs e)
        {

        }
    }
}
