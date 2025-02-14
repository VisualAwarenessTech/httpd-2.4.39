# Licensed to the Apache Software Foundation (ASF) under one
# or more contributor license agreements.  See the NOTICE file
# distributed with this work for additional information
# regarding copyright ownership.  The ASF licenses this file
# to you under the Apache License, Version 2.0 (the
# "License"); you may not use this file except in compliance
# with the License.  You may obtain a copy of the License at
# 
#   http://www.apache.org/licenses/LICENSE-2.0
# 
# Unless required by applicable law or agreed to in writing,
# software distributed under the License is distributed on an
# "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
# KIND, either express or implied.  See the License for the
# specific language governing permissions and limitations
# under the License.

# - Find Apache Portable Runtime
# Find the APR includes and libraries
# This module defines
#  APR_INCLUDE_DIR and APRUTIL_INCLUDE_DIR, where to find apr.h, etc.
#  APR_LIBRARIES and APRUTIL_LIBRARIES, the libraries needed to use APR.
#  APR_FOUND and APRUTIL_FOUND, If false, do not try to use APR.
# also defined, but not for general use are
#  APR_LIBRARY and APRUTIL_LIBRARY, where to find the APR library.

# APR first.
MESSAGE("Specialized FindAPR Called")
if( NOT $ENV{APR_LIBRARY} STREQUAL "" )
  SET(APR_LIBRARY $ENV{APR_LIBRARY})
  MESSAGE("Set APR_LIBRARY")

  if( NOT $ENV{APR_INCLUDE_DIR} STREQUAL "" )
     SET(APR_INCLUDE_DIR $ENV{APR_INCLUDE_DIR})
     MESSAGE("Set APR_INCLUDE_DIR")
  else()
     SET(APR_INCLUDE_DIR "AprIncludeDir")
  endif()

  if( NOT $ENV{APR_PATH} STREQUAL "" )
     SET(APR_DIR $ENV{APR_PATH})
 	MESSAGE("Set APR_DIR")
  else()
     SET(APR_DIR "AprPathDir")
  endif()

  if( NOT $ENV{APR_CONFIG_BIN} STREQUAL "" )
     SET(APR_CONFIG_BIN $ENV{APR_CONFIG_BIN})
 	MESSAGE("Set APR_CONFIG_BIN")
  endif()

  if(APR_CONFIG_BIN)
   execute_process(
      COMMAND ${APR_CONFIG_BIN} --includedir
      OUTPUT_VARIABLE HINT_APR_INCLUDE_DIR
      OUTPUT_STRIP_TRAILING_WHITESPACE
   )
   execute_process(
      COMMAND ${APR_CONFIG_BIN} --cppflags
      OUTPUT_VARIABLE APR_CPPFLAGS
      OUTPUT_STRIP_TRAILING_WHITESPACE
   )
  endif(APR_CONFIG_BIN)

  mark_as_advanced(APR_LIBRARY APR_INCLUDE_DIR)

  SET(APR_FOUND TRUE)

  if( NOT $ENV{APRUTIL_LIBRARY} STREQUAL "" )
  	SET(APRUTIL_LIBRARY $ENV{APRUTIL_LIBRARY})
	SET(APU_LIBRARY, ${APRUTIL_LIBRARY})
 	MESSAGE("Set APRUTIL_LIBRARY")
  endif()

  if( NOT $ENV{APR_LDAP_LIBRARY} STREQUAL "" )
  	SET(APR_LDAP_LIBRARY $ENV{APR_LDAP_LIBRARY})
 	MESSAGE("Set APR_LDAP_LIBRARY")
  endif()

  if( NOT $ENV{APR_UTIL_INCLUDE_DIR} STREQUAL "" )
  	SET(APR_UTIL_INCLUDE_DIR $ENV{APR_UTIL_INCLUDE_DIR})
     SET(APU_INCLUDE_DIR ${APR_UTIL_INCLUDE_DIR})
 	MESSAGE("Set APR_UTIL_INCLUDE_DIR")
  endif()

  set(APU_INCLUDE_DIRS ${APU_INCLUDE_DIR})
  set(APU_LIBRARIES ${APU_LIBRARY})
  mark_as_advanced(APU_LIBRARY APU_INCLUDE_DIR)
 
  if(APRUTIL_LIBRARY)
    set(APRUTIL_FOUND TRUE)
    set(APU_FOUND TRUE)
    MESSAGE("Set APRUTIL_FOUND")
  endif()

  MESSAGE("FindAPR Set By Envionment")

else()

FIND_PROGRAM(APR_CONFIG_BIN
   NAMES apr-config apr-1-config )

if(APR_CONFIG_BIN)
   execute_process(
      COMMAND ${APR_CONFIG_BIN} --includedir
      OUTPUT_VARIABLE HINT_APR_INCLUDE_DIR
      OUTPUT_STRIP_TRAILING_WHITESPACE
   )
   execute_process(
      COMMAND ${APR_CONFIG_BIN} --cppflags
      OUTPUT_VARIABLE APR_CPPFLAGS
      OUTPUT_STRIP_TRAILING_WHITESPACE
   )
endif(APR_CONFIG_BIN)

FIND_PATH(APR_INCLUDE_DIR
   NAMES apr.h
   HINTS ${HINT_APR_INCLUDE_DIR}
   PATH_SUFFIXES apr-1 apr-1.0 apr 
)

FIND_LIBRARY(APR_LIBRARY
  NAMES apr-1 apr
  PATH_SUFFIXES apr-1 apr-1.0 apr
)

set(APR_INCLUDE_DIRS ${APR_INCLUDE_DIR})
set(APR_LIBRARIES ${APR_LIBRARY})
include(FindPackageHandleStandardArgs)
find_package_handle_standard_args(APR DEFAULT_MSG APR_LIBRARY APR_INCLUDE_DIR)
mark_as_advanced(APR_LIBRARY APR_INCLUDE_DIR)

# Next, APRUTIL.

FIND_PATH(APU_INCLUDE_DIR
   NAMES apu.h
   PATH_SUFFIXES apr-1 apr-1.0 apr 
)

FIND_LIBRARY(APU_LIBRARY
  NAMES aprutil-1 aprutil
  PATH_SUFFIXES apr-1 apr-1.0 apr
)


set(APU_INCLUDE_DIRS ${APU_INCLUDE_DIR})
set(APU_LIBRARIES ${APU_LIBRARY})
find_package_handle_standard_args(APU DEFAULT_MSG APU_LIBRARY APU_INCLUDE_DIR)
mark_as_advanced(APU_LIBRARY APU_INCLUDE_DIR)
endif()