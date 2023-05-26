#include <stdio.h>

#include "http.h"

void print_something(void) {
  printf("Header: %s\n", HTTP_HEADER_CONTENT_LENGTH);
}
