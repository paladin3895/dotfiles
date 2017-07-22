#!/bin/sh
copyq tab clipboard copy "`copyq tab notes read 0 | rev | cut -c 1- | rev`"
