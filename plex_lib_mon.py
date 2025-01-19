import os
import time
import inotify

# Create an inotify object
inotify_obj = inotify.adapters.Inotify()

# Watch the specific directory and its subdirectories
watch_dir = "./testDir" 
inotify_obj.add_watch(watch_dir, mask=inotify.constants.IN_CREATE | inotify.constants.IN_CREATE | inotify.constants.IN_MOVED_TO)

# Continuously monitor for events
try:
    for event in inotify_obj.event_gen():
        (header, type_names, mask, filename) = event

        if filename is None:
            continue

        if "CREATE" in type_names:
            print(f"File/Directory created: {os.path.join(header.wd, filename)}")

except KeyboardInterrupt:
    print("\nMonitoring stopped.")

# Remove watches and close the inotify object
for wd in inotify_obj.watches:
    inotify_obj.remove_watch(wd)
inotify_obj.close()
