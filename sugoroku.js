'use strict';

// a quiz for solving the longest step
// with 5 throws of dice(s).
//
// * There is a terminate point at 40 in the original quiz.
// * Ignore the condition as just interested the longest step
//
// Quiz 1:
// starts with one dice.
// Acquire one more dice for one time if getting a total point not larger than 3
//
// Quiz 2:
// starts with one dice.
// 1. Acquire one more dice usable from then on if getting a total point not larger than 3
// 2. The dice with a point of not smaller than 5 will be no more usable.
// 3. You have at least one dice (The dice getting a point not smaller than 5 will not be removed if it is the only dice at hand).
//
// Special rule of the board:
// 1. skip to 11 if stop at 7
// 2. skip to 16 if stop at 12
// 3. skip to 21 if stop at 17
//
//
// Output of the script (omitting histories aquiring same step):
//
// ================Quiz 1=============
// longest step: 39 steps with a history
// start -> 1 -> 6,5 -> 1 -> 6,6 -> 6
// ===================================
// ================Quiz 2=============
// longest step: 45 steps with a history
// start -> 1 -> 2,1 -> 1,1,1 -> 3,1,1,1 -> 6,6,6,6
// ===================================

const DICE_MAX = 6;
const THROW_COUNT = 5;
// var MAX_STEP = 40;

class Board {
    constructor() {
        this.currPostion = 0;
    }

    getPostion() {
        return this.currPostion;
    }

    runHistory(history) {
        for (let currRound of history) {
            this.currPostion += currRound.reduce((s, c) => s + c);
            this.currPostion = this.checkSkip();
            // if (this.currPostion >= MAX_STEP) {
            //     break;
            // }
        }
        return this.currPostion;
    }

    checkSkip() {
        let targetPosition;
        switch (this.currPostion) {
            case 7:
                targetPosition = 11;
                break;
            case 12:
                targetPosition = 16;
                break;
            case 17:
                targetPosition = 21;
                break;
            default:
                targetPosition = this.currPostion;
        }
        return targetPosition;
    }

    reset() {
        this.currPostion = 0;
    }
}

class History {
    constructor() {
        this.history = [[1]];
        this.renewAllRoundsFollowing(1);
    }

    next() {
        return this.rethrow(THROW_COUNT);
    }

    renewAllRoundsFollowing(r) {
        let round = r;
        while (this.hasNextRound(round++)) {
            this.newRound(round);
            this.renewAllRoundsFollowing(round);
        }
    }

    newRound() {}

    rethrow(r) {
        let round = this.getRound(r);
        let noDiceToTest = true;
        for (let diceIdx in round) {
            let dice = round[diceIdx];
            if (dice < DICE_MAX) {
                round[diceIdx] = dice + 1;
                noDiceToTest = false;
                break;
            } else {
                continue;
            }
        }
        if (noDiceToTest) {
            if (r == 1) {
                return false;
            } else {
                return this.rethrow(r - 1);
            }
        }
        this.renewAllRoundsFollowing(r);
        return true;
    }

    totalOfRound(r) {
        return this.getRound(r).reduce((s, c) => s + c);
    }

    totalOfLastRound(r) {
        return this.totalOfRound(r - 1);
    }

    getRound(r) {
        return this.history[r - 1];
    }

    hasNextRound(r) {
        return r < THROW_COUNT;
    }

    getHistorySize() {
        return this.history.length;
    }

    getHistory() {
        return this.history;
    }

    getHistoryStr() {
        return this.history.reduce(function(s, c) {
            return s + ' -> ' + c;
        }, 'start');
    }

    setNewRound(r, round) {
        this.history[r - 1] = round;
    }
}

class HistoryQuizA extends History {
    newRound(r) {
        if (this.totalOfLastRound(r) <= 3) {
            this.history[r - 1] = [1, 1];
        } else {
            this.history[r - 1] = [1];
        }
    }
}

class HistoryQuizB extends History {
    newRound(r) {
        let currRound;
        if (this.totalOfLastRound(r) <= 3) {
            currRound = Array(this.getRound(r - 1).length + 1).fill(1);
        } else {
            let newLen = Math.max(
                this.getRound(r - 1).filter(dice => dice < 5).length,
                1
            );
            currRound = Array(newLen).fill(1);
        }
        this.setNewRound(r, currRound);
    }
}

class Report {
    constructor(result, title) {
        this.result = result;
        this.title = title;
    }

    report() {
        console.log(`================${this.title}=============`);
        console.log(`longest step: ${this.result.longestStep} steps with a history`);
        console.log(this.result.longestHistory);
        console.log('===================================');
    }
}

function runHistory(history) {
    let result = {};
    result.longestStep = 0;
    do {
        let step = board.runHistory(history.getHistory());
        // console.log(`To Test History: ${history.getHistoryStr()}`);
        // console.log(`Result Step of The History: ${step}`);
        if (step > result.longestStep) {
            result.longestStep = step;
            result.longestHistory = history.getHistoryStr();
        }
        board.reset();
    } while (history.next());
    return result;
}

const board = new Board();

var historyA = new HistoryQuizA();
const reportA = new Report(runHistory(historyA), 'Quiz 1');

var historyB = new HistoryQuizB();
const reportB = new Report(runHistory(historyB), 'Quiz 2');

reportA.report();
reportB.report();
