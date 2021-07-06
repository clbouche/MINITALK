#ifndef MINITALK_H
#define MINITALK_H

# include <unistd.h>
# include <sys/types.h>
# include <unistd.h>
# include <sys/types.h>
# include <signal.h>
# include <stdlib.h>

void	ft_putstr(const char *s);
int		ft_strlen(const char *str);
void	ft_putnbr(int n);
int		ft_atoi(const char *str);
void	send_str_to_server(char c, int pid);



#endif
