/*
 * Copyright (C) 2014 Love Park Robotics, LLC
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 * http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distribted on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

#include "o3d3xx/err.h"
#include <cstring>

const int O3D3XX_NO_ERRORS = 0;
const int O3D3XX_XMLRPC_FAILURE = -9000;
const int O3D3XX_THREAD_INTERRUPTED = -9001;
const int O3D3XX_IMG_CHUNK_NOT_FOUND = -9002;
const int O3D3XX_XMLRPC_TIMEOUT = -9003;
const int O3D3XX_XMLRPC_FINFAIL = -9004;
const int O3D3XX_XMLRPC_OBJ_NOT_FOUND = -9005;
const int O3D3XX_XMLRPC_INVALID_PARAM = -9006;

const char *o3d3xx::strerror(int errnum)
{
  switch (errnum) {
  case O3D3XX_NO_ERRORS:
    return "OK";
  case O3D3XX_XMLRPC_FAILURE:
    return "Unknown XMLRPC failure";
  case O3D3XX_THREAD_INTERRUPTED:
    return "Thread interrupted";
  case O3D3XX_IMG_CHUNK_NOT_FOUND:
    return "Image chunk not found";
  case O3D3XX_XMLRPC_TIMEOUT:
    return "XMLRPC call timed out";
  case O3D3XX_XMLRPC_FINFAIL:
    return "XMLRPC finished but the called failed";
  case O3D3XX_XMLRPC_OBJ_NOT_FOUND:
    return "XMLRPC server object not found";
  case O3D3XX_XMLRPC_INVALID_PARAM:
    return "XMLRPC requested parameter is invalid";
  default:
    return ::strerror(errnum);
  }
}

o3d3xx::error_t::error_t(int errnum)
  : std::exception(), errnum_(errnum) { }

int o3d3xx::error_t::code() const noexcept
{
  return this->errnum_;
}

const char *o3d3xx::error_t::what() const noexcept
{
  return o3d3xx::strerror(this->code());
}