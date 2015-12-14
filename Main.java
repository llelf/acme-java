import java.io.*;

class Main {

    public static void main(String... args)
    {
    }

    static {
	try {

	    String fname = "haskell", fext = ".lib";
	    String f = fname + fext;
	    File temp = File.createTempFile(fname, fext);
	    temp.deleteOnExit();

	    InputStream is = Main.class.getResourceAsStream(f);
	    System.out.println(is);

	    byte[] buffer = new byte[2048];
	    OutputStream out = new FileOutputStream(temp);
	    int c;

	    while ((c = is.read(buffer)) >= 0)
		out.write(buffer, 0, c);

	    String lib = temp.getAbsolutePath();
	    System.load(lib);

	    System.out.println(lib);
	    System.out.println("go:");
	    runHaskell(lib);
	    System.out.println("done.");
	    
	} catch (IOException e) {
	    throw new RuntimeException(e);
	}
    }

    static native void runHaskell(String lib);

}



