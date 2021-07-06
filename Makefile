########
# NAME #
########

SERVER = serveur
CLIENT = client

###################
# FLAGS & LIBRARY #
###################

#compiler
CC = gcc

#compiler flags
CFLAGS += -Wall
CFLAGS += -Wextra
CFLAGS += -Werror
#CFLAGS += -fsanitize=address

###################
# PRINT VARIABLES #
###################

# Reset
NC = \033[0m

# Colors
YELLOW = \033[0;33m
GREEN = \033[32m
BLUE = \033[0;34m
RED = \033[0;31m
PURPLE = \033[0;35m
CYAN = \033[0;36m
BLACK = \033[0;30
WHITE = \033[0;37m

# One Line Output
ONELINE =\e[1A\r

############
# Includes #
############

INCLUDES += -I /includes/minitalk.h

########################
# Sources compilations #
########################

PATH_SRCS = srcs

SRCS_SERVER += server.c
SRCS_SERVER += utils.c

SRCS_CLIENT += client.c
SRCS_CLIENT += utils.c


vpath %.c $(PATH_SRCS)

########################
# Objects compilations #
########################

PATH_OBJS = objs/
OBJS_SERVER = $(patsubst %.c, $(PATH_OBJS)%.o, $(SRCS_SERVER)) 
OBJS_CLIENT = $(patsubst %.c, $(PATH_OBJS)%.o, $(SRCS_CLIENT))
#OBJS = $(patsubst %.c, $(PATH_OBJS)%.o, $(SRCS))

#########
# RULES #
#########

all: $(PATH_OBJS) $(CLIENT) $(SERVER)

$(SERVER): $(OBJS_SERVER)
		@$(CC) $(OBJS_SERVER) $(INCLUDES) $(CFLAGS) -o $(SERVER) 
		@echo "$(GREEN)$@ is ready.\n$(NC)"

$(CLIENT): $(OBJS_CLIENT)
		@$(CC) $(OBJS_CLIENT) $(INCLUDES) $(CFLAGS) -o $(CLIENT) 
		@echo "$(GREEN)$@ is ready.\n$(NC)"

$(OBJS_SERVER): $(PATH_OBJS)%.o: %.c Makefile
		@$(CC) -c $< -o $@ 
		@echo "$(ONELINE)$(CYAN)Compiling $<\n$(NC)"

$(OBJS_CLIENT): $(PATH_OBJS)%.o: %.c Makefile
		@$(CC) -c $< -o $@ 
		@echo "$(ONELINE)$(CYAN)Compiling $<\n$(NC)"

$(PATH_OBJS):
	@mkdir $@

clean:
	@$(RM) $(OBJS)
	@$(RM) -R $(PATH_OBJS)
	@echo "$(PURPLE)CLEAN $<\n"

fclean: clean
	@$(RM) $(SERVER) $(CLIENT)
	@echo "$(PURPLE)FCLEAN\n"

re: fclean all

.PHONY : all clean fclean re
