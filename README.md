# Scribbly

A Flashcard App that allows users to associate quick sketches to definitions.

## UI/UX design

[Figma Link](https://www.figma.com/file/0M6YkzN996FCDSUrmvRAzK/438-Wireframes?node-id=0%3A1&t=j50r7HvnAVDW8pTJ-1)

## Authors

- [@Pascal-Yang](https://github.com/Pascal-Yang)
- [@Elyse-Tang](https://github.com/Elyse-Tang)
- [@Oscar-Zhu](https://github.com/oscarzhu142857)
- [@Kristen-Wang](https://github.com/KristennnnW)
- [@Jingyuan-Zhu](https://github.com/Jingyuan-zhu)

## Existing User

- username: test
- password: 123

## Run Locally

### Clone/Download the project

```bash
  git clone https://github.com/Pascal-Yang/438Final.git
```

### Install dependencies

- Scribbly uses Ezpopup for some of its popup views

### Navigate to project folder and run through xcode.
- User may either register for a new account or use the existing account "test"


### Further details
Users may either register a new account or log in with the “Existing User” account.

One can log in without signing up using the Username and Password of the Existing User.

Users may fail to log in because of incorrect/non-existing username.

-	The existing account with username “test” has some courses added to the folder view 
-	Each course under account “test” already has some preconfigured flashcards

User can also sign up with new Username and Password

-	User can choose a cute photo image as profile image
-	User can add a new course from the library view
-	User can edit the course name
-	User can add flashcards to any course
-	Each flashcard has a term name, a definition, and a scribble(image) field
-	The scribble (canvas) view has options to change stroke size and brush color
-	Flashcards can be edited
-	User can select on any card to start learning the set
-	From the learning flow, the user can click the “check”/”uncheck” button to mark the card as learned/not yet learned
-	Progress bar above the flashcard displays the learning progress
-	Progress bar is updated accordingly in the library view

Each User has a separate set of data sets
