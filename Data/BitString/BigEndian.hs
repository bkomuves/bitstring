{-# LANGUAGE CPP, BangPatterns #-}

#define BITSTRING_BIGENDIAN

-- | Lazy, big-endian bitstrings, somewhat similar to lazy bytestrings.
--
-- In this context, \"big-endian\" means that the bits in the bytes
-- are in the opposite order than what would be logical. If you ask me,
-- this is doesn't make too much sense, but this convention apparently still
-- have usage...
--
-- This module is intended to be imported qualified.
--

module Data.BitString.BigEndian

#include "BitString.inc"
