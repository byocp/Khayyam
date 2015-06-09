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

namespace VisionSensor
{
    public partial class VisionSensorScreen : Form
    {
        public VisionSensorScreen()
        {
            InitializeComponent();
        }
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

        //Weights of particles per L 

        //Storing Area, MinAxis, MajAxis, EquivDiam, ParticlesNum
        private MWNumericArray numParticles, gramsperL, numperL;
        private Double[,] dblnumParticles, dblgramsperL, dblnumperL;

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

        private float numperLFloat;

        //Control picture number
        private int pictureName;

        //Control fixed file name
        //private string fileNameToRead = "F:\\vision_sensor\\particle_counter\\samples\\1";

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
        private float VOLUMEOFCONTAINER;

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

        //Split words
        private string[] split_Words;

        //Number of particles in range specified by user - this is used to calculate Grams/L
        private int numParticlesDiameter;

        //Data file for output
        private string data_file = "C:\\Users\\Minghua\\Desktop\\Contamination-data\\";

        //used to store location to save pictures
        private string picturesLocation = "C:\\Users\\Minghua\\Desktop\\copied_pictures\\";

        string[] range = new string[11];

        //Checks if the application is in focus
        public static bool ApplicationIsActivated()
        {
            var activatedHandle = GetForegroundWindow();
            if (activatedHandle == IntPtr.Zero)
            {
                return false;       // No window is currently activated
            }

            var procId = Process.GetCurrentProcess().Id;
            int activeProcId;
            GetWindowThreadProcessId(activatedHandle, out activeProcId);

            return activeProcId == procId;
        }

        //Return Histogram
        private Int16[] getPlot(Double[,] input)
        {
            Int16[] histogram = new Int16[20] { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
                                                0, 0, 0, 0, 0, 0, 0, 0, 0, 0};

            int i;

            for (i = 0; i < input.GetLength(0); i++)
            {
                numParticlesDiameter++;
                if (input[i, 0] > 0 && input[i, 0] <= 0.1)
                {
                    histogram[0]++;
                }
                else if (input[i, 0] > 0.1 && input[i, 0] <= 0.2)
                {
                    histogram[1]++;
                }
                else if (input[i, 0] > 0.2 && input[i, 0] <= 0.3)
                {
                    histogram[2]++;
                }
                else if (input[i, 0] > 0.3 && input[i, 0] <= 0.4)
                {
                    histogram[3]++;
                }
                else if (input[i, 0] > 0.4 && input[i, 0] < 0.5)
                {
                    histogram[4]++;
                }
                else if (input[i, 0] > 0.5 && input[i, 0] < 0.6)
                {
                    histogram[5]++;
                }
                else if (input[i, 0] > 0.6 && input[i, 0] < 0.7)
                {
                    histogram[6]++;
                }
                else if (input[i, 0] > 0.7 && input[i, 0] < 0.8)
                {
                    histogram[7]++;
                }
                else if (input[i, 0] > 0.8 && input[i, 0] < 0.9)
                {
                    histogram[8]++;
                }
                else if (input[i, 0] > 0.9 && input[i, 0] < 1.0)
                {
                    histogram[9]++;
                }
                else if (input[i, 0] > 1.0 && input[i, 0] < 1.1)
                {
                    histogram[10]++;
                }
                else if (input[i, 0] > 1.1 && input[i, 0] < 1.2)
                {
                    histogram[11]++;
                }
                else if (input[i, 0] > 1.2 && input[i, 0] < 1.3)
                {
                    histogram[12]++;
                }
                else if (input[i, 0] > 1.3 && input[i, 0] < 1.4)
                {
                    histogram[13]++;
                }
                else if (input[i, 0] > 1.4 && input[i, 0] < 1.5)
                {
                    histogram[14]++;
                }
                else if (input[i, 0] > 1.5 && input[i, 0] < 1.6)
                {
                    histogram[15]++;
                }
                else if (input[i, 0] > 1.6 && input[i, 0] < 1.7)
                {
                    histogram[16]++;
                }
                else if (input[i, 0] > 1.7 && input[i, 0] < 1.8)
                {
                    histogram[17]++;
                }
                else if (input[i, 0] > 1.8 && input[i, 0] < 1.9)
                {
                    histogram[18]++;
                }
                else if (input[i, 0] > 1.9 && input[i, 0] < 2.0)
                {
                    histogram[19]++;
                }
            }
            return histogram;
        }

