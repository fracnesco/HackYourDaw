Create an instrument rack in Ableton Live with one of the attached devices and the instrument you want to control.
The device must be the first element of the instrument rack.
Give a unique name to the device in the device name text box.
This will allow you to control the device from tidal using the   # sound "UniqueNameYouGaveToTheDevice"   synthax.

Be careful!
if you open the device for editing it, you will have two applications (Max and Live) trying to listen from the same UDP port.
In this case none of them will receive any message. In order to start again receiving messages you have to close one of the two applications
(not just the patch, the whole application).
