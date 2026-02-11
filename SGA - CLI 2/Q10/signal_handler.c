#include <stdio.h>
#include <stdlib.h>
#include <signal.h>
#include <unistd.h>
#include <sys/types.h>

// Signal handler function
void handle_signal(int sig) {
    if (sig == SIGTERM) {
        printf("\n[PARENT] Received SIGTERM (Termination Signal). Still running...\n");
    } else if (sig == SIGINT) {
        printf("\n[PARENT] Received SIGINT (Interrupt Signal). Exiting gracefully now.\n");
        exit(0);
    }
}

int main() {
    // Register the handler for SIGTERM and SIGINT
    signal(SIGTERM, handle_signal);
    signal(SIGINT, handle_signal);

    pid_t parent_pid = getpid();
    printf("Parent Process PID: %d. Registered signal handlers.\n", parent_pid);

    // First Child: Sends SIGTERM after 5 seconds
    if (fork() == 0) {
        sleep(5);
        printf("[CHILD 1] Sending SIGTERM to parent...\n");
        kill(parent_pid, SIGTERM);
        exit(0);
    }

    // Second Child: Sends SIGINT after 10 seconds
    if (fork() == 0) {
        sleep(10);
        printf("[CHILD 2] Sending SIGINT to parent...\n");
        kill(parent_pid, SIGINT);
        exit(0);
    }

    // Parent runs indefinitely until SIGINT is received
    printf("Parent entering infinite loop. Waiting for signals...\n");
    while (1) {
        pause(); // Wait for any signal to arrive
    }

    return 0;
}
