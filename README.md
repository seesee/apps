# CC's Apps
A central repository linking to some of my public apps.

## Web Apps
All my webapps are self-contained and run in-browser using local storage. 
No tracking or other nonsense is included. Everything is 100% private and 
can work completely offline (just save as file, or host it yourself).

### Activity Tracker
[Activity Tracker](https://seesee.github.io/apps/activity-tracker/) 
is a (mostly) single page web app that allows you to track what you're doing 
throughout the day.

### Templatimator
[Templatimator](https://seesee.github.io/apps/templatimator/)
is a quick way of taking a text outline, applying a bunch of variables to it
and outputting as text/html/csv etc.

## Other Projects

[Unicorn Wrangler](https://github.com/seesee/unicorn_wrangler/)
Unicorn Wrangler is a flexible system for running animations on the Pimoroni
"suite" of Unicorn LED matrix displays (Cosmic, Galactic, and Stellar).
Features include MQTT control, ntp time sync and a web-based docker server 
for streaming and auto-converting videos and images. Simulator packages for
running the micropython pachages on a local PC (or even a Unicorn HD raspberry 
Pi HAT) are also included.

[App::mqtt2job](https://github.com/seesee/App-mqtt2job/)
Subscribes to the my/topic/job mqtt topic and upon receiving a correctly 
formatted json message will fork and run the requested job in a wrapper script
providing it is present and executable in the job_dir directory.

This wrapper will generate two child mqtt messages under the base topic, at 
my/topic/status. Message one is sent when the job is initiated. The second 
is sent when the job has completed (or timed out). This second message will 
also include any output from the job amongst various other metadata (e.g. 
execution datetime, duration, timeout condition, etc.)

I wrote this because I wanted to schedule running cron scripts in my homelab
using Home Assistant. I do not recommend anyone use it ever; it's a terrible
idea. 
