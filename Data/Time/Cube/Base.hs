{-# LANGUAGE DataKinds                  #-}
{-# LANGUAGE DeriveGeneric              #-}
{-# LANGUAGE FlexibleContexts           #-}
{-# LANGUAGE GeneralizedNewtypeDeriving #-}
{-# LANGUAGE MultiParamTypeClasses      #-}
{-# LANGUAGE StandaloneDeriving         #-}
{-# LANGUAGE TypeFamilies               #-}
{-# LANGUAGE UndecidableInstances       #-}
{-# OPTIONS -Wall                       #-}

-- |
-- Module      : Data.Time.Cube.Base
-- Copyright   : Copyright (c) 2014, Alpha Heavy Industries, Inc.
-- License     : BSD3
-- Maintainer  : Enzo Haussecker <enzo@ucsd.edu>
-- Stability   : Stable
-- Portability : Portable
--
-- Basic definitions, including data types, data families, and new types.
module Data.Time.Cube.Base (

 -- ** Classes
       Human(..)
     , Math(..)

 -- ** Chronologies
     , Calendar(..)
     , Era
     , Epoch(..)

 -- ** Components
     , Year(..)
     , Month
     , Day(..)
     , DayOfWeek
     , Hour(..)
     , Minute(..)
     , Second(..)
     , Millis(..)
     , Micros(..)
     , Nanos(..)
     , Picos(..)

 -- ** Structs
     , DateStruct(..)
     , TimeStruct(..)
     , DateTimeStruct(..)
     , LocalDateStruct(..)
     , LocalTimeStruct(..)
     , LocalDateTimeStruct(..)

 -- ** Fractions
     , properFracMillis
     , properFracMicros
     , properFracNanos
     , properFracPicos

     ) where

import Control.DeepSeq (NFData)
import Data.Int (Int32, Int64)
import Data.Time.Cube.Zone (TimeZone)
import GHC.Generics (Generic)
import Text.Printf (PrintfArg)

class Human x where

   -- |
   -- Define the human-readable components of a timestamp.
   type Components x :: *

   -- |
   -- Pack a timestamp from human-readable components.
   pack :: Components x -> x

   -- |
   -- Unpack a timestamp into human-readable components.
   unpack :: x -> Components x

class Math x c where

   -- |
   -- Compute the duration between two timestamps.
   duration :: x -> x -> c

   -- |
   -- Add time to a timestamp.
   plus :: x -> c -> x

-- |
-- System for organizing dates.
data Calendar =
     Darian
   | Gregorian
   | Hebrew
   | Islamic
   | Japanese
   | Julian
   deriving (Eq, Enum, Generic, Ord, Read, Show)

-- |
-- System for numbering years.
data family Era (cal :: Calendar) :: *

-- |
-- System origin.
data Epoch =
     UnixEpoch
   deriving (Eq, Enum, Generic, Ord, Read, Show)

-- |
-- Year.
newtype Year = Year {getYear :: Int32}
   deriving (Bounded, Enum, Eq, Generic, Integral, NFData, Num, Ord, PrintfArg, Real, Show)

-- |
-- Month.
data family Month (cal :: Calendar) :: *

-- |
-- Day.
newtype Day = Day {getDay :: Int32}
   deriving (Bounded, Enum, Eq, Generic, Integral, NFData, Num, Ord, PrintfArg, Real, Show)

-- |
-- Day of week.
data family DayOfWeek (cal :: Calendar) :: *

-- |
-- Hour.
newtype Hour = Hour {getHour :: Int64}
   deriving (Bounded, Enum, Eq, Generic, Integral, NFData, Num, Ord, PrintfArg, Real, Show)

-- |
-- Minute.
newtype Minute = Minute {getMinute :: Int64}
   deriving (Bounded, Enum, Eq, Generic, Integral, NFData, Num, Ord, PrintfArg, Real, Show)

-- |
-- Second.
newtype Second = Second {getSecond :: Int64}
   deriving (Bounded, Enum, Eq, Generic, Integral, NFData, Num, Ord, PrintfArg, Real, Show)

-- |
-- Millisecond.
newtype Millis = Millis {getMillis :: Int64}
   deriving (Bounded, Enum, Eq, Generic, Integral, NFData, Num, Ord, PrintfArg, Real, Show)

-- |
-- Microsecond.
newtype Micros = Micros {getMicros :: Int64}
   deriving (Bounded, Enum, Eq, Generic, Integral, NFData, Num, Ord, PrintfArg, Real, Show)

-- |
-- Nanosecond.
newtype Nanos = Nanos {getNanos :: Int64}
   deriving (Bounded, Enum, Eq, Generic, Integral, NFData, Num, Ord, PrintfArg, Real, Show)

-- |
-- Picosecond.
newtype Picos = Picos {getPicos :: Int64}
   deriving (Bounded, Enum, Eq, Generic, Integral, NFData, Num, Ord, PrintfArg, Real, Show)

-- |
-- A struct with date components.
data DateStruct (cal :: Calendar) =
     DateStruct
       { _d_year :: {-# UNPACK #-} !Year
       , _d_mon  ::                !(Month     cal)
       , _d_mday :: {-# UNPACK #-} !Day
       , _d_wday ::                !(DayOfWeek cal)
       } deriving Generic

-- |
-- A struct with time components.
data TimeStruct =
     TimeStruct
       { _t_hour :: {-# UNPACK #-} !Hour
       , _t_min  :: {-# UNPACK #-} !Minute
       , _t_sec  :: {-# UNPACK #-} !Double
       } deriving (Eq, Generic, Ord, Show)

-- |
-- A struct with date and time components.
data DateTimeStruct (cal :: Calendar) =
     DateTimeStruct
       { _dt_year :: {-# UNPACK #-} !Year
       , _dt_mon  ::                !(Month     cal)
       , _dt_mday :: {-# UNPACK #-} !Day
       , _dt_wday ::                !(DayOfWeek cal)
       , _dt_hour :: {-# UNPACK #-} !Hour
       , _dt_min  :: {-# UNPACK #-} !Minute
       , _dt_sec  :: {-# UNPACK #-} !Double
       } deriving Generic

-- |
-- A struct with date and location components.
data LocalDateStruct (cal :: Calendar) =
     LocalDateStruct
       { _ld_year :: {-# UNPACK #-} !Year
       , _ld_mon  ::                !(Month     cal)
       , _ld_mday :: {-# UNPACK #-} !Day
       , _ld_wday ::                !(DayOfWeek cal)
       , _ld_zone ::                !TimeZone
       } deriving Generic

-- |
-- A struct with time and location components.
data LocalTimeStruct =
     LocalTimeStruct
       { _lt_hour :: {-# UNPACK #-} !Hour
       , _lt_min  :: {-# UNPACK #-} !Minute
       , _lt_sec  :: {-# UNPACK #-} !Double
       , _lt_zone ::                !TimeZone
       } deriving (Eq, Generic, Ord, Show)

-- |
-- A struct with date, time and location components.
data LocalDateTimeStruct (cal :: Calendar) =
     LocalDateTimeStruct
       { _ldt_year :: {-# UNPACK #-} !Year
       , _ldt_mon  ::                !(Month     cal)
       , _ldt_mday :: {-# UNPACK #-} !Day
       , _ldt_wday ::                !(DayOfWeek cal)
       , _ldt_hour :: {-# UNPACK #-} !Hour
       , _ldt_min  :: {-# UNPACK #-} !Minute
       , _ldt_sec  :: {-# UNPACK #-} !Double
       , _ldt_zone ::                !TimeZone
       } deriving Generic

deriving instance (Eq (Month cal), Eq (DayOfWeek cal)) => Eq (DateStruct          cal)
deriving instance (Eq (Month cal), Eq (DayOfWeek cal)) => Eq (DateTimeStruct      cal)
deriving instance (Eq (Month cal), Eq (DayOfWeek cal)) => Eq (LocalDateStruct     cal)
deriving instance (Eq (Month cal), Eq (DayOfWeek cal)) => Eq (LocalDateTimeStruct cal)

deriving instance (Ord (Month cal), Ord (DayOfWeek cal)) => Ord (DateStruct          cal)
deriving instance (Ord (Month cal), Ord (DayOfWeek cal)) => Ord (DateTimeStruct      cal)
deriving instance (Ord (Month cal), Ord (DayOfWeek cal)) => Ord (LocalDateStruct     cal)
deriving instance (Ord (Month cal), Ord (DayOfWeek cal)) => Ord (LocalDateTimeStruct cal)

deriving instance (Show (Month cal), Show (DayOfWeek cal)) => Show (DateStruct          cal)
deriving instance (Show (Month cal), Show (DayOfWeek cal)) => Show (DateTimeStruct      cal)
deriving instance (Show (Month cal), Show (DayOfWeek cal)) => Show (LocalDateStruct     cal)
deriving instance (Show (Month cal), Show (DayOfWeek cal)) => Show (LocalDateTimeStruct cal)

-- |
-- Decompose a floating point number into second and millisecond components.
properFracMillis :: RealFrac a => a -> (Second, Millis)
properFracMillis frac = if millis == 1000 then (sec + 1, 0) else res
   where res@(sec, millis) = fmap (round . (*) 1000) $ properFraction frac

-- |
-- Decompose a floating point number into second and microsecond components.
properFracMicros :: RealFrac a => a -> (Second, Micros)
properFracMicros frac = if micros == 1000000 then (sec + 1, 0) else res
   where res@(sec, micros) = fmap (round . (*) 1000000) $ properFraction frac

-- |
-- Decompose a floating point number into second and nanosecond components.
properFracNanos :: RealFrac a => a -> (Second, Nanos)
properFracNanos frac = if nanos == 1000000000 then (sec + 1, 0) else res
   where res@(sec, nanos) = fmap (round . (*) 1000000000) $ properFraction frac

-- |
-- Decompose a floating point number into second and picosecond components.
properFracPicos :: RealFrac a => a -> (Second, Picos)
properFracPicos frac = if picos == 1000000000000 then (sec + 1, 0) else res
   where res@(sec, picos) = fmap (round . (*) 1000000000000) $ properFraction frac 
