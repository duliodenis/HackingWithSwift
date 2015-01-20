# Whitehouse Petitions App Update
This repo contains my ninth Swift project from Paul Hudson's awesome [Hacking With Swift](http://www.hackingwithswift.com/) tutorial series.

![](https://raw.githubusercontent.com/duliodenis/HackingWithSwift/master/art/Whitehouse.gif)

This technique project takes the seventh project, the Whitehouse Petition App, and solves a critical problem using one of the most important Apple frameworks available: Grand Central Dispatch, or GCD. 

The original problem in that app is that by downloading data from the internet in viewDidLoad() the app UI blocks the main thread and locks up until all the data has been transferred. 

In this update this problem is solved by using GCD, which allows us to fetch the data without locking up the user interface. But GCD comes with a warning: even though GCD might seem easy at first, it opens up a new raft of problems, so be careful! 

### Support or Contact
Visit [ddApps.co](http://ddapps.co) to see more.
