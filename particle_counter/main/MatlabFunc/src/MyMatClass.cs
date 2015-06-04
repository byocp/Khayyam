/*
* MATLAB Compiler: 4.18.1 (R2013a)
* Date: Wed Jun 03 16:22:57 2015
* Arguments: "-B" "macro_default" "-W" "dotnet:MatlabFunc,MyMatClass,0.0,private" "-T"
* "link:lib" "-d"
* "C:\Users\Minghua\Desktop\vision_sensor_pedram\particle_counter\main\MatlabFunc\src"
* "-w" "enable:specified_file_mismatch" "-w" "enable:repeated_file" "-w"
* "enable:switch_ignored" "-w" "enable:missing_lib_sentinel" "-w" "enable:demo_license"
* "-v"
* "class{MyMatClass:C:\Users\Minghua\Desktop\vision_sensor_pedram\particle_counter\main\au
* tomated_frame_capture.m,C:\Users\Minghua\Desktop\vision_sensor_pedram\particle_counter\m
* ain\digital_filtering.m,C:\Users\Minghua\Desktop\vision_sensor_pedram\particle_counter\m
* ain\digital_filtering_boost.m,C:\Users\Minghua\Desktop\vision_sensor_pedram\particle_cou
* nter\main\historian.m,C:\Users\Minghua\Desktop\vision_sensor_pedram\particle_counter\mai
* n\image_initialization.m,C:\Users\Minghua\Desktop\vision_sensor_pedram\particle_counter\
* main\is_this_bubble.m,C:\Users\Minghua\Desktop\vision_sensor_pedram\particle_counter\mai
* n\load_config.m,C:\Users\Minghua\Desktop\vision_sensor_pedram\particle_counter\main\Lume
* nera Matlab Driver V2.0.1 NEW 64
* Bit\LucamCameraClose.m,C:\Users\Minghua\Desktop\vision_sensor_pedram\particle_counter\ma
* in\Lumenera Matlab Driver V2.0.1 NEW 64
* Bit\LucamCameraOpen.m,C:\Users\Minghua\Desktop\vision_sensor_pedram\particle_counter\mai
* n\Lumenera Matlab Driver V2.0.1 NEW 64
* Bit\LucamSetGain.m,C:\Users\Minghua\Desktop\vision_sensor_pedram\particle_counter\main\L
* umenera Matlab Driver V2.0.1 NEW 64
* Bit\LucamSetSnapshotExposure.m,C:\Users\Minghua\Desktop\vision_sensor_pedram\particle_co
* unter\main\Lumenera Matlab Driver V2.0.1 NEW 64
* Bit\LucamTakeSnapshot.m,C:\Users\Minghua\Desktop\vision_sensor_pedram\particle_counter\m
* ain\main.m,C:\Users\Minghua\Desktop\vision_sensor_pedram\particle_counter\main\particle_
* counter.m}" 
*/
using System;
using System.Reflection;
using System.IO;
using MathWorks.MATLAB.NET.Arrays;
using MathWorks.MATLAB.NET.Utility;

#if SHARED
[assembly: System.Reflection.AssemblyKeyFile(@"")]
#endif

namespace MatlabFunc
{

  /// <summary>
  /// The MyMatClass class provides a CLS compliant, MWArray interface to the MATLAB
  /// functions contained in the files:
  /// <newpara></newpara>
  /// C:\Users\Minghua\Desktop\vision_sensor_pedram\particle_counter\main\automated_frame_
  /// capture.m
  /// <newpara></newpara>
  /// C:\Users\Minghua\Desktop\vision_sensor_pedram\particle_counter\main\digital_filterin
  /// g.m
  /// <newpara></newpara>
  /// C:\Users\Minghua\Desktop\vision_sensor_pedram\particle_counter\main\digital_filterin
  /// g_boost.m
  /// <newpara></newpara>
  /// C:\Users\Minghua\Desktop\vision_sensor_pedram\particle_counter\main\historian.m
  /// <newpara></newpara>
  /// C:\Users\Minghua\Desktop\vision_sensor_pedram\particle_counter\main\image_initializa
  /// tion.m
  /// <newpara></newpara>
  /// C:\Users\Minghua\Desktop\vision_sensor_pedram\particle_counter\main\is_this_bubble.m
  /// <newpara></newpara>
  /// C:\Users\Minghua\Desktop\vision_sensor_pedram\particle_counter\main\load_config.m
  /// <newpara></newpara>
  /// C:\Users\Minghua\Desktop\vision_sensor_pedram\particle_counter\main\Lumenera Matlab
  /// Driver V2.0.1 NEW 64 Bit\LucamCameraClose.m
  /// <newpara></newpara>
  /// C:\Users\Minghua\Desktop\vision_sensor_pedram\particle_counter\main\Lumenera Matlab
  /// Driver V2.0.1 NEW 64 Bit\LucamCameraOpen.m
  /// <newpara></newpara>
  /// C:\Users\Minghua\Desktop\vision_sensor_pedram\particle_counter\main\Lumenera Matlab
  /// Driver V2.0.1 NEW 64 Bit\LucamSetGain.m
  /// <newpara></newpara>
  /// C:\Users\Minghua\Desktop\vision_sensor_pedram\particle_counter\main\Lumenera Matlab
  /// Driver V2.0.1 NEW 64 Bit\LucamSetSnapshotExposure.m
  /// <newpara></newpara>
  /// C:\Users\Minghua\Desktop\vision_sensor_pedram\particle_counter\main\Lumenera Matlab
  /// Driver V2.0.1 NEW 64 Bit\LucamTakeSnapshot.m
  /// <newpara></newpara>
  /// C:\Users\Minghua\Desktop\vision_sensor_pedram\particle_counter\main\main.m
  /// <newpara></newpara>
  /// C:\Users\Minghua\Desktop\vision_sensor_pedram\particle_counter\main\particle_counter
  /// .m
  /// <newpara></newpara>
  /// deployprint.m
  /// <newpara></newpara>
  /// printdlg.m
  /// </summary>
  /// <remarks>
  /// @Version 0.0
  /// </remarks>
  public class MyMatClass : IDisposable
  {
    #region Constructors

