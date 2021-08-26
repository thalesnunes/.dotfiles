#!/bin/bash

XDG_RUNTIME_DIR=/run/user/$(id -u) /usr/bin/gcal_notifier remind
