#include <stdio.h>
#include <sys/time.h>

int main() {
    struct timeval t;
    gettimeofday(&t, NULL);
    printf("%lld\n", (long long)t.tv_sec * 1000 + t.tv_usec / 1000);
    return 0;
}