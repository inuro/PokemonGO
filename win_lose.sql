
DROP TABLE if exists win_lose;
CREATE TABLE if not exists win_lose (
    uid text,
    fast text,
    charge text,
    win int,
    draw int,
    lose int
);
\copy win_lose(uid,fast,charge,win,draw,lose) from 'killtime_1500.tsv' with CSV delimiter E'\t' NULL '';

DROP TABLE if exists win_lose_2500;
CREATE TABLE if not exists win_lose_2500 (
    uid text,
    fast text,
    charge text,
    win int,
    draw int,
    lose int
);
\copy win_lose_2500(uid,fast,charge,win,draw,lose) from 'killtime_2500.tsv' with CSV delimiter E'\t' NULL '';

