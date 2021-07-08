/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   client_bonus.c                                     :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: clbouche <clbouche@student.42.fr>          +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2021/07/07 11:45:38 by clbouche          #+#    #+#             */
/*   Updated: 2021/07/08 10:09:35 by clbouche         ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include "../includes/minitalk.h"

void	send_char_to_server(char c, pid_t pid)
{
	int	i;

	i = 0;
	while (i < 8)
	{
		usleep(100);
		if (c & 1)
			kill(pid, SIGUSR1);
		else
			kill(pid, SIGUSR2);
		c = c >> 1;
		i++;
	}
}

void	send_str_to_server(char *str, pid_t pid)
{
	int		i;
	char	c;

	i = 0;
	while (str[i])
	{
		send_char_to_server(str[i], pid);
		i++;
	}
	send_char_to_server(str[i], pid);
}

int	main(int argc, char **argv)
{
	int		i;
	pid_t	pid;

	i = 0;
	if (argc == 3)
	{
		pid = ft_atoi(argv[1]);
		if (pid == 0)
		{
			ft_putstr("Error : missing PID\n");
			exit(EXIT_FAILURE);
		}
		else
		{
			ft_putstr("Message received by the server.");
			send_str_to_server(argv[2], pid);
		}
	}
	else
	{
		ft_putstr("Error : problem in the parameters\n");
		exit(EXIT_FAILURE);
	}
	return (0);
}
