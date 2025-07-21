################################################################################
#
# aesd-assignments
#
################################################################################
# Version needs to be updated to the latest commit ID of your aesd-assignments repo
# This should be the commit ID where you added the aesdsocket-start-stop script
# You can get this by running 'git rev-parse HEAD' in your aesd-assignments/server directory
AESD_ASSIGNMENTS_VERSION = 2e4c588254787933c94a0fd8bc812618a4f83a52
AESD_ASSIGNMENTS_SITE = git@github.com:cu-ecen-aeld/assignments-3-and-later-Little3gy.git
AESD_ASSIGNMENTS_SITE_METHOD = git
# Ensure this is set to YES if your aesd-assignments repo itself contains submodules
# (e.g., if it's setup like the base aeld-assignments repo from the class)
AESD_ASSIGNMENTS_GIT_SUBMODULES = YES

# Set the source directory to the 'server' subdirectory within aesd-assignments
# This tells Buildroot to run 'make' from this specific directory
AESD_ASSIGNMENTS_SUBDIR = server

# Define environment variables for make if needed (e.g., for cross-compilation)
AESD_ASSIGNMENTS_MAKE_ENV = $(TARGET_MAKE_ENV)

# Define make options. V=1 for verbose output, which can be helpful for debugging.
# The Makefile in your 'server' directory should handle the compilation.
AESD_ASSIGNMENTS_MAKE_OPTS = V=1

# Define commands to install the compiled application to the target root filesystem
# $(TARGET_DIR) is the root directory of the target filesystem being built
define AESD_ASSIGNMENTS_INSTALL_TARGET_CMDS
	# Install the aesdsocket executable to /usr/bin
	$(INSTALL_TARGET_CPROG) $(@D)/server/aesdsocket $(TARGET_DIR)/usr/bin/
endef

# Define commands to install the init script to the target root filesystem
# The script is named S99aesdsocket to ensure it starts late in the boot process
# and has a high priority for shutdown (lower number for stop order).
define AESD_ASSIGNMENTS_INSTALL_INIT_SYSTEMS
	# Install the aesdsocket-start-stop script to /etc/init.d/S99aesdsocket
	$(INSTALL_TARGET_SCRIPT) $(@D)/server/aesdsocket-start-stop $(TARGET_DIR)/etc/init.d/S99aesdsocket
endef

# This ensures the package is built after the toolchain is ready
$(eval $(generic-package))
