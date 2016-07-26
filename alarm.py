import pygame

pygame.init()

pygame.mixer.music.load("baby_cry.wav")

pygame.mixer.music.play()
while pygame.mixer.music.get_busy() == True:
      continue

