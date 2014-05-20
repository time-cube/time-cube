{-# LANGUAGE DataKinds            #-}
{-# LANGUAGE DeriveGeneric        #-}
{-# LANGUAGE FlexibleContexts     #-}
{-# LANGUAGE KindSignatures       #-}
{-# LANGUAGE StandaloneDeriving   #-}
{-# LANGUAGE UndecidableInstances #-}
{-# OPTIONS -Wall                 #-}

-- |
-- Module      : Data.Time.Cube.Structs
-- Copyright   : Copyright (c) 2014, Alpha Heavy Industries, Inc. All rights reserved.
-- License     : Apache License, Version 2.0
-- Maintainer  : Enzo Haussecker <enzo@ucsd.edu>
-- Stability   : Experimental
-- Portability : Untested
--
--
-- Struct datatypes for dates and time.
--
module Data.Time.Cube.Structs where

import Data.Time.Cube.Base
import Data.Time.Cube.Calendar.Gregorian
import Data.Time.Cube.Zones
import GHC.Generics (Generic)

-- | A struct with date components.
data DateStruct (cal :: Calendar) =
     DateStruct
       { _d_year :: {-# UNPACK #-} !(Year)
       , _d_mon  ::                !(Month     (cal :: Calendar))
       , _d_mday :: {-# UNPACK #-} !(Day)
       , _d_wday ::                !(DayOfWeek (cal :: Calendar))
       } deriving (Generic)

deriving instance (Eq   (Month      (cal :: Calendar)),
                   Eq   (DayOfWeek  (cal :: Calendar))) =>
                   Eq   (DateStruct (cal :: Calendar))

deriving instance (Ord  (Month      (cal :: Calendar)),
                   Ord  (DayOfWeek  (cal :: Calendar))) =>
                   Ord  (DateStruct (cal :: Calendar))

deriving instance (Show (Month      (cal :: Calendar)),
                   Show (DayOfWeek  (cal :: Calendar))) =>
                   Show (DateStruct (cal :: Calendar))

-- | A struct with time components.
data TimeStruct =
     TimeStruct
       { _t_hour :: {-# UNPACK #-} !Hour
       , _t_min  :: {-# UNPACK #-} !Minute
       , _t_sec  :: {-# UNPACK #-} !Double
       } deriving (Eq, Generic, Ord, Show)

-- | A struct with date and time components.
data DateTimeStruct (cal :: Calendar) =
     DateTimeStruct
       { _dt_year :: {-# UNPACK #-} !(Year)
       , _dt_mon  ::                !(Month     (cal :: Calendar))
       , _dt_mday :: {-# UNPACK #-} !(Day)
       , _dt_wday ::                !(DayOfWeek (cal :: Calendar))
       , _dt_hour :: {-# UNPACK #-} !(Hour)
       , _dt_min  :: {-# UNPACK #-} !(Minute)
       , _dt_sec  :: {-# UNPACK #-} !(Double)
       } deriving (Generic)

deriving instance (Eq   (Month          (cal :: Calendar)),
                   Eq   (DayOfWeek      (cal :: Calendar))) =>
                   Eq   (DateTimeStruct (cal :: Calendar))
 
deriving instance (Ord  (Month          (cal :: Calendar)),
                   Ord  (DayOfWeek      (cal :: Calendar))) =>
                   Ord  (DateTimeStruct (cal :: Calendar))

deriving instance (Show (Month          (cal :: Calendar)),
                   Show (DayOfWeek      (cal :: Calendar))) =>
                   Show (DateTimeStruct (cal :: Calendar))

-- | A struct with date and time zone components.
data ZonedDateStruct (cal :: Calendar) =
     ZonedDateStruct
       { _zd_year :: {-# UNPACK #-} !(Year)
       , _zd_mon  ::                !(Month     (cal :: Calendar))
       , _zd_mday :: {-# UNPACK #-} !(Day)
       , _zd_wday ::                !(DayOfWeek (cal :: Calendar))
       , _zd_zone ::                !(TimeZone)
       } deriving (Generic)

deriving instance (Eq   (Month           (cal :: Calendar)),
                   Eq   (DayOfWeek       (cal :: Calendar))) =>
                   Eq   (ZonedDateStruct (cal :: Calendar))
 
deriving instance (Ord  (Month           (cal :: Calendar)),
                   Ord  (DayOfWeek       (cal :: Calendar))) =>
                   Ord  (ZonedDateStruct (cal :: Calendar))

deriving instance (Show (Month           (cal :: Calendar)),
                   Show (DayOfWeek       (cal :: Calendar))) =>
                   Show (ZonedDateStruct (cal :: Calendar))

-- | A struct with time and time zone components.
data ZonedTimeStruct =
     ZonedTimeStruct
       { _zt_hour :: {-# UNPACK #-} !Hour
       , _zt_min  :: {-# UNPACK #-} !Minute
       , _zt_sec  :: {-# UNPACK #-} !Double
       , _zt_zone ::                !TimeZone
       } deriving (Eq, Generic, Ord, Show)

-- | A struct with date, time and time zone components.
data ZonedDateTimeStruct (cal :: Calendar) =
     ZonedDateTimeStruct
       { _zdt_year :: {-# UNPACK #-} !(Year)
       , _zdt_mon  ::                !(Month     (cal :: Calendar))
       , _zdt_mday :: {-# UNPACK #-} !(Day)
       , _zdt_wday ::                !(DayOfWeek (cal :: Calendar))
       , _zdt_hour :: {-# UNPACK #-} !(Hour)
       , _zdt_min  :: {-# UNPACK #-} !(Minute)
       , _zdt_sec  :: {-# UNPACK #-} !(Double)
       , _zdt_zone ::                !(TimeZone)
       } deriving (Generic)

deriving instance (Eq   (Month               (cal :: Calendar)),
                   Eq   (DayOfWeek           (cal :: Calendar))) =>
                   Eq   (ZonedDateTimeStruct (cal :: Calendar))

deriving instance (Ord  (Month               (cal :: Calendar)),
                   Ord  (DayOfWeek           (cal :: Calendar))) =>
                   Ord  (ZonedDateTimeStruct (cal :: Calendar))

deriving instance (Show (Month               (cal :: Calendar)),
                   Show (DayOfWeek           (cal :: Calendar))) =>
                   Show (ZonedDateTimeStruct (cal :: Calendar))
