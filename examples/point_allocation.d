#!/usr/sbin/dtrace -s
#pragma D option quiet

int indent[long, long];

dtrace:::BEGIN
{
	printf("Tracing... Hit Ctrl-C to end.\n");
    self->caller = "n/a";
}

Squeak$target:::proc_transferto
{
	self->priority = arg3;
	self->caller = "n/a";
}

Squeak$target:::objectalloc
/ self->priority == 30 && copyinstr(arg0) == "Point" /
{
    @methods[self->caller] = count();
}

Squeak$target:::methodenter
/ self->priority == 30 /
{ 
    self->caller = strjoin(strjoin(copyinstr(arg0), ">>"), copyinstr(arg1));
}

Squeak$target:::methodreturn
/ self->priority == 30 /
{ 
    self->caller = strjoin(strjoin(copyinstr(arg0), ">>"), copyinstr(arg1));
}

dtrace:::END
{
    trunc(@methods, 20);
    printf("\n\n Methods that instantiated Point\n ---------------------------------- \n");
	printf(" %-70s %8s\n", "CALLER", "NUMBER");
	printa(" %-70s %@8d\n", @methods);
}
