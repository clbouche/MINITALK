/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   client.c                                           :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: clbouche <clbouche@student.42.fr>          +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2021/07/06 16:58:52 by clbouche          #+#    #+#             */
/*   Updated: 2021/07/08 10:06:07 by clbouche         ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include "../includes/minitalk.h"

void	send_char_to_server(char c, pid_t pid)
{
	int	i;

	i = 0;
	while (i < 8)
	{
		usleep(10);
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
			send_str_to_server(argv[2], pid);
	}
	else
	{
		ft_putstr("Error : problem in the parameters\n");
		ft_putstr("Usage : the parameters must be = ");
		ft_putstr("[executable + PID of the server + one string]");
		exit(EXIT_FAILURE);
	}
	return (0);
}
