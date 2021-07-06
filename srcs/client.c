/* ************************************************************************** */
/*                                                                            */
/*                                                        :::      ::::::::   */
/*   client.c                                           :+:      :+:    :+:   */
/*                                                    +:+ +:+         +:+     */
/*   By: clbouche <clbouche@student.42.fr>          +#+  +:+       +#+        */
/*                                                +#+#+#+#+#+   +#+           */
/*   Created: 2021/07/06 16:58:52 by clbouche          #+#    #+#             */
/*   Updated: 2021/07/06 18:47:55 by clbouche         ###   ########.fr       */
/*                                                                            */
/* ************************************************************************** */

#include "../includes/minitalk.h"

void	send_str_to_server(char c, int pid)
{
	int i;

	i = 7;
	while (i >= 0)
	{
		usleep(100);
		if (c >> i & 1)
			kill(pid, SIGUSR1);
		else
			kill(pid, SIGUSR2);
		i--;
	}
	//besoin de la decomposer en bit dans un certain ordre
}

int main(int argc, char **argv)
{
	int i;
	int	pid;

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
			while (argv[2][i])
				send_str_to_server(argv[2][i], pid);
		}
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
