# Overview

This repository contains assignment starter code for buildroot based assignments for the course Advanced Embedded Software Design, ECEN 5713. The project is configured for Assignment 4, which focuses on a multithreaded application using POSIX threads (pthreads).

It also contains instructions related to modifying your buildroot project to use with supported hardware platforms.  See [this wiki page](https://github.com/cu-ecen-5013/buildroot-assignments-base/wiki/Supported-Hardware) for details.

## Project Description

The core of this assignment is a C application (`threading.c`) that demonstrates fundamental concepts of multithreading. The application creates a thread that performs the following actions:
1.  Waits for a specified duration.
2.  Obtains a mutex lock.
3.  Waits for another specified duration while holding the lock.
4.  Releases the mutex.
5.  Sets a success flag upon completion.

This functionality is tested using an automated test suite that validates the correct behavior of the thread and mutex operations.

## How to Build

The project is built using Buildroot. A helper script is provided to simplify the process.

To build the project, run the following command from the root of the repository:
```bash
./build.sh
```
This script will:
1.  Initialize and update the necessary git submodules.
2.  Configure Buildroot using the default or a saved configuration.
3.  Run the `make` command to build the entire system, including the kernel, root filesystem, and the threading application.

The output images will be located in the `buildroot/output/images/` directory.

## How to Run

The built system can be executed in a QEMU virtual machine using the provided script.

To run the QEMU instance, use the following command:
```bash
./runqemu.sh
```
This script starts an `aarch64` QEMU virtual machine and boots the Linux system built by Buildroot. It also sets up port forwarding for SSH (host port 10022 to guest port 22) and for the application's socket server (host port 9000 to guest port 9000).

## Key Technologies

*   **C**: The application is written in C.
*   **POSIX Threads (pthreads)**: Used for multithreading.
*   **Buildroot**: Used for building the embedded Linux system.
*   **QEMU**: Used for emulating the hardware and running the Linux system.
