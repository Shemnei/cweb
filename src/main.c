#include <assert.h>
#include <stdio.h>

int main(int argc, char **argv) {
  // Prevent unused paramter error for now
  assert(argc == 2 && "No path given");

  char *path = argv[1];

  printf("Starting server for path: %s\n", path);
}
