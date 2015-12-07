
#include "Main.h"
#include <stdio.h>
#include <dlfcn.h>

JNIEXPORT void JNICALL
Java_Main_runHaskell (JNIEnv *env, jclass class,
		      jstring j_lib)
{
  printf ("jni\n");

  const char *lib = (*env)->GetStringUTFChars (env, j_lib, 0);
  printf ("lib = %s\n", lib);

  void *dl = dlopen (lib, RTLD_LAZY);
  void *main = dlsym (dl, "main");
  printf ("main = %p\n", main);
  int argc = 1;
  char *argv[] = { "<haskell-code>", 0 };
  ((int (*)(int, char*[])) main) (argc, argv);
}

