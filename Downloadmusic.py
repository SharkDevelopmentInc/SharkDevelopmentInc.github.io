import yt_dlp as youtube_dl
from youtubesearchpython import VideosSearch
import os

def download(term, name):

    url = search_youtube_video(term, name)

    output_path = './temp/soundboard'
    ydl_opts = {
        'format': 'bestaudio/best',
        'extractaudio': True,
        'postprocessors': [{
            'key': 'FFmpegExtractAudio',
            'preferredcodec': 'mp3',
            'preferredquality': '192',
        }],
        'outtmpl': f'{output_path}/{name}.%(ext)s',  # Template for the filename
        'noplaylist': True,  # Download only single video,
        'quiet': True
    }
                        
    with youtube_dl.YoutubeDL(ydl_opts) as ydl:
        info_dict = ydl.extract_info(url, download=True)
        link = info_dict.get('id', 'audio')


def search_youtube_video(query, name, max_results=1):
    try:
        videos_search = VideosSearch(query, limit=max_results)
        results = videos_search.result()
        videos = results['result']
        
        if not videos:
            print("No results found.")
            return None
        
        # Return the first video URL as an example
        return videos[0]['link'] if videos else None
    
    except Exception as e:
        print(f"An error occurred: {e}")
        return None


download('I wont back down - Tom Petty', 'addymae')
download('Row your boat - DJ Beatty', 'charlie')
download('Ready For it - Taylor Swift', 'emmy')
download('Turn down for what', "emily")
download('Blind - Korn', 'emma')
download('Titanium (Dark Horse) - Katy Perry', 'evelyn')
download('Crazy Train', "molly")