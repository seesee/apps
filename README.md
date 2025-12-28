# CC's Apps

A central repository linking to some of my [public GitHub apps and projects](https://github.com/seesee/).

## Web Apps

All my web apps are self-contained and run entirely in-browser using local storage. No tracking or other nonsense is included -- everything is 100% private and can work completely offline (just save as a file, or host it yourself). Nothing will phone home. No cookies will be harmed (or even used). As long as you have access to a browser with reasonable javascript capabilities, you're good to go.
 
### Activity Tracker
A single-page web app (aside from an optional service worker and favicon) that allows you to track what you're doing throughout the day. As I am prone to forget what I've done during the day, it will periodically play a reminder sound along with a system notification (if enabled and configured to do so). If Pomodoro is your bag, it will do that too -- it will even "tick" like the real thing if you want it to. You can also tag notes, add todos, set due days and generate reports.

[Link to Activity Tracker](https://seesee.github.io/apps/activity-tracker/)  

### Jottery
A single-page web app and terminal client. This one is a fast, local, searchable jotter, ideal for keeping scratch notes and useful snippets. Faster than waiting for Notepad++ to spool up a zillion tabs. Optionally syncs to a server to allow sharing of notes and snippets between web and terminal clients. All notes are encrypted, and the amount of faff involved getting all this to work is Quite A Lot. But it's actually pretty useful, and also works on phones (well, my phone).

[Link to Jottery](https://seesee.github.io/apps/jottery/)  

### Templatimator
A quick way to take a text template, substitute placeholders within it (in either JSON or YAML format), and output as text, Markdown, HTML, CSV, etc. This can be quite handy if you're constantly generating a bunch of boilerplate content for whatever reason. It's like a superpowered mail merge for geeks.

[Link to Templatimator](https://seesee.github.io/apps/templatimator/)  

### mdtool
Various markdown tools, e.g. markdown to html, html to markdown. Can be run completely offline.

[Link to mdtool](https://seesee.github.io/apps/mdtool/)  

## Other Projects

These projects are more specialised, with some user-assembly required. 

### Unicorn Wrangler 
A flexible micropython framework for running animations on the Pimoroni "suite" of Unicorn LED matrix displays (Cosmic, Galactic, and Stellar). 

Features include MQTT control, NTP time sync, and a web-based Docker server for streaming and auto-converting videos and images. Simulator packages for running the micropython code on a local PC (or even a Unicorn HD Raspberry Pi HAT) are also included.

[Link to Unicorn Wrangler](https://github.com/seesee/unicorn_wrangler/)  

### App::mqtt2job
Subscribes to the `my/topic/job` MQTT topic and, upon receiving a correctly formatted JSON message, will fork and run the requested job in a wrapper script -- provided it is present and executable in the `job_dir` directory.

This wrapper generates two child MQTT messages under the base topic at `my/topic/status`. The first message is sent when the job is initiated; the second is sent when the job has completed (or timed out). This second message also includes any output from the job, along with various metadata (e.g., execution datetime, duration, timeout condition, etc.).

I wrote this because I wanted to schedule running cron scripts in my homelab using Home Assistant. I do not recommend anyone use it ever; it's a terrible idea. There is no good reason to automate running a test suite or deploying to prod every time you open your fridge door.

[Link to App::mqtt2job](https://github.com/seesee/App-mqtt2job/)  

### 2do2
A CLI script to view and manage items in Todoist (requires API key and probably a subscription). Actually quite useful, if you just need to do something quickly and don't want to open the app/use the website. It's fairly functional and tries to keep out of your way.

[Link to 2do2](https://github.com/seesee/2do2)  

----

&copy; 2024-2025 Chris Carline.  
All rights reserved.

----
