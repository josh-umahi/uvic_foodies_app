# Uvic Foodies App

An iOS / Android app I built as a side project for my school, the University of Victoria. It shows details of all the places you can get food on campus. This includes operating hours, meal offerings and location. 
It's currently not on the App store / Play store but you can demo it on your computer by cloning the repository above. 

## How this app was made

This app was built using the [flutter framework](https://flutter.dev/docs) and some additional external libraries from [pub.dev](https://pub.dev).
These include:

| Name                                                    | Usage                                               |
| ------------------------------------------------------- | --------------------------------------------------- |
| [**flutter_bloc**](https://pub.dev/packages/flutter_bloc)       | State Management                                    |
| [**http**](https://pub.dev/packages/http)      | Making HTTP requests       |
| [**cached_network_image**](https://pub.dev/packages/cached_network_image)       | To display images from the internet and keep them in the cache directory.                                 |

The backend consists of a [Contentful CMS](https://www.contentful.com) that allows for easy creation of new data within the app as well as modification.

<br>

<p float="left">
    <img src="https://raw.githubusercontent.com/josh-umahi/josh-umahi/master/.github/images/uvic_foodies_1.png" alt="Screenshot of app" width="600">
</p>

<p float="left">
    <img src="https://raw.githubusercontent.com/josh-umahi/josh-umahi/master/.github/images/uvic_foodies_3.png" alt="Screenshot of app" width="400">
</p>

<p float="left">
    <img src="https://raw.githubusercontent.com/josh-umahi/josh-umahi/master/.github/images/uvic_foodies_2.png" alt="Screenshot of app" width="600">
</p>