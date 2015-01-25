# Names to Faces App Update
This repo contains my twelth Swift project from Paul Hudson's awesome [Hacking With Swift](http://www.hackingwithswift.com/) tutorial series. It updates Project 10's Photo Library Names to Faces App in order to learn how to save user settings and data for later use.

![](https://raw.githubusercontent.com/duliodenis/HackingWithSwift/master/art/NamesToFaces.gif)

This is our fourth technique project, and we went back to project 10 to fix its glaring bug: all the names and faces you add to the app don't get saved, which makes the app quite useless!

We've fixed this using a new class called NSUserDefaults and a new protocol called NSCoding. We've also used the class NSKeyedUnarchiver that you just met in project 11, along with its counterpart: NSKeyedArchiver. Putting all these together, we've updated project 10 so that it saves its people array whenever anything is changed, then loads when the app runs.

### Support or Contact
Visit [ddApps.co](http://ddapps.co) to see more.
