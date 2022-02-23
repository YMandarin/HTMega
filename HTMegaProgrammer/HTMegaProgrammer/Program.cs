using System.Diagnostics;
using System.IO.Ports;

string[] input_extensions =
{
    ".hex",
    ".bin"
};

const int BAUDRATE = 6000000;
const Parity PARITY = Parity.Even;
const StopBits STOPBITS = StopBits.Two;
const byte START_BYTE = 0xf1;

try
{
    main();
}
catch (Exception e)
{

    throw e;
}

void main()
{
    Console.WriteLine("----------- HTMega programmer start ------------");
    Stopwatch stopwatch = new Stopwatch();
    stopwatch.Start();

    // expected arguments: input_file_path (optional)output_file_path
    string[] arguments = Environment.GetCommandLineArgs();

    if (arguments.Length < 2) // no input file
        throw new ArgumentError("no file given");

    string input_path = parsePath(arguments[1], input_extensions, true);

    if (arguments.Length == 2) // no com port given
    {
        string ports = "";
        foreach (var comPort in SerialPort.GetPortNames())
        {
            ports += comPort + ",";
        }
        if (ports.Length > 0)
            ports = ports[..-1];
        throw new ArgumentError($"Argument 2: no COM port given, following ports are available: {ports}");
        
    }
    else if (arguments.Length > 4) // too many arguments
    {
        throw new ArgumentError($"to many arguments: {arguments.Length}");
    }
    string portString = arguments[2].ToUpper();
    if (!SerialPort.GetPortNames().Contains(portString))
    {
        throw new ArgumentError($"COM Port not found: {arguments[2]}");
    }
    byte[] filebytes = File.ReadAllBytes(input_path);
    
    SerialPort port = new SerialPort();
    port.StopBits = STOPBITS;
    port.BaudRate = BAUDRATE;
    port.Parity = PARITY;
    port.PortName = portString;

    Console.WriteLine($"Start writing: {filebytes.Length} bytes");
    port.Open();
    port.Write(new byte[] { START_BYTE }, 0, 1);
    port.Write(filebytes, 0, filebytes.Length);
    stopwatch.Stop();
    Console.WriteLine($"------- Finished, runtime: {stopwatch.Elapsed.TotalMilliseconds}ms -------");
    port.Close();

}

string parsePath(string path, string[] allowedExtensions, bool isInput)
{
    // make relative path absolute
    if (!Path.IsPathRooted(path))
        path = Path.Combine(Environment.CurrentDirectory, path);

    if (!Path.HasExtension(path))
        throw new ArgumentError("expected file path, got: " + path);


    if (isInput && !File.Exists(path)) // test if input file exists
        throw new ArgumentError("input file does not exist: " + path);
    else
        Directory.CreateDirectory(Directory.GetParent(path).FullName);


    // check if file extension is allowed
    bool isAllowed = false;
    string formattedExtensions = "";
    foreach (string ext in allowedExtensions)
    {
        formattedExtensions += ext + ", ";
        if (Path.GetExtension(path) == ext)
            isAllowed = true;
    }
    formattedExtensions.Remove(formattedExtensions.Length - 1, 1);
    if (!isAllowed)
        throw new ArgumentError($"wrong file type of {path}, " +
            $"expected: {formattedExtensions}");

    return path;
}

public class ArgumentError : Exception
{
    public ArgumentError() { }
    public ArgumentError(string message) : base(message) { }
    public ArgumentError(string message, Exception inner) :
        base(message, inner)
    { }
    public ArgumentError(string message, int line) :
        base($"at line {line}: {message}")
    { }
    protected ArgumentError(
      System.Runtime.Serialization.SerializationInfo info,
      System.Runtime.Serialization.StreamingContext context) :
        base(info, context)
    { }
}


