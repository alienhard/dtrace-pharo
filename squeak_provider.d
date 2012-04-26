/*
To generate the squeak_provider.h file run:

  dtrace -h -s squeak_provider.d

Copy the generated squeak_provider.h file to ../platforms/unix/src/vm/
*/

provider Squeak {
	/*
    event name: methodenter
    arguments:
        name of class
        name of method
        primitive index (0 if not a primitive)
        successFlag of previous primitive call (0 if
            method is called due to primitive failure)
    */
	probe methodenter(char*, char*, int, int);
	
    /*
    event name: methodenter
    arguments:
        name of class
        name of method
        primitive index (0 if not a primitive)
    */
	probe methodreturn(char*, char*, int);
	
	/*
	event name:  object-alloc
	arguments:
	    name of class
	    size in bytes*/
	probe objectalloc(char*, int);
	
	/* event name: full GC begin cycle */
	probe gcbegin();
	
	/* event name: full GC end cycle */
	probe gcend();
	
	/* event name: incremental GC begin cycle */
	probe igcbegin();
	
	/* event name: incremental GC end cycle */
	probe igcend();
	
	/*
	event name: proc_transferto
	arguments:
	    oldPid
	    oldPriority
	    newPid
	    newPriority
	*/
	probe proc_transferto(long, long, long, long);
};