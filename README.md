# CC's Apps

A central repository linking to some of my [public GitHub apps and projects](https://github.com/seesee/).

## Web Apps

All my web apps are self-contained and run entirely in-browser using local storage.  
No tracking or other nonsense is included -- everything is 100% private and can work completely offline (just save as a file, or host it yourself).
 
### Activity Tracker
A single-page web app (aside from an optional service worker and favicon) that allows you to track what you're doing throughout the day. As I am prone to forget what I've done during the day, it will periodically play a reminder sound and send a system notification reminder to. All this is configurable. If Pomodoro is your bag, it will do that too. You can also tag notes, add todos, set due days and generate reports.  

Link to [Activity Tracker](https://seesee.github.io/apps/activity-tracker/)  

### Templatimator
A quick way to take a text template, substitute placeholders within it (in either JSON or YAML format), and output as text, Markdown, HTML, CSV, etc. This can be quite handy if you're constantly generating a bunch of boilerplate content for whatever reason. It's like a superpowered mail merge for geeks.

Link to [Templatimator](https://seesee.github.io/apps/templatimator/)  

## Other Projects

### Unicorn Wrangler 
A flexible micropython framework for running animations on the Pimoroni "suite" of Unicorn LED matrix displays (Cosmic, Galactic, and Stellar).  
Features include MQTT control, NTP time sync, and a web-based Docker server for streaming and auto-converting videos and images. Simulator packages for running the MicroPython packages on a local PC (or even a Unicorn HD Raspberry Pi HAT) are also included.

Link to [Unicorn Wrangler](https://github.com/seesee/unicorn_wrangler/)  

### Unicorn Wrangler 
Subscribes to the `my/topic/job` MQTT topic and, upon receiving a correctly formatted JSON message, will fork and run the requested job in a wrapper script -- provided it is present and executable in the `job_dir` directory.

This wrapper generates two child MQTT messages under the base topic at `my/topic/status`. The first message is sent when the job is initiated; the second is sent when the job has completed (or timed out). This second message also includes any output from the job, along with various metadata (e.g., execution datetime, duration, timeout condition, etc.).

I wrote this because I wanted to schedule running cron scripts in my homelab using Home Assistant. I do not recommend anyone use it ever; it's a terrible idea. There is no good reason to automate running a test suite or deploying to prod every time you open your fridge door.

Link to [App::mqtt2job](https://github.com/seesee/App-mqtt2job/)  
----

&copy; 2024-2025 Chris Carline.  
All rights reserved.

----
