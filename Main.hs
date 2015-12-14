import Data.Monoid
import Control.Applicative
import System.Environment
import System.Process
import Text.Printf

findJDKIncludes :: IO [FilePath]
findJDKIncludes = pure [ base, base <> "/darwin" ]
    where
      base = "/Library/Java/JavaVirtualMachines/jdk1.8.0_25.jdk/Contents/Home/include"



jar = "jar"
ghc = "ghc"

haskellLib = "haskell.lib"

jarName hsFile = name <> ".jar"
    where (name,ext) = break (=='.') hsFile


compile file = do
  includes <- (map ("-I"<>)) <$> findJDKIncludes
  callProcess ghc $ includes <> ["-static", "-fPIC",
                                 "start.c",
                                 file, "-o", haskellLib ]

createJAR file = callProcess jar $ ["cfe", jarName file,
                                    "Main", "Main.class", haskellLib ]

main = do file <- head <$> getArgs
          compile file
          createJAR file
          putStrLn $ printf "Done, %s created." (jarName file)

