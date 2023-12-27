
# Location Flickr Challenge

## Introduction

 > I want to use this section to explain what have been my thoughts while developing this challenge.

 First of all, I had some questions that I had to give an answer before even starting to code. The part that I thought would be more troublesome is the background location updates, just because I hadn't worked with `CoreLocation` in a long time. My questions were:

 - To be able to receive background updates on location, is it enough to use the `CoreLocation` delegate methods or do I need some sort of workout background mode?

    -  *It seems I was getting confused with WatchKit APIs, the CoreLocation methods were enough. Plus there is some good documentation at [Handling location updates in the background](https://developer.apple.com/documentation/corelocation/handling_location_updates_in_the_background)*

- Where I am going to store the images downloaded?
    
    - *Didn't know how [Flickr API](https://www.flickr.com/services/api/flickr.photos.search.html) was, so I didn't know if I was going to download the images, my guess would have been to download them into an app folder. Fortunately I only had to keep the image urls, and they are really easy to store*

Then I started investigating to get all the information required to start the challenge. I basically used 3 links, everything else was pretty straightforward.

- [Flickr API](https://www.flickr.com/services/api/flickr.photos.search.html)
- [Handling location updates in the background](https://developer.apple.com/documentation/corelocation/handling_location_updates_in_the_background)
- [CLLocationDelegate](https://developer.apple.com/documentation/corelocation/cllocationmanagerdelegate)

Regarding the API, I felt that using a `method` parameter instead of adding a `path` to a base url was weird, never saw that before. I had to tweak the `APIRequest.swift` file I usually use and change it to a `method` parameter. Also the `jsoncallback` you receive if you don't send the `nojsoncallback` parameter was also weird. These JavaScript people always doing weird stuff...

I used SwiftUI to make the view. I'm really confortable using it and doing a view like this was really easy. Moreover I've been able to use `AsyncImage` to display the images from a url. If I had to do it in UIKit I would have done it using `SDWebImage`, and without using third-party frameworks, I would had needed to create an ImageLoader that downloads the images in background and caches them. It would have been a bit of a pain compared to just using `AsyncImage`.

I decided to store the images in `UserDefaults`. Personally I'm don't store this kind of information in `UserDefaults` in apps. I almost alwats use `CoreData`, but for this little challenge, without any relationship, I went for the easy thing. Good thing is that the `FlickrImage` related methods are isolated in `ImageRepository`, so if the place where the images is stored changes, the logic is only affected there.

## Things I learned

To be honest I don't think I learned anything new besides the Flickr API, I never used it before. And also refreshed my knowledge on `CoreLocation`, it's been years since I used it. The challenge was quite simple, so there were not that many things where I could learn something.

One thing I will mention is that, during the development of this challenge, I felt that the `CLLocationDelegate` methods were not that reliable. I experienced times where the app stopped receiving location updates. I can't tell if it's because I was using simulator or because I had to handle the `locationManager(_ manager: CLLocationManager, didFailWithError error: Error)` delegate method better. Nevertheless, it was cool to use `CoreLocation` again to refresh my memory.