# Redux.swift in Belo Horizonte

This repository houses the bootstrap project I used as reference for a talk I gave at the [15th CocoaTalks BH](https://www.meetup.com/CocoaHeads-Talks-BH/events/237132787/) about using [Redux.swift](https://github.com/fellipecaetano/Redux.swift) in iOS applications.

## Contents

- [About the project](#about-the-project)
- [Branching](#branching)
- [Requirements](#requirements)
- [Installation](#installation)

## About the project

The bootstrap project is simply a table view displaying a list of an user's GitHub repositories. The base project is in the `master` branch and the reference implementation is in the `0.1.0` tag.

## Requirements

- Xcode 8.2+
- iOS 10.2+

## Installation

The project has a single dependency, which is [Redux.swift](https://github.com/fellipecaetano/Redux.swift). It was initially integrated to the project using [Carthage](https://github.com/Carthage/Carthage), but the build doesn't require Carthage to be installed. The following installation steps should suffice:

- Clone the desired branch using the following command
```shell
git clone -b <branch> https://github.com/fellipecaetano/ReduxInBH
```

- Enter the `app` directory

- Use Xcode 8.2+ to open `GitHubClient.xcworkspace`

- Build and run

