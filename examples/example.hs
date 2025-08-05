
module Main where

--------------------------------------------------------------------------------

import Data.Bits
import Data.Word

import qualified Data.ByteString.Lazy     as ByteL 
import qualified Data.ByteString          as Byte  ; import Data.ByteString (ByteString) 
import qualified Data.BitString           as Bit   ; import Data.BitString  (BitString) 
import qualified Data.BitString.BigEndian as BE    

--------------------------------------------------------------------------------

wordToBool :: Word8 -> Bool
wordToBool 0 = False
wordToBool 1 = True

boolToWord :: Bool -> Word8
boolToWord False = 0
boolToWord True  = 1

-- little-endian
wordToBitsLE :: Word8 -> [Bool]
wordToBitsLE w = [ wordToBool (shiftR w k .&. 1) | k<-[0..7] ]

-- big-endian
wordToBitsBE :: Word8 -> [Bool]
wordToBitsBE = reverse . wordToBitsLE

wordTo01LE :: Word8 -> [Word8]
wordTo01LE = map boolToWord . wordToBitsLE

wordTo01BE :: Word8 -> [Word8]
wordTo01BE = map boolToWord . wordToBitsBE

--------------------------------------------------------------------------------

bits :: [[Bool]]
bits = [ True : replicate n False | n<-[0..34] ]

bs :: BitString
bs = Bit.concat (map Bit.fromList bits)

bs' :: BitString
bs' = Bit.fromList (concat bits)

re :: [Bool]
re = concatMap wordToBitsLE $ Byte.unpack $ Bit.realizeBitStringStrict bs

reL :: [Bool]
reL = concatMap wordToBitsLE $ ByteL.unpack $ Bit.realizeBitStringLazy bs

--------------------------------------------------------------------------------

main = do
  putStrLn "hello, bitstring"
  print (bs == bs')
  print (Bit.toList bs == Bit.toList bs')  
  print (re == reL)
  print $ and $ zipWith (==) re (concat bits)