    /// <summary internal= "true">
    /// The static constructor instantiates and initializes the MATLAB Compiler Runtime
    /// instance.
    /// </summary>
    static MyMatClass()
    {
      if (MWMCR.MCRAppInitialized)
      {
        try
        {
          Assembly assembly= Assembly.GetExecutingAssembly();

          string ctfFilePath= assembly.Location;

          int lastDelimiter= ctfFilePath.LastIndexOf(@"\");

          ctfFilePath= ctfFilePath.Remove(lastDelimiter, (ctfFilePath.Length - lastDelimiter));

          string ctfFileName = "MatlabFunc.ctf";

          Stream embeddedCtfStream = null;

          String[] resourceStrings = assembly.GetManifestResourceNames();

          foreach (String name in resourceStrings)
          {
            if (name.Contains(ctfFileName))
            {
              embeddedCtfStream = assembly.GetManifestResourceStream(name);
              break;
            }
          }
          mcr= new MWMCR("",
                         ctfFilePath, embeddedCtfStream, true);
        }
        catch(Exception ex)
        {
          ex_ = new Exception("MWArray assembly failed to be initialized", ex);
        }
      }
      else
      {
        ex_ = new ApplicationException("MWArray assembly could not be initialized");
      }
    }


    /// <summary>
    /// Constructs a new instance of the MyMatClass class.
    /// </summary>
    public MyMatClass()
    {
      if(ex_ != null)
      {
        throw ex_;
      }
    }


    #endregion Constructors

    #region Finalize

    /// <summary internal= "true">
    /// Class destructor called by the CLR garbage collector.
    /// </summary>
    ~MyMatClass()
    {
      Dispose(false);
    }


    /// <summary>
    /// Frees the native resources associated with this object
    /// </summary>
    public void Dispose()
    {
      Dispose(true);

      GC.SuppressFinalize(this);
    }


    /// <summary internal= "true">
    /// Internal dispose function
    /// </summary>
    protected virtual void Dispose(bool disposing)
    {
      if (!disposed)
      {
        disposed= true;

        if (disposing)
        {
          // Free managed resources;
        }

        // Free native resources
      }
    }


    #endregion Finalize

    #region Methods

    /// <summary>
    /// Provides a single output, 0-input MWArrayinterface to the automated_frame_capture
    /// MATLAB function.
    /// </summary>
    /// <remarks>
    /// M-Documentation:
    /// This function set the minimal camera parameters using the API functions
    /// lucam_set_gain: 11.5
    /// lucam_set_snapshot_exposure: 0.5
    /// Two unused, useful Lucam API commands:
    /// (a) LucamGetExposure(cam);
    /// (b) LucamGetGain(cam);
    /// (c) LucamCaptureSaveFrame(strcat('rawfr',i,'.bmp'),false,1);
    /// </remarks>
    /// <returns>An MWArray containing the first output argument.</returns>
    ///
    public MWArray automated_frame_capture()
    {
      return mcr.EvaluateFunction("automated_frame_capture", new MWArray[]{});
    }


    /// <summary>
    /// Provides a single output, 1-input MWArrayinterface to the automated_frame_capture
    /// MATLAB function.
    /// </summary>
    /// <remarks>
    /// M-Documentation:
    /// This function set the minimal camera parameters using the API functions
    /// lucam_set_gain: 11.5
    /// lucam_set_snapshot_exposure: 0.5
    /// Two unused, useful Lucam API commands:
    /// (a) LucamGetExposure(cam);
    /// (b) LucamGetGain(cam);
    /// (c) LucamCaptureSaveFrame(strcat('rawfr',i,'.bmp'),false,1);
    /// </remarks>
    /// <param name="snapshot_exposure">Input argument #1</param>
    /// <returns>An MWArray containing the first output argument.</returns>
    ///
    public MWArray automated_frame_capture(MWArray snapshot_exposure)
    {
      return mcr.EvaluateFunction("automated_frame_capture", snapshot_exposure);
    }


    /// <summary>
    /// Provides a single output, 2-input MWArrayinterface to the automated_frame_capture
    /// MATLAB function.
    /// </summary>
    /// <remarks>
    /// M-Documentation:
    /// This function set the minimal camera parameters using the API functions
    /// lucam_set_gain: 11.5
    /// lucam_set_snapshot_exposure: 0.5
    /// Two unused, useful Lucam API commands:
    /// (a) LucamGetExposure(cam);
    /// (b) LucamGetGain(cam);
    /// (c) LucamCaptureSaveFrame(strcat('rawfr',i,'.bmp'),false,1);
    /// </remarks>
    /// <param name="snapshot_exposure">Input argument #1</param>
    /// <param name="gain">Input argument #2</param>
    /// <returns>An MWArray containing the first output argument.</returns>
    ///
    public MWArray automated_frame_capture(MWArray snapshot_exposure, MWArray gain)
    {
      return mcr.EvaluateFunction("automated_frame_capture", snapshot_exposure, gain);
    }


    /// <summary>
    /// Provides the standard 0-input MWArray interface to the automated_frame_capture
    /// MATLAB function.
    /// </summary>
    /// <remarks>
    /// M-Documentation:
    /// This function set the minimal camera parameters using the API functions
    /// lucam_set_gain: 11.5
    /// lucam_set_snapshot_exposure: 0.5
    /// Two unused, useful Lucam API commands:
    /// (a) LucamGetExposure(cam);
    /// (b) LucamGetGain(cam);
    /// (c) LucamCaptureSaveFrame(strcat('rawfr',i,'.bmp'),false,1);
    /// </remarks>
    /// <param name="numArgsOut">The number of output arguments to return.</param>
    /// <returns>An Array of length "numArgsOut" containing the output
    /// arguments.</returns>
    ///
    public MWArray[] automated_frame_capture(int numArgsOut)
    {
      return mcr.EvaluateFunction(numArgsOut, "automated_frame_capture", new MWArray[]{});
    }


    /// <summary>
    /// Provides the standard 1-input MWArray interface to the automated_frame_capture
    /// MATLAB function.
    /// </summary>
    /// <remarks>
    /// M-Documentation:
    /// This function set the minimal camera parameters using the API functions
    /// lucam_set_gain: 11.5
    /// lucam_set_snapshot_exposure: 0.5
    /// Two unused, useful Lucam API commands:
    /// (a) LucamGetExposure(cam);
    /// (b) LucamGetGain(cam);
    /// (c) LucamCaptureSaveFrame(strcat('rawfr',i,'.bmp'),false,1);
    /// </remarks>
    /// <param name="numArgsOut">The number of output arguments to return.</param>
    /// <param name="snapshot_exposure">Input argument #1</param>
    /// <returns>An Array of length "numArgsOut" containing the output
    /// arguments.</returns>
    ///
    public MWArray[] automated_frame_capture(int numArgsOut, MWArray snapshot_exposure)
    {
      return mcr.EvaluateFunction(numArgsOut, "automated_frame_capture", snapshot_exposure);
    }


    /// <summary>
    /// Provides the standard 2-input MWArray interface to the automated_frame_capture
    /// MATLAB function.
    /// </summary>
    /// <remarks>
    /// M-Documentation:
    /// This function set the minimal camera parameters using the API functions
    /// lucam_set_gain: 11.5
    /// lucam_set_snapshot_exposure: 0.5
    /// Two unused, useful Lucam API commands:
    /// (a) LucamGetExposure(cam);
    /// (b) LucamGetGain(cam);
    /// (c) LucamCaptureSaveFrame(strcat('rawfr',i,'.bmp'),false,1);
    /// </remarks>
    /// <param name="numArgsOut">The number of output arguments to return.</param>
    /// <param name="snapshot_exposure">Input argument #1</param>
    /// <param name="gain">Input argument #2</param>
    /// <returns>An Array of length "numArgsOut" containing the output
    /// arguments.</returns>
    ///
    public MWArray[] automated_frame_capture(int numArgsOut, MWArray snapshot_exposure, 
                                       MWArray gain)
    {
      return mcr.EvaluateFunction(numArgsOut, "automated_frame_capture", snapshot_exposure, gain);
    }


    /// <summary>
    /// Provides an interface for the automated_frame_capture function in which the input
    /// and output
    /// arguments are specified as an array of MWArrays.
    /// </summary>
    /// <remarks>
    /// This method will allocate and return by reference the output argument
    /// array.<newpara></newpara>
    /// M-Documentation:
    /// This function set the minimal camera parameters using the API functions
    /// lucam_set_gain: 11.5
    /// lucam_set_snapshot_exposure: 0.5
    /// Two unused, useful Lucam API commands:
    /// (a) LucamGetExposure(cam);
    /// (b) LucamGetGain(cam);
    /// (c) LucamCaptureSaveFrame(strcat('rawfr',i,'.bmp'),false,1);
    /// </remarks>
    /// <param name="numArgsOut">The number of output arguments to return</param>
    /// <param name= "argsOut">Array of MWArray output arguments</param>
    /// <param name= "argsIn">Array of MWArray input arguments</param>
    ///
    public void automated_frame_capture(int numArgsOut, ref MWArray[] argsOut, MWArray[] 
                              argsIn)
    {
      mcr.EvaluateFunction("automated_frame_capture", numArgsOut, ref argsOut, argsIn);
    }


    /// <summary>
    /// Provides a single output, 0-input MWArrayinterface to the digital_filtering
    /// MATLAB function.
    /// </summary>
    /// <remarks>
    /// M-Documentation:
    /// Enhancement
    /// </remarks>
    /// <returns>An MWArray containing the first output argument.</returns>
    ///
    public MWArray digital_filtering()
    {
      return mcr.EvaluateFunction("digital_filtering", new MWArray[]{});
    }


    /// <summary>
    /// Provides a single output, 1-input MWArrayinterface to the digital_filtering
    /// MATLAB function.
    /// </summary>
    /// <remarks>
    /// M-Documentation:
    /// Enhancement
    /// </remarks>
    /// <param name="raw_image">Input argument #1</param>
    /// <returns>An MWArray containing the first output argument.</returns>
    ///
    public MWArray digital_filtering(MWArray raw_image)
    {
      return mcr.EvaluateFunction("digital_filtering", raw_image);
    }


    /// <summary>
    /// Provides a single output, 2-input MWArrayinterface to the digital_filtering
    /// MATLAB function.
    /// </summary>
    /// <remarks>
    /// M-Documentation:
    /// Enhancement
    /// </remarks>
    /// <param name="raw_image">Input argument #1</param>
    /// <param name="config">Input argument #2</param>
    /// <returns>An MWArray containing the first output argument.</returns>
    ///
    public MWArray digital_filtering(MWArray raw_image, MWArray config)
    {
      return mcr.EvaluateFunction("digital_filtering", raw_image, config);
    }


    /// <summary>
    /// Provides the standard 0-input MWArray interface to the digital_filtering MATLAB
    /// function.
    /// </summary>
    /// <remarks>
    /// M-Documentation:
    /// Enhancement
    /// </remarks>
    /// <param name="numArgsOut">The number of output arguments to return.</param>
    /// <returns>An Array of length "numArgsOut" containing the output
    /// arguments.</returns>
    ///
    public MWArray[] digital_filtering(int numArgsOut)
    {
      return mcr.EvaluateFunction(numArgsOut, "digital_filtering", new MWArray[]{});
    }


    /// <summary>
    /// Provides the standard 1-input MWArray interface to the digital_filtering MATLAB
    /// function.
    /// </summary>
    /// <remarks>
    /// M-Documentation:
    /// Enhancement
    /// </remarks>
    /// <param name="numArgsOut">The number of output arguments to return.</param>
    /// <param name="raw_image">Input argument #1</param>
    /// <returns>An Array of length "numArgsOut" containing the output
    /// arguments.</returns>
    ///
    public MWArray[] digital_filtering(int numArgsOut, MWArray raw_image)
    {
      return mcr.EvaluateFunction(numArgsOut, "digital_filtering", raw_image);
    }


    /// <summary>
    /// Provides the standard 2-input MWArray interface to the digital_filtering MATLAB
    /// function.
    /// </summary>
    /// <remarks>
    /// M-Documentation:
    /// Enhancement
    /// </remarks>
    /// <param name="numArgsOut">The number of output arguments to return.</param>
    /// <param name="raw_image">Input argument #1</param>
    /// <param name="config">Input argument #2</param>
    /// <returns>An Array of length "numArgsOut" containing the output
    /// arguments.</returns>
    ///
    public MWArray[] digital_filtering(int numArgsOut, MWArray raw_image, MWArray config)
    {
      return mcr.EvaluateFunction(numArgsOut, "digital_filtering", raw_image, config);
    }


    /// <summary>
    /// Provides an interface for the digital_filtering function in which the input and
    /// output
    /// arguments are specified as an array of MWArrays.
    /// </summary>
    /// <remarks>
    /// This method will allocate and return by reference the output argument
    /// array.<newpara></newpara>
    /// M-Documentation:
    /// Enhancement
    /// </remarks>
    /// <param name="numArgsOut">The number of output arguments to return</param>
    /// <param name= "argsOut">Array of MWArray output arguments</param>
    /// <param name= "argsIn">Array of MWArray input arguments</param>
    ///
    public void digital_filtering(int numArgsOut, ref MWArray[] argsOut, MWArray[] argsIn)
    {
      mcr.EvaluateFunction("digital_filtering", numArgsOut, ref argsOut, argsIn);
    }


    /// <summary>
    /// Provides a single output, 0-input MWArrayinterface to the digital_filtering_boost
    /// MATLAB function.
    /// </summary>
    /// <remarks>
    /// M-Documentation:
    /// **************************************************************************
    /// Removes isolated pixels (individual 1's that are surrounded by 0's).
    /// </remarks>
    /// <returns>An MWArray containing the first output argument.</returns>
    ///
    public MWArray digital_filtering_boost()
    {
      return mcr.EvaluateFunction("digital_filtering_boost", new MWArray[]{});
    }


    /// <summary>
    /// Provides a single output, 1-input MWArrayinterface to the digital_filtering_boost
    /// MATLAB function.
    /// </summary>
    /// <remarks>
    /// M-Documentation:
    /// **************************************************************************
    /// Removes isolated pixels (individual 1's that are surrounded by 0's).
    /// </remarks>
    /// <param name="image">Input argument #1</param>
    /// <returns>An MWArray containing the first output argument.</returns>
    ///
    public MWArray digital_filtering_boost(MWArray image)
    {
      return mcr.EvaluateFunction("digital_filtering_boost", image);
    }


    /// <summary>
    /// Provides a single output, 2-input MWArrayinterface to the digital_filtering_boost
    /// MATLAB function.
    /// </summary>
    /// <remarks>
    /// M-Documentation:
    /// **************************************************************************
    /// Removes isolated pixels (individual 1's that are surrounded by 0's).
    /// </remarks>
    /// <param name="image">Input argument #1</param>
    /// <param name="config">Input argument #2</param>
    /// <returns>An MWArray containing the first output argument.</returns>
    ///
    public MWArray digital_filtering_boost(MWArray image, MWArray config)
    {
      return mcr.EvaluateFunction("digital_filtering_boost", image, config);
    }


    /// <summary>
    /// Provides the standard 0-input MWArray interface to the digital_filtering_boost
    /// MATLAB function.
    /// </summary>
    /// <remarks>
    /// M-Documentation:
    /// **************************************************************************
    /// Removes isolated pixels (individual 1's that are surrounded by 0's).
    /// </remarks>
    /// <param name="numArgsOut">The number of output arguments to return.</param>
    /// <returns>An Array of length "numArgsOut" containing the output
    /// arguments.</returns>
    ///
    public MWArray[] digital_filtering_boost(int numArgsOut)
    {
      return mcr.EvaluateFunction(numArgsOut, "digital_filtering_boost", new MWArray[]{});
    }


    /// <summary>
    /// Provides the standard 1-input MWArray interface to the digital_filtering_boost
    /// MATLAB function.
    /// </summary>
    /// <remarks>
    /// M-Documentation:
    /// **************************************************************************
    /// Removes isolated pixels (individual 1's that are surrounded by 0's).
    /// </remarks>
    /// <param name="numArgsOut">The number of output arguments to return.</param>
    /// <param name="image">Input argument #1</param>
    /// <returns>An Array of length "numArgsOut" containing the output
    /// arguments.</returns>
    ///
    public MWArray[] digital_filtering_boost(int numArgsOut, MWArray image)
    {
      return mcr.EvaluateFunction(numArgsOut, "digital_filtering_boost", image);
    }


    /// <summary>
    /// Provides the standard 2-input MWArray interface to the digital_filtering_boost
    /// MATLAB function.
    /// </summary>
    /// <remarks>
    /// M-Documentation:
    /// **************************************************************************
    /// Removes isolated pixels (individual 1's that are surrounded by 0's).
    /// </remarks>
    /// <param name="numArgsOut">The number of output arguments to return.</param>
    /// <param name="image">Input argument #1</param>
    /// <param name="config">Input argument #2</param>
    /// <returns>An Array of length "numArgsOut" containing the output
    /// arguments.</returns>
    ///
    public MWArray[] digital_filtering_boost(int numArgsOut, MWArray image, MWArray 
                                       config)
    {
      return mcr.EvaluateFunction(numArgsOut, "digital_filtering_boost", image, config);
    }


    /// <summary>
    /// Provides an interface for the digital_filtering_boost function in which the input
    /// and output
    /// arguments are specified as an array of MWArrays.
    /// </summary>
    /// <remarks>
    /// This method will allocate and return by reference the output argument
    /// array.<newpara></newpara>
    /// M-Documentation:
    /// **************************************************************************
    /// Removes isolated pixels (individual 1's that are surrounded by 0's).
    /// </remarks>
    /// <param name="numArgsOut">The number of output arguments to return</param>
    /// <param name= "argsOut">Array of MWArray output arguments</param>
    /// <param name= "argsIn">Array of MWArray input arguments</param>
    ///
    public void digital_filtering_boost(int numArgsOut, ref MWArray[] argsOut, MWArray[] 
                              argsIn)
    {
      mcr.EvaluateFunction("digital_filtering_boost", numArgsOut, ref argsOut, argsIn);
    }


    /// <summary>
    /// Provides a void output, 0-input MWArrayinterface to the historian MATLAB
    /// function.
    /// </summary>
    /// <remarks>
    /// M-Documentation:
    /// Archive
    /// </remarks>
    ///
    public void historian()
    {
      mcr.EvaluateFunction(0, "historian", new MWArray[]{});
    }


    /// <summary>
    /// Provides a void output, 1-input MWArrayinterface to the historian MATLAB
    /// function.
    /// </summary>
    /// <remarks>
    /// M-Documentation:
    /// Archive
    /// </remarks>
    /// <param name="vargin">Input argument #1</param>
    ///
    public void historian(MWArray vargin)
    {
      mcr.EvaluateFunction(0, "historian", vargin);
    }


    /// <summary>
    /// Provides the standard 0-input MWArray interface to the historian MATLAB function.
    /// </summary>
    /// <remarks>
    /// M-Documentation:
    /// Archive
    /// </remarks>
    /// <param name="numArgsOut">The number of output arguments to return.</param>
    /// <returns>An Array of length "numArgsOut" containing the output
    /// arguments.</returns>
    ///
    public MWArray[] historian(int numArgsOut)
    {
      return mcr.EvaluateFunction(numArgsOut, "historian", new MWArray[]{});
    }


    /// <summary>
    /// Provides the standard 1-input MWArray interface to the historian MATLAB function.
    /// </summary>
    /// <remarks>
    /// M-Documentation:
    /// Archive
    /// </remarks>
    /// <param name="numArgsOut">The number of output arguments to return.</param>
    /// <param name="vargin">Input argument #1</param>
    /// <returns>An Array of length "numArgsOut" containing the output
    /// arguments.</returns>
    ///
    public MWArray[] historian(int numArgsOut, MWArray vargin)
    {
      return mcr.EvaluateFunction(numArgsOut, "historian", vargin);
    }


    /// <summary>
    /// Provides a single output, 0-input MWArrayinterface to the image_initialization
    /// MATLAB function.
    /// </summary>
    /// <remarks>
    /// M-Documentation:
    /// This function applies several standard operation including rgb2gray,
    /// crop, and normalization on the raw_image for any future analysis
    /// Import
    /// rgb2gray
    /// </remarks>
    /// <returns>An MWArray containing the first output argument.</returns>
    ///
    public MWArray image_initialization()
    {
      return mcr.EvaluateFunction("image_initialization", new MWArray[]{});
    }


    /// <summary>
    /// Provides a single output, 1-input MWArrayinterface to the image_initialization
    /// MATLAB function.
    /// </summary>
    /// <remarks>
    /// M-Documentation:
    /// This function applies several standard operation including rgb2gray,
    /// crop, and normalization on the raw_image for any future analysis
    /// Import
    /// rgb2gray
    /// </remarks>
    /// <param name="raw_image">Input argument #1</param>
    /// <returns>An MWArray containing the first output argument.</returns>
    ///
    public MWArray image_initialization(MWArray raw_image)
    {
      return mcr.EvaluateFunction("image_initialization", raw_image);
    }


    /// <summary>
    /// Provides a single output, 2-input MWArrayinterface to the image_initialization
    /// MATLAB function.
    /// </summary>
    /// <remarks>
    /// M-Documentation:
    /// This function applies several standard operation including rgb2gray,
    /// crop, and normalization on the raw_image for any future analysis
    /// Import
    /// rgb2gray
    /// </remarks>
    /// <param name="raw_image">Input argument #1</param>
    /// <param name="config">Input argument #2</param>
    /// <returns>An MWArray containing the first output argument.</returns>
    ///
    public MWArray image_initialization(MWArray raw_image, MWArray config)
    {
      return mcr.EvaluateFunction("image_initialization", raw_image, config);
    }


    /// <summary>
    /// Provides the standard 0-input MWArray interface to the image_initialization
    /// MATLAB function.
    /// </summary>
    /// <remarks>
    /// M-Documentation:
    /// This function applies several standard operation including rgb2gray,
    /// crop, and normalization on the raw_image for any future analysis
    /// Import
    /// rgb2gray
    /// </remarks>
    /// <param name="numArgsOut">The number of output arguments to return.</param>
    /// <returns>An Array of length "numArgsOut" containing the output
    /// arguments.</returns>
    ///
    public MWArray[] image_initialization(int numArgsOut)
    {
      return mcr.EvaluateFunction(numArgsOut, "image_initialization", new MWArray[]{});
    }


    /// <summary>
    /// Provides the standard 1-input MWArray interface to the image_initialization
    /// MATLAB function.
    /// </summary>
    /// <remarks>
    /// M-Documentation:
    /// This function applies several standard operation including rgb2gray,
    /// crop, and normalization on the raw_image for any future analysis
    /// Import
    /// rgb2gray
    /// </remarks>
    /// <param name="numArgsOut">The number of output arguments to return.</param>
    /// <param name="raw_image">Input argument #1</param>
    /// <returns>An Array of length "numArgsOut" containing the output
    /// arguments.</returns>
    ///
    public MWArray[] image_initialization(int numArgsOut, MWArray raw_image)
    {
      return mcr.EvaluateFunction(numArgsOut, "image_initialization", raw_image);
    }


    /// <summary>
    /// Provides the standard 2-input MWArray interface to the image_initialization
    /// MATLAB function.
    /// </summary>
    /// <remarks>
    /// M-Documentation:
    /// This function applies several standard operation including rgb2gray,
    /// crop, and normalization on the raw_image for any future analysis
    /// Import
    /// rgb2gray
    /// </remarks>
    /// <param name="numArgsOut">The number of output arguments to return.</param>
    /// <param name="raw_image">Input argument #1</param>
    /// <param name="config">Input argument #2</param>
    /// <returns>An Array of length "numArgsOut" containing the output
    /// arguments.</returns>
    ///
    public MWArray[] image_initialization(int numArgsOut, MWArray raw_image, MWArray 
                                    config)
    {
      return mcr.EvaluateFunction(numArgsOut, "image_initialization", raw_image, config);
    }


    /// <summary>
    /// Provides an interface for the image_initialization function in which the input
    /// and output
    /// arguments are specified as an array of MWArrays.
    /// </summary>
    /// <remarks>
    /// This method will allocate and return by reference the output argument
    /// array.<newpara></newpara>
    /// M-Documentation:
    /// This function applies several standard operation including rgb2gray,
    /// crop, and normalization on the raw_image for any future analysis
    /// Import
    /// rgb2gray
    /// </remarks>
    /// <param name="numArgsOut">The number of output arguments to return</param>
    /// <param name= "argsOut">Array of MWArray output arguments</param>
    /// <param name= "argsIn">Array of MWArray input arguments</param>
    ///
    public void image_initialization(int numArgsOut, ref MWArray[] argsOut, MWArray[] 
                           argsIn)
    {
      mcr.EvaluateFunction("image_initialization", numArgsOut, ref argsOut, argsIn);
    }


    /// <summary>
    /// Provides a single output, 0-input MWArrayinterface to the is_this_bubble MATLAB
    /// function.
    /// </summary>
    /// <remarks>
    /// M-Documentation:
    /// std(seriesData{k+1}); 
    /// mean(seriesData{k+1})-median(seriesData{k+1}); 
    /// sum(seriesData{k+1}); 
    /// </remarks>
    /// <returns>An MWArray containing the first output argument.</returns>
    ///
    public MWArray is_this_bubble()
    {
      return mcr.EvaluateFunction("is_this_bubble", new MWArray[]{});
    }


    /// <summary>
    /// Provides a single output, 1-input MWArrayinterface to the is_this_bubble MATLAB
    /// function.
    /// </summary>
    /// <remarks>
    /// M-Documentation:
    /// std(seriesData{k+1}); 
    /// mean(seriesData{k+1})-median(seriesData{k+1}); 
    /// sum(seriesData{k+1}); 
    /// </remarks>
    /// <param name="image">Input argument #1</param>
    /// <returns>An MWArray containing the first output argument.</returns>
    ///
    public MWArray is_this_bubble(MWArray image)
    {
      return mcr.EvaluateFunction("is_this_bubble", image);
    }


    /// <summary>
    /// Provides a single output, 2-input MWArrayinterface to the is_this_bubble MATLAB
    /// function.
    /// </summary>
    /// <remarks>
    /// M-Documentation:
    /// std(seriesData{k+1}); 
    /// mean(seriesData{k+1})-median(seriesData{k+1}); 
    /// sum(seriesData{k+1}); 
    /// </remarks>
    /// <param name="image">Input argument #1</param>
    /// <param name="particle_pixels">Input argument #2</param>
    /// <returns>An MWArray containing the first output argument.</returns>
    ///
    public MWArray is_this_bubble(MWArray image, MWArray particle_pixels)
    {
      return mcr.EvaluateFunction("is_this_bubble", image, particle_pixels);
    }


    /// <summary>
    /// Provides a single output, 3-input MWArrayinterface to the is_this_bubble MATLAB
    /// function.
    /// </summary>
    /// <remarks>
    /// M-Documentation:
    /// std(seriesData{k+1}); 
    /// mean(seriesData{k+1})-median(seriesData{k+1}); 
    /// sum(seriesData{k+1}); 
    /// </remarks>
    /// <param name="image">Input argument #1</param>
    /// <param name="particle_pixels">Input argument #2</param>
    /// <param name="config">Input argument #3</param>
    /// <returns>An MWArray containing the first output argument.</returns>
    ///
    public MWArray is_this_bubble(MWArray image, MWArray particle_pixels, MWArray config)
    {
      return mcr.EvaluateFunction("is_this_bubble", image, particle_pixels, config);
    }


    /// <summary>
    /// Provides the standard 0-input MWArray interface to the is_this_bubble MATLAB
    /// function.
    /// </summary>
    /// <remarks>
    /// M-Documentation:
    /// std(seriesData{k+1}); 
    /// mean(seriesData{k+1})-median(seriesData{k+1}); 
    /// sum(seriesData{k+1}); 
    /// </remarks>
    /// <param name="numArgsOut">The number of output arguments to return.</param>
    /// <returns>An Array of length "numArgsOut" containing the output
    /// arguments.</returns>
    ///
    public MWArray[] is_this_bubble(int numArgsOut)
    {
      return mcr.EvaluateFunction(numArgsOut, "is_this_bubble", new MWArray[]{});
    }


    /// <summary>
    /// Provides the standard 1-input MWArray interface to the is_this_bubble MATLAB
    /// function.
    /// </summary>
    /// <remarks>
    /// M-Documentation:
    /// std(seriesData{k+1}); 
    /// mean(seriesData{k+1})-median(seriesData{k+1}); 
    /// sum(seriesData{k+1}); 
    /// </remarks>
    /// <param name="numArgsOut">The number of output arguments to return.</param>
    /// <param name="image">Input argument #1</param>
    /// <returns>An Array of length "numArgsOut" containing the output
    /// arguments.</returns>
    ///
    public MWArray[] is_this_bubble(int numArgsOut, MWArray image)
    {
      return mcr.EvaluateFunction(numArgsOut, "is_this_bubble", image);
    }


    /// <summary>
    /// Provides the standard 2-input MWArray interface to the is_this_bubble MATLAB
    /// function.
    /// </summary>
    /// <remarks>
    /// M-Documentation:
    /// std(seriesData{k+1}); 
    /// mean(seriesData{k+1})-median(seriesData{k+1}); 
    /// sum(seriesData{k+1}); 
    /// </remarks>
    /// <param name="numArgsOut">The number of output arguments to return.</param>
    /// <param name="image">Input argument #1</param>
    /// <param name="particle_pixels">Input argument #2</param>
    /// <returns>An Array of length "numArgsOut" containing the output
    /// arguments.</returns>
    ///
    public MWArray[] is_this_bubble(int numArgsOut, MWArray image, MWArray 
                              particle_pixels)
    {
      return mcr.EvaluateFunction(numArgsOut, "is_this_bubble", image, particle_pixels);
    }


    /// <summary>
    /// Provides the standard 3-input MWArray interface to the is_this_bubble MATLAB
    /// function.
    /// </summary>
    /// <remarks>
    /// M-Documentation:
    /// std(seriesData{k+1}); 
    /// mean(seriesData{k+1})-median(seriesData{k+1}); 
    /// sum(seriesData{k+1}); 
    /// </remarks>
    /// <param name="numArgsOut">The number of output arguments to return.</param>
    /// <param name="image">Input argument #1</param>
    /// <param name="particle_pixels">Input argument #2</param>
    /// <param name="config">Input argument #3</param>
    /// <returns>An Array of length "numArgsOut" containing the output
    /// arguments.</returns>
    ///
    public MWArray[] is_this_bubble(int numArgsOut, MWArray image, MWArray 
                              particle_pixels, MWArray config)
    {
      return mcr.EvaluateFunction(numArgsOut, "is_this_bubble", image, particle_pixels, config);
    }


    /// <summary>
    /// Provides an interface for the is_this_bubble function in which the input and
    /// output
    /// arguments are specified as an array of MWArrays.
    /// </summary>
    /// <remarks>
    /// This method will allocate and return by reference the output argument
    /// array.<newpara></newpara>
    /// M-Documentation:
    /// std(seriesData{k+1}); 
    /// mean(seriesData{k+1})-median(seriesData{k+1}); 
    /// sum(seriesData{k+1}); 
    /// </remarks>
    /// <param name="numArgsOut">The number of output arguments to return</param>
    /// <param name= "argsOut">Array of MWArray output arguments</param>
    /// <param name= "argsIn">Array of MWArray input arguments</param>
    ///
    public void is_this_bubble(int numArgsOut, ref MWArray[] argsOut, MWArray[] argsIn)
    {
      mcr.EvaluateFunction("is_this_bubble", numArgsOut, ref argsOut, argsIn);
    }


    /// <summary>
    /// Provides a single output, 0-input MWArrayinterface to the load_config MATLAB
    /// function.
    /// </summary>
    /// <remarks>
    /// M-Documentation:
    /// Config
    /// Format string for each line of text:
    /// column1: text (  s)
    /// column2: double (  f)
    /// For more information, see the TEXTSCAN documentation.
    /// </remarks>
    /// <returns>An MWArray containing the first output argument.</returns>
    ///
    public MWArray load_config()
    {
      return mcr.EvaluateFunction("load_config", new MWArray[]{});
    }


    /// <summary>
    /// Provides a single output, 1-input MWArrayinterface to the load_config MATLAB
    /// function.
    /// </summary>
    /// <remarks>
    /// M-Documentation:
    /// Config
    /// Format string for each line of text:
    /// column1: text (  s)
    /// column2: double (  f)
    /// For more information, see the TEXTSCAN documentation.
    /// </remarks>
    /// <param name="matlab_config_path">Input argument #1</param>
    /// <returns>An MWArray containing the first output argument.</returns>
    ///
    public MWArray load_config(MWArray matlab_config_path)
    {
      return mcr.EvaluateFunction("load_config", matlab_config_path);
    }


    /// <summary>
    /// Provides the standard 0-input MWArray interface to the load_config MATLAB
    /// function.
    /// </summary>
    /// <remarks>
    /// M-Documentation:
    /// Config
    /// Format string for each line of text:
    /// column1: text (  s)
    /// column2: double (  f)
    /// For more information, see the TEXTSCAN documentation.
    /// </remarks>
    /// <param name="numArgsOut">The number of output arguments to return.</param>
    /// <returns>An Array of length "numArgsOut" containing the output
    /// arguments.</returns>
    ///
    public MWArray[] load_config(int numArgsOut)
    {
      return mcr.EvaluateFunction(numArgsOut, "load_config", new MWArray[]{});
    }


    /// <summary>
    /// Provides the standard 1-input MWArray interface to the load_config MATLAB
    /// function.
    /// </summary>
    /// <remarks>
    /// M-Documentation:
    /// Config
    /// Format string for each line of text:
    /// column1: text (  s)
    /// column2: double (  f)
    /// For more information, see the TEXTSCAN documentation.
    /// </remarks>
    /// <param name="numArgsOut">The number of output arguments to return.</param>
    /// <param name="matlab_config_path">Input argument #1</param>
    /// <returns>An Array of length "numArgsOut" containing the output
    /// arguments.</returns>
    ///
    public MWArray[] load_config(int numArgsOut, MWArray matlab_config_path)
    {
      return mcr.EvaluateFunction(numArgsOut, "load_config", matlab_config_path);
    }


    /// <summary>
    /// Provides an interface for the load_config function in which the input and output
    /// arguments are specified as an array of MWArrays.
    /// </summary>
    /// <remarks>
    /// This method will allocate and return by reference the output argument
    /// array.<newpara></newpara>
    /// M-Documentation:
    /// Config
    /// Format string for each line of text:
    /// column1: text (  s)
    /// column2: double (  f)
    /// For more information, see the TEXTSCAN documentation.
    /// </remarks>
    /// <param name="numArgsOut">The number of output arguments to return</param>
    /// <param name= "argsOut">Array of MWArray output arguments</param>
    /// <param name= "argsIn">Array of MWArray input arguments</param>
    ///
    public void load_config(int numArgsOut, ref MWArray[] argsOut, MWArray[] argsIn)
    {
      mcr.EvaluateFunction("load_config", numArgsOut, ref argsOut, argsIn);
    }


    /// <summary>
    /// Provides a void output, 0-input MWArrayinterface to the LucamCameraClose MATLAB
    /// function.
    /// </summary>
    /// <remarks>
    /// M-Documentation:
    /// LucamCameraClose - Disconnects from the currently connected Lumenera camera.
    /// </remarks>
    ///
    public void LucamCameraClose()
    {
      mcr.EvaluateFunction(0, "LucamCameraClose", new MWArray[]{});
    }


    /// <summary>
    /// Provides a void output, 1-input MWArrayinterface to the LucamCameraClose MATLAB
    /// function.
    /// </summary>
    /// <remarks>
    /// M-Documentation:
    /// LucamCameraClose - Disconnects from the currently connected Lumenera camera.
    /// </remarks>
    /// <param name="cameraNum">Input argument #1</param>
    ///
    public void LucamCameraClose(MWArray cameraNum)
    {
      mcr.EvaluateFunction(0, "LucamCameraClose", cameraNum);
    }


    /// <summary>
    /// Provides the standard 0-input MWArray interface to the LucamCameraClose MATLAB
    /// function.
    /// </summary>
    /// <remarks>
    /// M-Documentation:
    /// LucamCameraClose - Disconnects from the currently connected Lumenera camera.
    /// </remarks>
    /// <param name="numArgsOut">The number of output arguments to return.</param>
    /// <returns>An Array of length "numArgsOut" containing the output
    /// arguments.</returns>
    ///
    public MWArray[] LucamCameraClose(int numArgsOut)
    {
      return mcr.EvaluateFunction(numArgsOut, "LucamCameraClose", new MWArray[]{});
    }


    /// <summary>
    /// Provides the standard 1-input MWArray interface to the LucamCameraClose MATLAB
    /// function.
    /// </summary>
    /// <remarks>
    /// M-Documentation:
    /// LucamCameraClose - Disconnects from the currently connected Lumenera camera.
    /// </remarks>
    /// <param name="numArgsOut">The number of output arguments to return.</param>
    /// <param name="cameraNum">Input argument #1</param>
    /// <returns>An Array of length "numArgsOut" containing the output
    /// arguments.</returns>
    ///
    public MWArray[] LucamCameraClose(int numArgsOut, MWArray cameraNum)
    {
      return mcr.EvaluateFunction(numArgsOut, "LucamCameraClose", cameraNum);
    }


    /// <summary>
    /// Provides a single output, 0-input MWArrayinterface to the LucamCameraOpen MATLAB
    /// function.
    /// </summary>
    /// <remarks>
    /// M-Documentation:
    /// LucamCameraOpen - Connect to the Lumenera camera specified.
    /// </remarks>
    /// <returns>An MWArray containing the first output argument.</returns>
    ///
    public MWArray LucamCameraOpen()
    {
      return mcr.EvaluateFunction("LucamCameraOpen", new MWArray[]{});
    }


    /// <summary>
    /// Provides a single output, 1-input MWArrayinterface to the LucamCameraOpen MATLAB
    /// function.
    /// </summary>
    /// <remarks>
    /// M-Documentation:
    /// LucamCameraOpen - Connect to the Lumenera camera specified.
    /// </remarks>
    /// <param name="cameraNum">Input argument #1</param>
    /// <returns>An MWArray containing the first output argument.</returns>
    ///
    public MWArray LucamCameraOpen(MWArray cameraNum)
    {
      return mcr.EvaluateFunction("LucamCameraOpen", cameraNum);
    }


    /// <summary>
    /// Provides the standard 0-input MWArray interface to the LucamCameraOpen MATLAB
    /// function.
    /// </summary>
    /// <remarks>
    /// M-Documentation:
    /// LucamCameraOpen - Connect to the Lumenera camera specified.
    /// </remarks>
    /// <param name="numArgsOut">The number of output arguments to return.</param>
    /// <returns>An Array of length "numArgsOut" containing the output
    /// arguments.</returns>
    ///
    public MWArray[] LucamCameraOpen(int numArgsOut)
    {
      return mcr.EvaluateFunction(numArgsOut, "LucamCameraOpen", new MWArray[]{});
    }


    /// <summary>
    /// Provides the standard 1-input MWArray interface to the LucamCameraOpen MATLAB
    /// function.
    /// </summary>
    /// <remarks>
    /// M-Documentation:
    /// LucamCameraOpen - Connect to the Lumenera camera specified.
    /// </remarks>
    /// <param name="numArgsOut">The number of output arguments to return.</param>
    /// <param name="cameraNum">Input argument #1</param>
    /// <returns>An Array of length "numArgsOut" containing the output
    /// arguments.</returns>
    ///
    public MWArray[] LucamCameraOpen(int numArgsOut, MWArray cameraNum)
    {
      return mcr.EvaluateFunction(numArgsOut, "LucamCameraOpen", cameraNum);
    }


    /// <summary>
    /// Provides an interface for the LucamCameraOpen function in which the input and
    /// output
    /// arguments are specified as an array of MWArrays.
    /// </summary>
    /// <remarks>
    /// This method will allocate and return by reference the output argument
    /// array.<newpara></newpara>
    /// M-Documentation:
    /// LucamCameraOpen - Connect to the Lumenera camera specified.
    /// </remarks>
    /// <param name="numArgsOut">The number of output arguments to return</param>
    /// <param name= "argsOut">Array of MWArray output arguments</param>
    /// <param name= "argsIn">Array of MWArray input arguments</param>
    ///
    public void LucamCameraOpen(int numArgsOut, ref MWArray[] argsOut, MWArray[] argsIn)
    {
      mcr.EvaluateFunction("LucamCameraOpen", numArgsOut, ref argsOut, argsIn);
    }


    /// <summary>
    /// Provides a void output, 0-input MWArrayinterface to the LucamSetGain MATLAB
    /// function.
    /// </summary>
    /// <remarks>
    /// M-Documentation:
    /// LucamSetGain - Sets the gain value for video mode.
    /// </remarks>
    ///
    public void LucamSetGain()
    {
      mcr.EvaluateFunction(0, "LucamSetGain", new MWArray[]{});
    }


    /// <summary>
    /// Provides a void output, 1-input MWArrayinterface to the LucamSetGain MATLAB
    /// function.
    /// </summary>
    /// <remarks>
    /// M-Documentation:
    /// LucamSetGain - Sets the gain value for video mode.
    /// </remarks>
    /// <param name="gain">Input argument #1</param>
    ///
    public void LucamSetGain(MWArray gain)
    {
      mcr.EvaluateFunction(0, "LucamSetGain", gain);
    }


    /// <summary>
    /// Provides a void output, 2-input MWArrayinterface to the LucamSetGain MATLAB
    /// function.
    /// </summary>
    /// <remarks>
    /// M-Documentation:
    /// LucamSetGain - Sets the gain value for video mode.
    /// </remarks>
    /// <param name="gain">Input argument #1</param>
    /// <param name="cameraNum">Input argument #2</param>
    ///
    public void LucamSetGain(MWArray gain, MWArray cameraNum)
    {
      mcr.EvaluateFunction(0, "LucamSetGain", gain, cameraNum);
    }


    /// <summary>
    /// Provides the standard 0-input MWArray interface to the LucamSetGain MATLAB
    /// function.
    /// </summary>
    /// <remarks>
    /// M-Documentation:
    /// LucamSetGain - Sets the gain value for video mode.
    /// </remarks>
    /// <param name="numArgsOut">The number of output arguments to return.</param>
    /// <returns>An Array of length "numArgsOut" containing the output
    /// arguments.</returns>
    ///
    public MWArray[] LucamSetGain(int numArgsOut)
    {
      return mcr.EvaluateFunction(numArgsOut, "LucamSetGain", new MWArray[]{});
    }


    /// <summary>
    /// Provides the standard 1-input MWArray interface to the LucamSetGain MATLAB
    /// function.
    /// </summary>
    /// <remarks>
    /// M-Documentation:
    /// LucamSetGain - Sets the gain value for video mode.
    /// </remarks>
    /// <param name="numArgsOut">The number of output arguments to return.</param>
    /// <param name="gain">Input argument #1</param>
    /// <returns>An Array of length "numArgsOut" containing the output
    /// arguments.</returns>
    ///
    public MWArray[] LucamSetGain(int numArgsOut, MWArray gain)
    {
      return mcr.EvaluateFunction(numArgsOut, "LucamSetGain", gain);
    }


    /// <summary>
    /// Provides the standard 2-input MWArray interface to the LucamSetGain MATLAB
    /// function.
    /// </summary>
    /// <remarks>
    /// M-Documentation:
    /// LucamSetGain - Sets the gain value for video mode.
    /// </remarks>
    /// <param name="numArgsOut">The number of output arguments to return.</param>
    /// <param name="gain">Input argument #1</param>
    /// <param name="cameraNum">Input argument #2</param>
    /// <returns>An Array of length "numArgsOut" containing the output
    /// arguments.</returns>
    ///
    public MWArray[] LucamSetGain(int numArgsOut, MWArray gain, MWArray cameraNum)
    {
      return mcr.EvaluateFunction(numArgsOut, "LucamSetGain", gain, cameraNum);
    }


    /// <summary>
    /// Provides a void output, 0-input MWArrayinterface to the LucamSetSnapshotExposure
    /// MATLAB function.
    /// </summary>
    /// <remarks>
    /// M-Documentation:
    /// LucamSetSnapshotExposure - Sets the exposure time for snapshot mode.
    /// </remarks>
    ///
    public void LucamSetSnapshotExposure()
    {
      mcr.EvaluateFunction(0, "LucamSetSnapshotExposure", new MWArray[]{});
    }


    /// <summary>
    /// Provides a void output, 1-input MWArrayinterface to the LucamSetSnapshotExposure
    /// MATLAB function.
    /// </summary>
    /// <remarks>
    /// M-Documentation:
    /// LucamSetSnapshotExposure - Sets the exposure time for snapshot mode.
    /// </remarks>
    /// <param name="exposure">Input argument #1</param>
    ///
    public void LucamSetSnapshotExposure(MWArray exposure)
    {
      mcr.EvaluateFunction(0, "LucamSetSnapshotExposure", exposure);
    }


    /// <summary>
    /// Provides a void output, 2-input MWArrayinterface to the LucamSetSnapshotExposure
    /// MATLAB function.
    /// </summary>
    /// <remarks>
    /// M-Documentation:
    /// LucamSetSnapshotExposure - Sets the exposure time for snapshot mode.
    /// </remarks>
    /// <param name="exposure">Input argument #1</param>
    /// <param name="cameraNum">Input argument #2</param>
    ///
    public void LucamSetSnapshotExposure(MWArray exposure, MWArray cameraNum)
    {
      mcr.EvaluateFunction(0, "LucamSetSnapshotExposure", exposure, cameraNum);
    }


    /// <summary>
    /// Provides the standard 0-input MWArray interface to the LucamSetSnapshotExposure
    /// MATLAB function.
    /// </summary>
    /// <remarks>
    /// M-Documentation:
    /// LucamSetSnapshotExposure - Sets the exposure time for snapshot mode.
    /// </remarks>
    /// <param name="numArgsOut">The number of output arguments to return.</param>
    /// <returns>An Array of length "numArgsOut" containing the output
    /// arguments.</returns>
    ///
    public MWArray[] LucamSetSnapshotExposure(int numArgsOut)
    {
      return mcr.EvaluateFunction(numArgsOut, "LucamSetSnapshotExposure", new MWArray[]{});
    }


    /// <summary>
    /// Provides the standard 1-input MWArray interface to the LucamSetSnapshotExposure
    /// MATLAB function.
    /// </summary>
    /// <remarks>
    /// M-Documentation:
    /// LucamSetSnapshotExposure - Sets the exposure time for snapshot mode.
    /// </remarks>
    /// <param name="numArgsOut">The number of output arguments to return.</param>
    /// <param name="exposure">Input argument #1</param>
    /// <returns>An Array of length "numArgsOut" containing the output
    /// arguments.</returns>
    ///
    public MWArray[] LucamSetSnapshotExposure(int numArgsOut, MWArray exposure)
    {
      return mcr.EvaluateFunction(numArgsOut, "LucamSetSnapshotExposure", exposure);
    }


    /// <summary>
    /// Provides the standard 2-input MWArray interface to the LucamSetSnapshotExposure
    /// MATLAB function.
    /// </summary>
    /// <remarks>
    /// M-Documentation:
    /// LucamSetSnapshotExposure - Sets the exposure time for snapshot mode.
    /// </remarks>
    /// <param name="numArgsOut">The number of output arguments to return.</param>
    /// <param name="exposure">Input argument #1</param>
    /// <param name="cameraNum">Input argument #2</param>
    /// <returns>An Array of length "numArgsOut" containing the output
    /// arguments.</returns>
    ///
    public MWArray[] LucamSetSnapshotExposure(int numArgsOut, MWArray exposure, MWArray 
                                        cameraNum)
    {
      return mcr.EvaluateFunction(numArgsOut, "LucamSetSnapshotExposure", exposure, cameraNum);
    }


    /// <summary>
    /// Provides a single output, 0-input MWArrayinterface to the LucamTakeSnapshot
    /// MATLAB function.
    /// </summary>
    /// <remarks>
    /// M-Documentation:
    /// LucamTakeSnapshot - Takes a snapshot using the predefined settings.
    /// </remarks>
    /// <returns>An MWArray containing the first output argument.</returns>
    ///
    public MWArray LucamTakeSnapshot()
    {
      return mcr.EvaluateFunction("LucamTakeSnapshot", new MWArray[]{});
    }


    /// <summary>
    /// Provides a single output, 1-input MWArrayinterface to the LucamTakeSnapshot
    /// MATLAB function.
    /// </summary>
    /// <remarks>
    /// M-Documentation:
    /// LucamTakeSnapshot - Takes a snapshot using the predefined settings.
    /// </remarks>
    /// <param name="cameraNum">Input argument #1</param>
    /// <returns>An MWArray containing the first output argument.</returns>
    ///
    public MWArray LucamTakeSnapshot(MWArray cameraNum)
    {
      return mcr.EvaluateFunction("LucamTakeSnapshot", cameraNum);
    }


    /// <summary>
    /// Provides the standard 0-input MWArray interface to the LucamTakeSnapshot MATLAB
    /// function.
    /// </summary>
    /// <remarks>
    /// M-Documentation:
    /// LucamTakeSnapshot - Takes a snapshot using the predefined settings.
    /// </remarks>
    /// <param name="numArgsOut">The number of output arguments to return.</param>
    /// <returns>An Array of length "numArgsOut" containing the output
    /// arguments.</returns>
    ///
    public MWArray[] LucamTakeSnapshot(int numArgsOut)
    {
      return mcr.EvaluateFunction(numArgsOut, "LucamTakeSnapshot", new MWArray[]{});
    }


    /// <summary>
    /// Provides the standard 1-input MWArray interface to the LucamTakeSnapshot MATLAB
    /// function.
    /// </summary>
    /// <remarks>
    /// M-Documentation:
    /// LucamTakeSnapshot - Takes a snapshot using the predefined settings.
    /// </remarks>
    /// <param name="numArgsOut">The number of output arguments to return.</param>
    /// <param name="cameraNum">Input argument #1</param>
    /// <returns>An Array of length "numArgsOut" containing the output
    /// arguments.</returns>
    ///
    public MWArray[] LucamTakeSnapshot(int numArgsOut, MWArray cameraNum)
    {
      return mcr.EvaluateFunction(numArgsOut, "LucamTakeSnapshot", cameraNum);
    }


    /// <summary>
    /// Provides an interface for the LucamTakeSnapshot function in which the input and
    /// output
    /// arguments are specified as an array of MWArrays.
    /// </summary>
    /// <remarks>
    /// This method will allocate and return by reference the output argument
    /// array.<newpara></newpara>
    /// M-Documentation:
    /// LucamTakeSnapshot - Takes a snapshot using the predefined settings.
    /// </remarks>
    /// <param name="numArgsOut">The number of output arguments to return</param>
    /// <param name= "argsOut">Array of MWArray output arguments</param>
    /// <param name= "argsIn">Array of MWArray input arguments</param>
    ///
    public void LucamTakeSnapshot(int numArgsOut, ref MWArray[] argsOut, MWArray[] argsIn)
    {
      mcr.EvaluateFunction("LucamTakeSnapshot", numArgsOut, ref argsOut, argsIn);
    }


    /// <summary>
    /// Provides a single output, 0-input MWArrayinterface to the main MATLAB function.
    /// </summary>
    /// <remarks>
    /// M-Documentation:
    /// Load config
    /// </remarks>
    /// <returns>An MWArray containing the first output argument.</returns>
    ///
    public MWArray main()
    {
      return mcr.EvaluateFunction("main", new MWArray[]{});
    }


    /// <summary>
    /// Provides a single output, 1-input MWArrayinterface to the main MATLAB function.
    /// </summary>
    /// <remarks>
    /// M-Documentation:
    /// Load config
    /// </remarks>
    /// <param name="file_name">Input argument #1</param>
    /// <returns>An MWArray containing the first output argument.</returns>
    ///
    public MWArray main(MWArray file_name)
    {
      return mcr.EvaluateFunction("main", file_name);
    }


    /// <summary>
    /// Provides a single output, 2-input MWArrayinterface to the main MATLAB function.
    /// </summary>
    /// <remarks>
    /// M-Documentation:
    /// Load config
    /// </remarks>
    /// <param name="file_name">Input argument #1</param>
    /// <param name="plotVal">Input argument #2</param>
    /// <returns>An MWArray containing the first output argument.</returns>
    ///
    public MWArray main(MWArray file_name, MWArray plotVal)
    {
      return mcr.EvaluateFunction("main", file_name, plotVal);
    }


    /// <summary>
    /// Provides the standard 0-input MWArray interface to the main MATLAB function.
    /// </summary>
    /// <remarks>
    /// M-Documentation:
    /// Load config
    /// </remarks>
    /// <param name="numArgsOut">The number of output arguments to return.</param>
    /// <returns>An Array of length "numArgsOut" containing the output
    /// arguments.</returns>
    ///
    public MWArray[] main(int numArgsOut)
    {
      return mcr.EvaluateFunction(numArgsOut, "main", new MWArray[]{});
    }


    /// <summary>
    /// Provides the standard 1-input MWArray interface to the main MATLAB function.
    /// </summary>
    /// <remarks>
    /// M-Documentation:
    /// Load config
    /// </remarks>
    /// <param name="numArgsOut">The number of output arguments to return.</param>
    /// <param name="file_name">Input argument #1</param>
    /// <returns>An Array of length "numArgsOut" containing the output
    /// arguments.</returns>
    ///
    public MWArray[] main(int numArgsOut, MWArray file_name)
    {
      return mcr.EvaluateFunction(numArgsOut, "main", file_name);
    }


    /// <summary>
    /// Provides the standard 2-input MWArray interface to the main MATLAB function.
    /// </summary>
    /// <remarks>
    /// M-Documentation:
    /// Load config
    /// </remarks>
    /// <param name="numArgsOut">The number of output arguments to return.</param>
    /// <param name="file_name">Input argument #1</param>
    /// <param name="plotVal">Input argument #2</param>
    /// <returns>An Array of length "numArgsOut" containing the output
    /// arguments.</returns>
    ///
    public MWArray[] main(int numArgsOut, MWArray file_name, MWArray plotVal)
    {
      return mcr.EvaluateFunction(numArgsOut, "main", file_name, plotVal);
    }


    /// <summary>
    /// Provides an interface for the main function in which the input and output
    /// arguments are specified as an array of MWArrays.
    /// </summary>
    /// <remarks>
    /// This method will allocate and return by reference the output argument
    /// array.<newpara></newpara>
    /// M-Documentation:
    /// Load config
    /// </remarks>
    /// <param name="numArgsOut">The number of output arguments to return</param>
    /// <param name= "argsOut">Array of MWArray output arguments</param>
    /// <param name= "argsIn">Array of MWArray input arguments</param>
    ///
    public void main(int numArgsOut, ref MWArray[] argsOut, MWArray[] argsIn)
    {
      mcr.EvaluateFunction("main", numArgsOut, ref argsOut, argsIn);
    }


    /// <summary>
    /// Provides a single output, 0-input MWArrayinterface to the particle_counter MATLAB
    /// function.
    /// </summary>
    /// <remarks>
    /// M-Documentation:
    /// Input
    /// </remarks>
    /// <returns>An MWArray containing the first output argument.</returns>
    ///
    public MWArray particle_counter()
    {
      return mcr.EvaluateFunction("particle_counter", new MWArray[]{});
    }


    /// <summary>
    /// Provides a single output, 1-input MWArrayinterface to the particle_counter MATLAB
    /// function.
    /// </summary>
    /// <remarks>
    /// M-Documentation:
    /// Input
    /// </remarks>
    /// <param name="vargin">Input argument #1</param>
    /// <returns>An MWArray containing the first output argument.</returns>
    ///
    public MWArray particle_counter(MWArray vargin)
    {
      return mcr.EvaluateFunction("particle_counter", vargin);
    }


    /// <summary>
    /// Provides the standard 0-input MWArray interface to the particle_counter MATLAB
    /// function.
    /// </summary>
    /// <remarks>
    /// M-Documentation:
    /// Input
    /// </remarks>
    /// <param name="numArgsOut">The number of output arguments to return.</param>
    /// <returns>An Array of length "numArgsOut" containing the output
    /// arguments.</returns>
    ///
    public MWArray[] particle_counter(int numArgsOut)
    {
      return mcr.EvaluateFunction(numArgsOut, "particle_counter", new MWArray[]{});
    }


    /// <summary>
    /// Provides the standard 1-input MWArray interface to the particle_counter MATLAB
    /// function.
    /// </summary>
    /// <remarks>
    /// M-Documentation:
    /// Input
    /// </remarks>
    /// <param name="numArgsOut">The number of output arguments to return.</param>
    /// <param name="vargin">Input argument #1</param>
    /// <returns>An Array of length "numArgsOut" containing the output
    /// arguments.</returns>
    ///
    public MWArray[] particle_counter(int numArgsOut, MWArray vargin)
    {
      return mcr.EvaluateFunction(numArgsOut, "particle_counter", vargin);
    }


    /// <summary>
    /// Provides an interface for the particle_counter function in which the input and
    /// output
    /// arguments are specified as an array of MWArrays.
    /// </summary>
    /// <remarks>
    /// This method will allocate and return by reference the output argument
    /// array.<newpara></newpara>
    /// M-Documentation:
    /// Input
    /// </remarks>
    /// <param name="numArgsOut">The number of output arguments to return</param>
    /// <param name= "argsOut">Array of MWArray output arguments</param>
    /// <param name= "argsIn">Array of MWArray input arguments</param>
    ///
    public void particle_counter(int numArgsOut, ref MWArray[] argsOut, MWArray[] argsIn)
    {
      mcr.EvaluateFunction("particle_counter", numArgsOut, ref argsOut, argsIn);
    }



    /// <summary>
    /// This method will cause a MATLAB figure window to behave as a modal dialog box.
    /// The method will not return until all the figure windows associated with this
    /// component have been closed.
    /// </summary>
    /// <remarks>
    /// An application should only call this method when required to keep the
    /// MATLAB figure window from disappearing.  Other techniques, such as calling
    /// Console.ReadLine() from the application should be considered where
    /// possible.</remarks>
    ///
    public void WaitForFiguresToDie()
    {
      mcr.WaitForFiguresToDie();
    }



    #endregion Methods

    #region Class Members

    private static MWMCR mcr= null;

    private static Exception ex_= null;

    private bool disposed= false;

    #endregion Class Members
  }
}
