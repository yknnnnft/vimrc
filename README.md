# JavascriptStudy  

## jinrou.js  
There are 3 villagers that is an wolfman or a human.  
The villagers may be a liar or an honest,  
which has no relation of their being an wolfman or a human.  
- villager A: "C is an wolfman"
- villager B: "I am not an wolfman"
- villager C: "There are no less than 2 liars among us."  

Solve the truth.

## sugoroku.js
a quiz for solving the longest step  
with 5 throws of dice(s).  
* There is a terminate point at 40 in the original quiz.  
* Ignore the condition as just interested the longest step  
#### Quiz 1:  
starts with one dice.  
Acquire one more dice for one time if getting a total point not larger than 3  

#### Quiz 2:  
starts with one dice.  
1. Acquire one more dice usable from then on if getting a total point not larger than 3  
1. The dice with a point of not smaller than 5 will be no more usable.  
1. You have at least one dice (The dice getting a point not smaller than 5 will not be removed if it is the only dice at hand).  

#### Special rule of the board:  
1. skip to 11 if stop at 7  
1. skip to 16 if stop at 12  
1. skip to 21 if stop at 17  
