import os
import time
import inotify.adapters
import inotify.constants

# Watch the specific directory and its subdirectories
watch_dir = "./testDir"

# Create an inotify object
inotify_obj = inotify.adapters.InotifyTree(watch_dir, mask=inotify.constants.IN_CREATE)

# Continuously monitor for events
try:
	for event in inotify_obj.event_gen(yield_nones=False):
		(_, type_names, path, filename) = event

		print("{}\tSETFACL: {}/{}".format(time.strftime("[%Y-%m-%d | %I:%M:%S %p]"), path, filename))

		# set file/directory permissions

except KeyboardInterrupt:
	print("\nMonitoring stopped.")
