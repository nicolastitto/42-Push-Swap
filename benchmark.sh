# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    benchmark.sh                                       :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: nide-mel <nide-mel@student.42lisboa.com    +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2018/08/29 17:15:18 by vbrazhni          #+#    #+#              #
#    Updated: 2021/09/10 17:21:45 by nide-mel         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #


#!/bin/bash

MAX=0
ITERATIONS=0
LIMIT=700
FILE=problem_100
SUM=0

for i in {1..100}
do
		export ARG=`ruby -e "puts (1..100).to_a.shuffle.join(' ')"`
		if ./push_swap $ARG | ./checker_Mac $ARG | wc -l | grep -q KO
		then
			echo "Error!"
			echo $ARG
			break
		fi
		NUMBER="$(./push_swap $ARG | wc -l | sed 's/ //g')"
		if [ "$NUMBER" -gt "$LIMIT" ]
			then
			echo $NUMBER >> $FILE
			echo $ARG >> $FILE
		fi
		if [ "$NUMBER" -gt "$MAX" ]
			then
			MAX=$NUMBER;
		fi
		echo $i ":" $NUMBER
		let SUM+=$NUMBER;
		let ITERATIONS+=1
done

echo "AVG: $(($SUM / $ITERATIONS))"
echo "MAX: " $MAX
