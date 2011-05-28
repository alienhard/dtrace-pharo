#!/usr/sbin/dtrace -s
#pragma D option quiet

dtrace:::BEGIN
{
	printf("Tracing object allocations... Hit Ctrl-C to end.\n");
}

Squeak$target:::proc_transferto
{
	self->priority = arg3;
}

Squeak$target:::objectalloc
/ self->priority == 30 /
{
    @number[copyinstr(arg0)] = count();
    @size[copyinstr(arg0)] = sum(arg1);
}

dtrace:::END
{
	trunc(@number, 5);
    printf("\n\n Number of instances created per class\n ---------------------------------- \n");
	printf(" %-70s %8s\n", "CLASS", "NUMBER");
	printa(" %-70s %@8d\n", @number);
	
	trunc(@size, 5);
    printf("\n\n Total memory allocated for instances of class (in byte)\n ----------------------------------\n");
	printf(" %-70s %8s\n", "CLASS", "SIZE");
	printa(" %-70s %@8d\n", @size);
}