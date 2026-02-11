#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <sys/types.h>
#include <sys/wait.h>

int main() {
    int num_children = 3;
    pid_t pid;

    printf("Parent Process (PID: %d) is starting...\n", getpid());

    for (int i = 0; i < num_children; i++) {
        pid = fork();

        if (pid < 0) {
            perror("Fork failed");
            exit(1);
        }

        if (pid == 0) {
            // This is the Child Process
            printf("Child %d (PID: %d) created. Doing work...\n", i + 1, getpid());
            sleep(2); // Simulate work
            printf("Child %d (PID: %d) exiting.\n", i + 1, getpid());
            exit(0);
        }
    }

    // Parent Process logic: Prevent Zombies
    printf("Parent is waiting to clean up children...\n\n");

    for (int i = 0; i < num_children; i++) {
        int status;
        // wait() blocks the parent until a child process terminates
        pid_t cleaned_pid = wait(&status);

        if (cleaned_pid > 0) {
            printf("Parent cleaned up Child with PID: %d\n", cleaned_pid);
        }
    }

    printf("\nAll children cleaned up. No zombies remain. Parent exiting.\n");
    return 0;
}
