# Instagram Clone — Ruby / Parse

Photo sharing app built with Ruby and a Parse backend during a CodePath exercise. Users sign up, log in, post photos with captions, and browse the 20 most recent posts.

![Ruby](https://img.shields.io/badge/Ruby-2.x-CC342D?logo=ruby&logoColor=white)
![Parse](https://img.shields.io/badge/Backend-Parse-7B4FB5)
![License](https://img.shields.io/badge/License-Apache%202.0-lightgrey)

---

## Features

- Sign up and log in via Parse authentication; session persists across restarts
- Take a photo or pick from the library, add a caption, and post to the feed
- Browse the 20 most recent posts sorted by creation time
- Custom app icon

---

## Tech Stack

| Layer | Technology |
|---|---|
| Language | Ruby |
| Backend | Parse SDK (PFUser, PFObject, PFFile) |
| Auth | PFUser sign-up / log-in with session persistence |
| Storage | PFFile for image uploads |

---

## Setup

Configure your Parse `applicationId`, `clientKey`, and server URL before running.
