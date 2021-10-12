enable_hist=1

cache_dir="$HOME/.cache/ytfzf"

enable_cur=0

enable_noti=0

# List of youtube-dl video quality numbers
# video_pref="22"

video_player="mpv"

#the format of the video (1080p, 720p, etc)
#uses the youtube-dl preference system
#must be a number eg: 22 is 720p
#(YTFZF_PREF)
# mpv and youtube-dl slow stream work around
# https://bbs.archlinux.org/viewtopic.php?id=204978
video_pref="best"

video_player_format="mpv --ytdl-format="

audio_player="mpv --no-video"

#the amount of links to get from each subscription
#same as --subs=
sub_link_count=5
