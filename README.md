# DTrace provider for the Smalltalk Pharo VM

This DTrace provider adds hooks to the Pharo VM for probes such as method enter/return, object allocation, GC begin and end, and process switching.

DTrace allows unprecedented view across all layers of Smalltalk software. With DTrace we can simultaneously observe and correlate events from Smalltalk, the VM, and the OS.

## Installation

Please check out the accompanying blog post for instructions to build your own DTrace-instrumented VM:

[http://www.adrian-lienhard.ch/blog?dialog=smalltak-meets-dtrace](http://www.adrian-lienhard.ch/blog?dialog=smalltak-meets-dtrace)

There's also a pre-compiled VM for OS X.

# Usage

The above linked post provides detailed introductions with examples.

# Build from source

Depending on your platform you have to create your own squeak_provider.h file
and compile the patched Squeak/Pharo VM.

To generate the squeak_provider.h file run:

  dtrace -h -s squeak_provider.d

Then copy the generated squeak_provider.h file to ../platforms/unix/src/vm/
