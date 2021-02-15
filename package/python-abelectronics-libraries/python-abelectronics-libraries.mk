################################################################################
#
# python-abelectronics-libraries
#
################################################################################

PYTHON_ABELECTRONICS_LIBRARIES_VERSION = 2.2
PYTHON_ABELECTRONICS_LIBRARIES_SITE = $(call github,abelectronicsuk,abelectronics_python_libraries,bad1ece6aef4c9009f47ceff3ffcc5c60849540b)
PYTHON_ABELECTRONICS_LIBRARIES_SETUP_TYPE = distutils
PYTHON_ABELECTRONICS_LIBRARIES_LICENSE = GPL-2.0
PYTHON_ABELECTRONICS_LIBRARIES_LICENSE_FILES = LICENSE
#PYTHON_ABELECTRONICS_LIBRARIES_DEPENDENCIES = host-python-cffi

$(eval $(python-package))
