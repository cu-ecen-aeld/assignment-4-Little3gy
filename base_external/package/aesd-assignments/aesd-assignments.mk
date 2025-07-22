################################################################################
#
# aesd-assignments
#
################################################################################
# Version needs to be updated to the latest commit ID of your aesd-assignments repo
# This should be the commit ID where you added the aesdsocket-start-stop script
# You can get this by running 'git rev-parse HEAD' in your aesd-assignments/server directory

AESD_ASSIGNMENTS_VERSION = 61abd91
AESD_ASSIGNMENTS_SITE = git@github.com:cu-ecen-aeld/assignments-3-and-later-Little3gy.git
AESD_ASSIGNMENTS_SITE_METHOD = git
# Ensure this is set to YES if your aesd-assignments repo itself contains submodules
# (e.g., if it's setup like the base aeld-assignments repo from the class)
AESD_ASSIGNMENTS_GIT_SUBMODULES = YES

# Set the source directory to the 'server' subdirectory within aesd-assignments
# This tells Buildroot to run 'make' from this specific directory
#AESD_ASSIGNMENTS_SUBDIR = server

# Define environment variables for make if needed (e.g., for cross-compilation)
AESD_ASSIGNMENTS_MAKE_ENV = $(TARGET_MAKE_ENV)

# Define make options. V=1 for verbose output, which can be helpful for debugging.
# The Makefile in your 'server' directory should handle the compilation.
#AESD_ASSIGNMENTS_MAKE_OPTS = V=1

# THIS WAS MISSING - Define the build commands
define AESD_ASSIGNMENTS_BUILD_CMDS
	$(MAKE) $(TARGET_CONFIGURE_OPTS) -C $(@D)/server all
	$(MAKE) $(TARGET_CONFIGURE_OPTS) -C $(@D)/finder-app all
endef

# Define commands to install the compiled application to the target root filesystem
# $(TARGET_DIR) is the root directory of the target filesystem being built
define AESD_ASSIGNMENTS_INSTALL_TARGET_CMDS

	# Install the aesdsocket executable to /usr/bin
	$(INSTALL) -m 0755 $(@D)/server/aesdsocket $(TARGET_DIR)/usr/bin/

	# Install the aesdsocket-start-stop script to /etc/init.d/S99aesdsocket
	$(INSTALL) -m 0755 $(@D)/server/aesdsocket-start-stop $(TARGET_DIR)/etc/init.d/S99aesdsocket
	
	# Install configuration directory and files
	$(INSTALL) -d -m 0755 $(TARGET_DIR)/etc/finder-app/conf/
	$(INSTALL) -m 0644 $(@D)/conf/* $(TARGET_DIR)/etc/finder-app/conf/
	
	# Install finder-app utilities
	$(INSTALL) -m 0755 $(@D)/finder-app/writer $(TARGET_DIR)/usr/bin/ #writer app cross compiled
	$(INSTALL) -m 0755 $(@D)/finder-app/finder.sh $(TARGET_DIR)/usr/bin/ # finder.sh location in assignment 3 repository
	$(INSTALL) -m 0755 $(@D)/finder-app/finder-test.sh $(TARGET_DIR)/usr/bin/  # finder-test.sh location in assignment 3 repository
										   # in the assignment instructions it's refering to finder.sh, no such a file

	# Install test utilities
	$(INSTALL) -m 0755 $(@D)/assignment-autotest/test/assignment4/* $(TARGET_DIR)/bin/
endef

# This ensures the package is built after the toolchain is ready
$(eval $(generic-package))
