#!/bin/bash

if [ -z "$GRACEFUL_DELETE" ]; 
	then
		echo "GRACEFUL_DELETE not activated! To enable GRACEFUL_DELETE set the GRACEFUL_DELETE en variable to true!"
	else
		echo "Enabling GRACEFUL_DELETE! Decomissioning node currently not implmeneted!"
        #./cassandra/bin/nodetool decommission
fi  