        //Refresh Screen
        private void RefreshMatlab_Tick(object sender, EventArgs e)
        {
            //Values for Particles > 0.1, P > 0.4, P > 1.0
            great1_val = 0;
            great2_val = 0;
            great3_val = 0;

            //set the numParticlesDiameter to 0
            numParticlesDiameter = 0;

            //Start Time
            //startTime = DateTime.Now;

            //Create new matlabClass and call main function
            matlabClass = new MyMatClass();

            //If Application is activated and pictures are active
            if (ApplicationIsActivated() && viewPics == true)
            {
                raw_img.SizeMode = PictureBoxSizeMode.StretchImage;
                proc_img.SizeMode = PictureBoxSizeMode.StretchImage;
                if ((pictureName == (MAXPICTURES - 1)) && (File.Exists("9_raw.jpeg")))
                {
                    RenamePics();
                }
            }

            //If application is not activated, pictures are not activated
            if (!ApplicationIsActivated())
            {
                viewPics = false;
            }
            else
            {
                //If it is activated and user has opted to show images once before
                if (retainInfo == true)
                {
                    viewPics = true;
                }
                else
                {
                    viewPics = false;
                }
            }

            //If user has opted to show images, then send matlab command to display images
            // temp change = pictureName.ToString()
            if (viewPics == true)
            {
                matlabArray = matlabClass.main(9, pictureName.ToString(), "true");
            }
            else
            {
                matlabArray = matlabClass.main(9, pictureName.ToString(), "false");
            }

            //End of matlab processing
            //endTime_Matlab = DateTime.Now;

            ////Time difference
            //ts = endTime_Matlab - startTime;

            //Allocate numParticles
            numParticles = (MWNumericArray)matlabArray[4];
            dblnumParticles = (double[,])numParticles.ToArray(MWArrayComponent.Real);

            //If there are particles
            if (dblnumParticles[0, 0] != -1)
            {
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

                gramsperL = (MWNumericArray)matlabArray[7];
                dblgramsperL = (double[,])gramsperL.ToArray(MWArrayComponent.Real);

                numperL = (MWNumericArray)matlabArray[8];
                dblnumperL = (double[,])numperL.ToArray(MWArrayComponent.Real);

                memAvailable.Text = dblmemAv[0, 0].ToString();
                memUsed.Text = (dblmemUs[0, 0] / 10).ToString();

                if (ApplicationIsActivated() && viewPics == true)
                {
                    //Change ScrollBar value
                    if (pictureName > 0)
                    {
                        Scroll_pics.Value = pictureName;
                    }

                    //pictureName = 1;

                    //Display Images
                    //if(File.Exists("F:\\vision_sensor\\particle_counter\\samples\\" + pictureName.ToString() + "_raw.jpeg")) {
                    //    Image im1 = GetCopyImage("F:\\vision_sensor\\particle_counter\\samples\\" + pictureName.ToString() + "_raw.jpeg");
                    //    raw_img.Image = im1;
                    //}
                    //if (File.Exists("F:\\vision_sensor\\particle_counter\\samples\\" + pictureName.ToString() + "_proc.jpeg"))
                    //{
                    //    Image im2 = GetCopyImage("F:\\vision_sensor\\particle_counter\\samples\\" + pictureName.ToString() + "_proc.jpeg");
                    //    proc_img.Image = im2;
                    //}

                    if (File.Exists(pictureName.ToString() + "_raw.jpeg"))
                    {
                        Image im1 = GetCopyImage(pictureName.ToString() + "_raw.jpeg");
                        raw_img.Image = im1;
                    }
                    if (File.Exists(pictureName.ToString() + "_proc.jpeg"))
                    {
                        Image im2 = GetCopyImage(pictureName.ToString() + "_proc.jpeg");
                        proc_img.Image = im2;
                    }

                    //Display Image you are on
                    Pic_num.Text = Scroll_pics.Value.ToString();

                    //File.Copy(pictureName.ToString() + "_raw.jpeg",
                    //    picturesLocation + pictureName.ToString() + "_raw" + DateTime.Now.ToString("HHmmss") + ".jpeg",
                    //    true)g;
                    //File.Copy(pictureName.ToString() + "_proc.jpeg",
                    //    picturesLocation + pictureName.ToString() + "_proc" + DateTime.Now.ToString("HHmmss") + ".jpeg",
                    //    true);

                    //Increment Image value
                    if (pictureName != (MAXPICTURES - 1))
                    {
                        pictureName++;
                    }
                }

                //PLC Information - needs to be uncommented
                if (checkLoop == 0)
                {
                    plcClient = new PlcClient();
                    plcClient.Connect();
                }

                // Initialize Histogram
                areaPlot = new Int16[20] { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
                                           0, 0, 0, 0, 0, 0, 0, 0, 0, 0 };
                minAPlot = new Int16[20] { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
                                           0, 0, 0, 0, 0, 0, 0, 0, 0, 0 };
                maxAPlot = new Int16[20] { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
                                           0, 0, 0, 0, 0, 0, 0, 0, 0, 0};
                equivDPlot = new Int16[20] { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
                                             0, 0, 0, 0, 0, 0, 0, 0, 0, 0 };

                //Get Plots for Values
                areaPlot = getPlot(dblpointsArea);
                minAPlot = getPlot(dblpointsMinAxis);
                maxAPlot = getPlot(dblpointsMajAxis);
                equivDPlot = getPlot(dblpointsEquivDiam);

                Console.WriteLine(numParticles.ToString());

                numperLFloat = (float)dblnumperL[0, 0];
                // write on the HMI
                g_per_L.Text = (dblgramsperL[0, 0]).ToString();
                particles_per_L.Text = (dblnumperL[0, 0]).ToString();
                particles.Text = (dblnumParticles[0, 0]).ToString();

                //Send data to PLC for Contamination Level
                plcClient.sendFloatValue((float)numperLFloat, VARHANDLE_CONTLEVEL);

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
                for (int i = 0; i < dblpointsEquivDiam.GetLength(1); i++)
                {
                    //Console.Write(dblpointsEquivDiam[i, 0]);
                    //Console.Write(",");
                    if (dblpointsEquivDiam[0, i] >= 0.1)
                    {
                        great1_val++;
                    }
                    if (dblpointsEquivDiam[0, i] >= 0.4)
                    {
                        great2_val++;
                    }
                    if (dblpointsEquivDiam[0, i] >= 1.0)
                    {
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


                //Arcive in .txt file
                using (StreamWriter sw = File.AppendText(data_file + DateTime.Now.ToString("yyyyMMdd") + ".txt"))
                {
                    sw.WriteLine(DateTime.Now.ToString("h:mm:ss tt") + "," + DateTime.Now.ToString("yyyyMMdd"));
                    sw.WriteLine("Contamination per sample," + numperL.ToString());
                    sw.WriteLine("Points>0.1," +  great1_val.ToString());
                    sw.WriteLine("Points>0.5," +  great2_val.ToString());
                    sw.WriteLine("Points>1.0," +  great3_val.ToString());
                    sw.WriteLine("Number_per_L" + "," + numperL);
                    sw.WriteLine("Grams_per_L" + "," + gramsperL);
                    sw.Write("EquivD");
                    for (int i = 0; i < 20; i++)
                    {
                        sw.Write("," + equivDPlot[i].ToString());
                    }

                    //Write newline
                    sw.WriteLine();
                    //Equiv Diameter
                    sw.Write("EquivD");
                    for (int i = 0; i < dblpointsEquivDiam.GetLength(0); i++)
                    {
                        sw.Write("," + dblpointsEquivDiam[i, 0]);
                    }
                    sw.WriteLine();
                    // Area
                    sw.Write("Area");
                    for (int i = 0; i < 20; i++)
                    {
                        sw.Write("," + areaPlot[i].ToString());
                    }
                    sw.WriteLine();

                    // MinorAxis
                    //sw.Write("MinorAxis," + DateTime.Now.ToString("h:mm:ss tt"));
                    //for (int i = 0; i < 20; i++)
                    //{
                    //    sw.Write("," + minAPlot[i].ToString());
                    //}
                    //sw.WriteLine();
                    //// MajorAxis
                    //sw.Write("MajorAxis," + DateTime.Now.ToString("h:mm:ss tt"));
                    //for (int i = 0; i < 20; i++)
                    //{
                    //    sw.Write("," + maxAPlot[i].ToString());
                    //}
                    //sw.WriteLine();

                    // Close
                    sw.Close();
                }

                great1.Text = great1_val.ToString();
                great2.Text = great2_val.ToString();
                great3.Text = great3_val.ToString();

                //Dispose Matlab class
                matlabClass.Dispose();
            }
            else
            {
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
        private void RenamePics()
        {
            int i;
            for (i = MAXPICTURES; i > 1; i--)
            {
                System.IO.File.Delete((MAXPICTURES - i).ToString() + "_raw.jpeg");
                System.IO.File.Delete((MAXPICTURES - i).ToString() + "_proc.jpeg");
                System.IO.File.Move((MAXPICTURES - (i - 1)).ToString() + "_raw.jpeg", (MAXPICTURES - i).ToString() + "_raw.jpeg");
                System.IO.File.Move((MAXPICTURES - (i - 1)).ToString() + "_proc.jpeg", (MAXPICTURES - i).ToString() + "_proc.jpeg");
            }
        }

        //Display image
        private Image GetCopyImage(string path)
        {
            using (Image im = Image.FromFile(path))
            {
                Bitmap bm = new Bitmap(im);
                return bm;
            }
        }

        //Scrolling Event
        private void hScroller_Scroll(object sender, ScrollEventArgs e)
        {
            if (String.Compare(e.Type.ToString(), "EndScroll") == 0)
            {
                //Matlab_time.Text = Scroll_pics.Value.ToString();

                Image im = GetCopyImage(Scroll_pics.Value + "_raw.jpeg");
                raw_img.Image = im;

                Image im2 = GetCopyImage(Scroll_pics.Value + "_proc.jpeg");
                proc_img.Image = im2;

            }
        }

        //Set values for load
        private void VisionSensorScreen_Load_1(object sender, EventArgs e)
        {
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

        private void exit_btn_Click_1(object sender, EventArgs e)
        {
            this.Close();
        }

        //Button to go back to Kex-C
        private void Return_KexC_Click(object sender, EventArgs e)
        {
            //Reset the picture value back to 0
            pictureName = 0;

            try
            {
                Process[] procs = Process.GetProcesses();
                foreach (Process theProcess in procs)
                {
                    ShowWindow(theProcess.MainWindowHandle, 2);
                }
                foreach (Process theProcess in procs)
                {
                    if (theProcess.ProcessName.ToUpper().Contains("KEX-C-AQ"))
                    {
                        ShowWindow(theProcess.MainWindowHandle, 9);
                    }
                }
            }
            catch (Exception ex)
            {
                Console.WriteLine(ex.Message);
            }
        }

        private void Start_btn_Click(object sender, EventArgs e)
        {
            //User has opted not to show pictures
            if (viewPics == true)
            {
                viewPics = false;
                Start_btn.Text = "Start";
                retainInfo = false;
            }
            //User has selected to view pictures
            else
            {
                Start_btn.Text = "Pause";
                viewPics = true;
                retainInfo = true;
            }
        }

        private void stopBtn_Click(object sender, EventArgs e)
        {
            RefreshMatlab.Stop();
        }

        private void VisionSensorScreen_Load(object sender, EventArgs e)
        {

        }

    }



}
