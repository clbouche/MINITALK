########
# NAME #
########

SERVER = server
CLIENT = client
BONUS_SERVER = bonus_server
BONUS_CLIENT = bonus_client

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
PATH_SRCS_BONUS = srcs_bonus

SRCS_SERVER += server.c
SRCS_SERVER += utils_server.c

SRCS_CLIENT += client.c
SRCS_CLIENT += utils_client.c


SRCS_SERVER_BONUS += server_bonus.c
SRCS_SERVER_BONUS += utils_server_bonus.c

SRCS_CLIENT_BONUS += client_bonus.c
SRCS_CLIENT_BONUS += utils_client_bonus.c

vpath %.c $(PATH_SRCS_BONUS)
vpath %.c $(PATH_SRCS)

########################
# Objects compilations #
########################

PATH_OBJS = objs/
OBJS_SERVER = $(patsubst %.c, $(PATH_OBJS)%.o, $(SRCS_SERVER)) 
OBJS_CLIENT = $(patsubst %.c, $(PATH_OBJS)%.o, $(SRCS_CLIENT))

PATH_OBJS_BONUS = objs_bonus/
OBJS_SERVER_BONUS = $(patsubst %.c, $(PATH_OBJS_BONUS)%.o, $(SRCS_SERVER_BONUS))
OBJS_CLIENT_BONUS = $(patsubst %.c, $(PATH_OBJS_BONUS)%.o, $(SRCS_CLIENT_BONUS))

#########
# RULES #
#########

all: $(PATH_OBJS) $(CLIENT) $(SERVER)

bonus: $(PATH_OBJS_BONUS) $(BONUS_CLIENT) $(BONUS_SERVER)

$(SERVER): $(OBJS_SERVER)
		@$(CC) $(OBJS_SERVER) $(INCLUDES) $(CFLAGS) -o $(SERVER) 
		@echo "$(GREEN)$@ is ready.\n$(NC)"

$(CLIENT): $(OBJS_CLIENT)
		@$(CC) $(OBJS_CLIENT) $(INCLUDES) $(CFLAGS) -o $(CLIENT) 
		@echo "$(GREEN)$@ is ready.\n$(NC)"

$(OBJS_SERVER): $(PATH_OBJS)%.o: %.c Makefile
		@$(CC) -c $< -o $@ 

$(OBJS_CLIENT): $(PATH_OBJS)%.o: %.c Makefile
		@$(CC) -c $< -o $@ 

$(PATH_OBJS):
	@mkdir $@

$(BONUS_SERVER): $(OBJS_SERVER_BONUS)
		@$(CC) $(OBJS_SERVER_BONUS) $(INCLUDES) $(CFLAGS) -o $(BONUS_SERVER) 
		@echo "$(GREEN)$@ is ready.\n$(NC)"

$(BONUS_CLIENT): $(OBJS_CLIENT_BONUS)
		@$(CC) $(OBJS_CLIENT_BONUS) $(INCLUDES) $(CFLAGS) -o $(BONUS_CLIENT) 
		@echo "$(GREEN)$@ is ready.\n$(NC)"

$(OBJS_SERVER_BONUS): $(PATH_OBJS_BONUS)%.o: %.c Makefile
		@$(CC) -c $< -o $@ 

$(OBJS_CLIENT_BONUS): $(PATH_OBJS_BONUS)%.o: %.c Makefile
		@$(CC) -c $< -o $@ 

$(PATH_OBJS_BONUS):
	@mkdir $@

clean:
	@$(RM) $(OBJS_CLIENT) $(OBJS_CLIENT_BONUS) $(OBJS_SERVER) $(OBJS_SERVER_BONUS)
	@$(RM) -R $(PATH_OBJS) $(PATH_OBJS_BONUS)
	@echo "$(PURPLE)CLEAN $<\n"

fclean: clean
	@$(RM) $(SERVER) $(CLIENT) $(BONUS_SERVER) $(BONUS_CLIENT)
	@echo "$(PURPLE)FCLEAN\n"

re: fclean all

.PHONY : all clean fclean re
