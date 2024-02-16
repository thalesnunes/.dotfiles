#!/usr/bin/env python
import os
from pathlib import Path

from crontab import CronTab

ROOT = Path(os.path.expanduser('~'))
USER = os.environ.get('USER')

with open(ROOT/".sun") as sunfile:
    sunrise, sunset = sunfile.read().split()

light_hour, light_min = sunrise.split(":")
dark_hour, dark_min = sunset.split(":")

with CronTab(user=USER) as cron:

    light, dark = None, None
    for job in cron.find_command("i3-msg"):
        if job.comment == "light mode":
            light = job
        elif job.comment == "dark mode":
            dark = job

    if not (light and dark):
        raise Exception("Couldn't find light and dark cronjobs")

    light.hour.on(light_hour)
    light.minute.on(light_min)
    dark.hour.on(dark_hour)
    dark.minute.on(dark_min)

    cron.write()
