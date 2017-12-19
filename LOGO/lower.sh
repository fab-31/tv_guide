#!/bin/bash

ls -1|while read filename
do
	lower_filename="$(echo ${filename}|tr '[:upper:]' '[:lower:]')"
	
	
	
	mv "${filename}" "${lower_filename}"
done