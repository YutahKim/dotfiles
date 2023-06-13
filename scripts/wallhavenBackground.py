#!/usr/bin/python3
import os
import sys
import requests
import threading
import random
import pathlib
import string
import platform
#query
#"jujutsu||blood||creepy||horror||dota||elf||gibly||lofi||bloodc||chill||arch||power||shell||akira||castle||computer||apex||evangelion||dorohedoro||demon"       
currentOs=platform.system()
if currentOs=='Windows':  
  DOWNLOAD_DIR = "C:/Users/Yutah/Pictures/fondosRandom"
else:
  DOWNLOAD_DIR = f"{str(pathlib.Path.home())}/Pictures/wallpapersRandoms"

print( f'Saving on {DOWNLOAD_DIR}')
def generate_id():
    return ''.join(random.choices(string.ascii_lowercase+string.digits, k=6))

def generate_seed():
    seed=''.join(random.choices(string.ascii_lowercase+string.digits, k=6))
    print(seed)
    return seed

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

def wallpaper_search_api(query,pages):
    dl_links = []
    seed=generate_seed()
    for page in range(pages):
        parameters = {'.&categories=010'
                    '&sorting=random'
                    '&purity=110'
                    '&seed='+seed+
                    '&page='+str(page+1)+
                    '&ratios=16x9'
                    '&atleast=1920x1080.'}
        query_url = f"https://wallhaven.cc/api/v1/search?q={query}{str(parameters).split('.')[1]}" 
        print(query_url)

        res = requests.get(query_url)
        response = res.json()
        
        for wallpaper in response["data"]:
            dl_links.append(wallpaper["path"])

    return dl_links

os.makedirs(DOWNLOAD_DIR, exist_ok=True)
if len(sys.argv) < 2:
    print("Usage waldl.py <search_query>")
    quit()

clean(DOWNLOAD_DIR)
query = sys.argv[1].replace(' ', '')
wallpapers = wallpaper_search_api(query,4)

print(len(wallpapers))
for wallpaper in wallpapers:
    download_wallpaper(wallpaper)
    
