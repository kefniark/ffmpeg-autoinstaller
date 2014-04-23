#!/bin/bash

# Function to check if previous commands didn't encoutered any error
function checkStatus(){
    if [ $? -gt 0 ]; then
        echo 'Error/s encountered, exiting.'
        exit $?
    fi
}

# Function to load installer plugins
function loadPlugin(){
    PLUGIN_FILE="plugins/$1"
    echo " -- Loading Plugin : $PLUGIN_FILE -- "
    source $PLUGIN_FILE
}

# Function to execute root commands (with or without sudo)
function execRoot(){
    if [ $EUID -eq 0 ]; then
        echo " > Execute root user : '$1'"
        $1
    else
        echo " > Execute sudo user : '$1'"
        sudo $1
    fi
}