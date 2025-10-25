# BudgetTracker
## Introduction
I wanted to create an app that I could use to personally track my spendings (per paycheck) on my phone.

I have always used GoodNotes on my iPad to track my spendings. For example, this is how it would look like (these amounts are an example, but it looks exactly like this):

<img src="https://github.com/user-attachments/assets/bcebcb02-48a9-4374-b665-d78f1312ccfe" height="300" width="400">

Although this is not a bad practice, I just wanted a way to do it easier so instead of having to find my iPad and manually write everything down, which can be a bit annoying sometimes. So, why not create a solution where I can do it on the most used object daily that I have: my iPhone.

# The App
## The Icon
This is the App Icon Used:

<img width="200" height="200" alt="icon copy" src="https://github.com/user-attachments/assets/09c23a94-dba7-48fb-b30e-5d527872f484" />

Shoutout to my friend Jade Williams (I will add her personal website link once she updates it) - she is an aspiring designer and I must say she created a really cool icon.

## The IntroView
This is the Introduction View of the app:

<img width="300" height="650" alt="simulator_screenshot_0339C04A-3DA9-4ED7-94C5-E9F689641F4E" src="https://github.com/user-attachments/assets/63481dc7-234a-46e8-95e9-9ad4d3239caa" />

It has a fade away affect and the view will slide to the left to show the main page, which is the TrackView.

## The TrackView
This is the main screen and the most important part of the app:

<img width="300" height="650" alt="simulator_screenshot_DD833C5B-DC93-4153-80FF-588D9FEEAC0D" src="https://github.com/user-attachments/assets/31318b1a-153a-46d2-b2b7-f1af1dbad03a" />

The TrackView has the big bubble of the Budget Available (assuming you entered a paycheck - or it will be negative) to see how much of the paycheck you have left after adding transactions. If there are no transactions like above, then it will show a screen that says "Let's add your first transaction! 💸"

When there are transactions added, here is an example of what it looks:

<img width="300" height="650" alt="simulator_screenshot_6E41BBA6-47BA-4DFE-B640-571CE0D25848" src="https://github.com/user-attachments/assets/de3c2011-6e00-4eef-a624-1f4a8131361f" />

A little perk is that you can see what category each transaction is in and the date! More on it below.

### Buttons related to Transactions

There are two buttons that show up in this view:

<img width="200" height="25" alt="image" src="https://github.com/user-attachments/assets/2a19a516-17a5-4d2c-899b-e6865a1d6d4f" />


The left side's gear button shows the menu options, which you can either clear the transactions and reset it for the next paycheck cycle use (or if you just want to redo it), or to export the transactions into a CSV so you can keep a history of your tracking:


<img width="200" height="90" alt="image" src="https://github.com/user-attachments/assets/a662f08c-c5d5-4c5f-bdec-cac3277d6019" />

The right side's plus button pulls up the sheet where you can add a transaction. You can add a date, description, amount, choose between spending or receiving, and picking what category the transaction was:

<img width="300" height="650" alt="simulator_screenshot_EE829B2D-6702-46F9-BD34-50207F9ADF17" src="https://github.com/user-attachments/assets/e4b5e4c2-4bce-4e2b-a202-ac2c68e7cae2" />

## Buttons to choose the Views

There are two buttons on the bottom of this app where you can choose between Tracking and the OverView part of the app. The selected view will have the button highlighted in green, and the other will be in gray.

<img width="300" height="65" alt="image" src="https://github.com/user-attachments/assets/6da42ea4-9bad-4840-91ef-f9ee857197f3" />


## The OverView
The OverView looks as below:

<img width="300" height="650" alt="simulator_screenshot_42EB36AA-65B0-4B9A-8959-E2C1957A8480" src="https://github.com/user-attachments/assets/e95f0403-559e-4a3b-9696-ceef51bcaa55" />

It shows the breakdown of the spending by the pie chart and the list view with the color associated with the pie chart, the ratio, and the total amount in each category.

If you have no transactions, it will say: "Add spendings to see the breakdown! 💸"

## Overall
Overall, I learned so much more about iOS Development. I was able to use the knowledge I gained from building the BillSplitApp and write cleaner and better code. 
I also learned that even though apps like this are quite simple, the development is pretty hard.
I was also able to use more packages such as `UIKit` and `Charts`, which was eye-opening.

I think the next step is to: 1) Do more unit-test based development and 2) (Hopefully) More design elements (I am not a designer by nature but am working on it) 

I really enjoy iOS Development and hope to hone my skills more. The process has been really enjoyable 😄
