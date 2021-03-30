# App controlled RGB LED Stripe

This project is a simple IoT example.

Requirements:

Hardware:
* Node MCU esp8266
* WS2812B LED stripe

App:
* Google Flutter
* Firebase database

Flutter required plugins:
* firebase_database
* flutter_colorpicker (https://pub.dev/packages/flutter_colorpicker)

For testing and simulating you can use Android Studio and its emulator or just connect your phone to the computer via the USB port and run your flutter code.
Unfortunately the app has been developed for a phone approximately 6.2” big. You may need to change the size of the boxes, and buttons so it fits on your phone screen. I am working on the solution of that don’t worry.


Firebase setup:

![image](https://user-images.githubusercontent.com/73818926/112961705-e83cc600-9145-11eb-9863-8afe78e1d61f.png)


You can change the variable names, but if you do so, than you should change the code as well. The content doesn’t matter yet. As soon as you set something in the app, the right values will be set.
Check the firebase website for, the setup of the realtime database, and integration for mobile application.
I commented the lines in the flutter project files, where and what you should place.
I recommend using the server in Belgium, but it is up to you. 


