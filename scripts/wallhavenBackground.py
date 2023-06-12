#!/usr/bin/python3
import os
import sys
import requests
import threading
import random
import pathlib
import string
import platform

currentOs=platform.system()
if currentOs=='Windows':  
  DOWNLOAD_DIR = "C:/Users/Yutah/Pictures/fondosRandom"
else:
  DOWNLOAD_DIR = f"{str(pathlib.Path.home())}/yutah/Pictures/wallpapers"


def generate_id():
    return ''.join(random.choices(string.ascii_lowercase+string.digits, k=6))

def get_ext(url):
    ext = os.path.splitext(url)[1]
    return ext

def download_wallpaper(url):
    print(f"Downloading {url}")
    res = requests.get(url, allow_redirects=True)
    download_path = f"{DOWNLOAD_DIR}/{generate_id()}{get_ext(url)}"
    open(download_path, 'wb').write(res.content)
    print(f"Downloading done of {url}")
        
def clean(dir):
   for f in os.listdir(dir):
    os.remove(os.path.join(dir, f))

def wallpaper_search_api(query):
    parameters = {'.&categories=010'
                  '&sorting=random'
                  '&purity=110'
                  '&seed=4aEzf9'
                  #'&page=3'
                  '&atleast=1920x1080.'}
    query_url = f"https://wallhaven.cc/api/v1/search?q={query}{str(parameters).split('.')[1]}" 
    
    
    print(query_url)
    res = requests.get(query_url)
    response = res.json()
    dl_links = []
    for wallpaper in response["data"]:
        dl_links.append(wallpaper["path"])

    return dl_links

os.makedirs(DOWNLOAD_DIR, exist_ok=True)
if len(sys.argv) < 2:
    print("Usage waldl.py <search_query>")
    quit()

clean(DOWNLOAD_DIR)
query = sys.argv[1].replace(' ', '')
wallpapers = wallpaper_search_api(query)

print(len(wallpapers))
for wallpaper in wallpapers:
    download_wallpaper(wallpaper)
    
