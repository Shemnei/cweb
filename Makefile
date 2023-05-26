# <https://makefiletutorial.com/>

# C compiler
CC := gcc
# C compiler flags
CFLAGS := -std=c11 -pedantic -Wall -Werror -Wextra

# Source directory
SRCDIR := src
# Output/build directory
OUTDIR := out

# Final executable
EXEC := cweb
# All source files
SRCS := $(shell find $(SRCDIR) -name '*.c')
# All directory used as search paths
INCS := $(shell find $(SRCDIR) -type d)
# All intermediate object files
OBJS := $(SRCS:%=$(OUTDIR)/%.o)

# Include flags (removes the need for relative paths)
INCFLAGS := $(addprefix -I,$(INCS))

# Combines all objects into final executable
$(OUTDIR)/$(EXEC): $(OBJS)
	$(CC) $(OBJS) -o $@ $(LDFLAGS)

# Builds a single object
$(OUTDIR)/%.c.o: %.c
	mkdir -p $(dir $@)
	$(CC) $(CFLAGS) -c $< -o $@

.PHONY: clean
clean:
	rm -rf $(OUTDIR)

.PHONY: run
run: $(OUTDIR)/$(EXEC)
	./$(OUTDIR)/$(EXEC) ./srv

CPPCHECK_OUTDIR := $(OUTDIR)/cppcheck
CPPCHECK_REPORT := $(CPPCHECK_OUTDIR)/report.txt

$(CPPCHECK_REPORT): $(SRCS) $(INCS)
	mkdir -p $(dir $@)
	cppcheck \
		--report-progress \
		--check-library \
		--enable=warning,style \
		--cppcheck-build-dir=$(CPPCHECK_OUTDIR) \
		--std=c11 \
		--output-file=$(CPPCHECK_REPORT) \
		$(INCFLAGS) \
		$(SRCDIR)

.PHONY: check
check: $(CPPCHECK_REPORT)
	cat $(CPPCHECK_REPORT)
