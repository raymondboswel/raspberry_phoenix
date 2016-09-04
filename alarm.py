import pygame
import MySQLdb
import peewee as pw
import models as models
from datetime import datetime

pygame.init()

myDB = pw.MySQLDatabase("raspberry_phoenix_dev", host="localhost", port=3306, user="root", passwd="letmein")

now = datetime.now()
seconds_since_midnight = (now - now.replace(hour=0, minute=0, second=0, microsecond=0)).total_seconds()

print seconds_since_midnight

for alarm in models.Alarms.select():
  print alarm.track.path
  print alarm.track.track_name
  if alarm.time - seconds_since_midnight < 60 and alarm.time > seconds_since_midnight:
    print "Alarm should go off"
    pygame.mixer.music.load(alarm.track.path + alarm.track.track_name)
    pygame.mixer.music.play()
    while pygame.mixer.music.get_busy() == True:
      continue

  else:
    print "Alarm should not go off"

#myDB.connect()


