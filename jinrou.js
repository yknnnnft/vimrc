'use strict'

// There are 3 villagers that is an wolfman or a human.
// The villagers may be a liar or an honest,
// which has no relation of their being an wolfman or a human.
//
// villager A: "C is an wolfman"
// villager B: "I am not an wolfman"
// villager C: "There are more than 2 liars among us."
//
// Solve the truth.
//
// ======Patter found!=======
// A: liar, human
// B: liar, wolf
// C: honest, human
// --------------------------
// ======Patter found!=======
// A: liar, wolf
// B: liar, wolf
// C: honest, human
// --------------------------
// ======Patter found!=======
// A: honest, human
// B: honest, human
// C: liar, wolf
// --------------------------
// ======Patter found!=======
// A: honest, wolf
// B: honest, human
// C: liar, wolf
// --------------------------

var villagers = [];

class villager {
    constructor(isLiar, isWolf) {
        this.isLiar = isLiar;
        this.isWolf = isWolf;
    }

    word() {
        return false;
    }

    tell() {
        return this.isLiar ^ this.word();
    }

    status() {
        return `${this.liarJudge()}, ${this.wolfJudge()}`;
    }

    liarJudge() {
        return this.isLiar ? 'liar' : 'honest';
    }

    wolfJudge() {
        return this.isWolf ? 'wolf' : 'human';
    }
}

class villagerA extends villager{
    word() {
        return villager[2].isWolf == true;
    }
}

class villagerB extends villager{
    word() {
        return this.isWolf == false;
    }
}

class villagerC extends villager{
    word() {
        return villager.filter(v => v.isLiar).length >= 2;
    }
}

function check(arrLiar, arrWolf) {
    let A = new villagerA(arrLiar[0], arrWolf[0]);
    let B = new villagerB(arrLiar[1], arrWolf[1]);
    let C = new villagerC(arrLiar[2], arrWolf[2]);

    villager = [A, B, C];
    if (A.tell() && B.tell() && C.tell()) {
        console.log('======Patter found!=======');
        console.log(`A: ${A.status()}`);
        console.log(`B: ${B.status()}`);
        console.log(`C: ${C.status()}`);
        console.log('--------------------------');
    }
}

for (let i = 0; i < 8; i++) {
    let isLiarA = i & parseInt('001', 2) == 1;
    let isLiarB = ((i & parseInt('010', 2)) / parseInt('010', 2)) == 1;
    let isLiarC = ((i & parseInt('100', 2)) / parseInt('100', 2)) == 1;
    let arrLiar = [isLiarA, isLiarB, isLiarC];
    for (let j = 0; j < 8; j++) {
        let isWolfA = (j & parseInt('001', 2)) == 1;
        let isWolfB = ((j & parseInt('010', 2)) / parseInt('010', 2)) == 1;
        let isWolfC = ((j & parseInt('100', 2)) / parseInt('100', 2)) == 1;
        let arrWolf = [isWolfA, isWolfB, isWolfC];
        check(arrLiar, arrWolf);
    }
}
