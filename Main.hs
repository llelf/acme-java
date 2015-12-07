import Data.Monoid
import Control.Applicative
import System.Process

findJDKIncludes :: IO [FilePath]
findJDKIncludes = pure [ base, base <> "/darwin" ]
    where
      base = "/Library/Java/JavaVirtualMachines/jdk1.8.0_25.jdk/Contents/Home/include"



jar = "jar"
ghc = "ghc"

compile = do
  includes <- (map ("-I"<>)) <$> findJDKIncludes
  callProcess ghc $ includes <> ["-static", "-fPIC", "start.c", "hello.hs", "-o", "hello.dylib" ]

createJAR = callProcess jar $ ["cfe", "hi.jar", "Main", "Main.class", "hello.dylib" ]



main = do compile
          createJAR
          putStrLn "Done."

