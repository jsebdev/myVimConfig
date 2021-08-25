#include <stdio.h>
#include <unistd.h>

/**
 * main - PID
 *
 * Return: Always 0.
 */
int main(void)
{
	printf("%u\n", getppid());
	printf("%u\n", getpid());
	return (0);
}
