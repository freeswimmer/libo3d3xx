function(get_ubuntu_version VERSION_STRING)
  set(UBUNTU_VERSION ${VERSION_STRING})
  set(UBUNTU_MAJOR "0")
  set(UBUNTU_MINOR "0")
  set(UBUNTU_PATCH "0")

  set(ETC_ISSUE "/etc/issue")
  set(ETC_ISSUE_CONTENTS "")

  if (UBUNTU_VERSION VERSION_EQUAL "0.0.0")
    if(EXISTS ${ETC_ISSUE})
      file(READ "${ETC_ISSUE}" ETC_ISSUE_CONTENTS)
      string(REGEX MATCH
        "([0-9]+\\.)([0-9]+\\.?)([0-9]?)"
        UBUNTU_VERSION ${ETC_ISSUE_CONTENTS})
    else()
      MESSAGE(WARNING "Could not read: " ${ETC_ISSUE})
    endif()
  endif()

  string(REPLACE "." ";" UBUNTU_VERSION_LIST ${UBUNTU_VERSION})
  list(LENGTH UBUNTU_VERSION_LIST vlen)
  if(NOT (vlen LESS 3))
    list(GET UBUNTU_VERSION_LIST 0 UBUNTU_MAJOR)
    list(GET UBUNTU_VERSION_LIST 1 UBUNTU_MINOR)
    list(GET UBUNTU_VERSION_LIST 2 UBUNTU_PATCH)
  elseif(NOT (vlen LESS 2))
    list(GET UBUNTU_VERSION_LIST 0 UBUNTU_MAJOR)
    list(GET UBUNTU_VERSION_LIST 1 UBUNTU_MINOR)
  elseif(NOT (vlen LESS 1))
    list(GET UBUNTU_VERSION_LIST 0 UBUNTU_MAJOR)
  endif()

  set(UBUNTU_VERSION ${UBUNTU_VERSION} PARENT_SCOPE)
  set(UBUNTU_MAJOR ${UBUNTU_MAJOR} PARENT_SCOPE)
  set(UBUNTU_MINOR ${UBUNTU_MINOR} PARENT_SCOPE)
  set(UBUNTU_PATCH ${UBUNTU_PATCH} PARENT_SCOPE)

  # MESSAGE(STATUS "${ETC_ISSUE}: " ${ETC_ISSUE_CONTENTS})
  MESSAGE(STATUS "UBUNTU_VERSION: " ${UBUNTU_VERSION})
  MESSAGE(STATUS "UBUNTU_MAJOR: " ${UBUNTU_MAJOR})
  MESSAGE(STATUS "UBUNTU_MINOR: " ${UBUNTU_MINOR})
  MESSAGE(STATUS "UBUNTU_PATCH: " ${UBUNTU_PATCH})
endfunction()

# To explicitly set your ubuntu version:
# cmake -DUBUNTU_VERSION:STRING=16.04 ..
set(UBUNTU_VERSION "0.0.0" CACHE STRING
    "User-overridable detected version of Ubuntu")