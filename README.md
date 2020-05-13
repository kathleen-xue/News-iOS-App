# News iOS App
A simple news app that displays headlines, detailed articles, search trends, and allows users to bookmark news articles they would like to return to.

## APIs Used:
* Guardian News API
* OpenWeatherAPI
* Google Search Trends API
* Bing Autosuggest API

## To Run:
1. Clone this repository
1. Open news-ios-app.xcodeproj in Xcode
1. Go to [OpenWeatherAPI](https://openweathermap.org/api) and [Bing Autosuggest API](https://azure.microsoft.com/en-us/services/cognitive-services/autosuggest/) to grab your API keys, and insert them in WeatherGetter.swift and SearchViewController.swift, respectively.
1. Build with command `command ⌘` + `B`, or simply press the ▶ button in the top left corner of the Xcode UI. This should open up the simulator, which will allow you to experiment with the app! For best results, set iPhone version to iPhone 11 Pro Max.

<p float="left">
	<img src="/images/homepage.png" alt="homepage" width="225"/>
	<img src="/images/headlines.png" alt="headlines" width="225"/>
	<img src="/images/trend.png" alt="trending searches" width="225"/>
	<img src="/images/bookmarks.png" alt="bookmarks" width="225"/>
</p>
