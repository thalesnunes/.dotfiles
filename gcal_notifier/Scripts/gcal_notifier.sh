#!/bin/bash

export XDG_RUNTIME_DIR=/run/user/$(id -u)

/home/thales/.local/bin/gcal_notifier remind
