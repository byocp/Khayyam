using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace VisionSensor {
    static class Program {
        /// <summary>
        /// The main entry point for the application.
        /// </summary>
        [STAThread]
        static void Main() {
            Application.EnableVisualStyles();
            Application.SetCompatibleTextRenderingDefault(false);
            //Uncomment the bottom to get the screen without the histogram plot
            Application.Run(new VisionSensorScreen());

            //Uncomment the bottom to get the screen with the histogram plot
            //Application.Run(new VisionSensorScreenPlot());
        }
    }
}
