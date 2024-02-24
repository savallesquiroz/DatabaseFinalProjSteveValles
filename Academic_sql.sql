CREATE TABLE coach (
    coachid     INTEGER NOT NULL,
    firstname   VARCHAR2(255),
    lastname    VARCHAR2(255),
    dateofbirth DATE,
    nationality VARCHAR2(255),
    team_teamid INTEGER
)
LOGGING;

ALTER TABLE coach ADD CONSTRAINT coach_pk PRIMARY KEY ( coachid );

CREATE TABLE league (
    leagueid      INTEGER NOT NULL,
    leaguename    VARCHAR2(255),
    country       VARCHAR2(255),
    foundedyear   INTEGER,
    numberofteams INTEGER
)
LOGGING;

ALTER TABLE league ADD CONSTRAINT league_pk PRIMARY KEY ( leagueid );

CREATE TABLE match (
    matchid      INTEGER NOT NULL,
    team_teamid  INTEGER,
    team_teamid2 INTEGER,
    datetime     DATE,
    stadium      VARCHAR2(255)
)
LOGGING;

ALTER TABLE match ADD CONSTRAINT match_pk PRIMARY KEY ( matchid );

CREATE TABLE matchstatistics (
    statisticid       INTEGER NOT NULL,
    match_matchid     INTEGER,
    homegoalsscored   INTEGER,
    awaygoalsscored   INTEGER,
    homepossession    NUMBER(5, 2),
    awaypossession    NUMBER(5, 2),
    homeshotsontarget INTEGER,
    awayshotsontarget INTEGER
)
LOGGING;

ALTER TABLE matchstatistics ADD CONSTRAINT matchstatistics_pk PRIMARY KEY ( statisticid );

CREATE TABLE player (
    playerid    INTEGER NOT NULL,
    firstname   VARCHAR2(255),
    lastname    VARCHAR2(255),
    position    VARCHAR2(255),
    dateofbirth DATE,
    nationality VARCHAR2(255),
    marketvalue NUMBER(10, 2),
    team_teamid INTEGER
)
LOGGING;

ALTER TABLE player ADD CONSTRAINT player_pk PRIMARY KEY ( playerid );

CREATE TABLE playerstatistics (
    statisticid     INTEGER NOT NULL,
    player_playerid INTEGER,
    match_matchid   INTEGER,
    goalsscored     INTEGER,
    assists         INTEGER,
    yellowcards     INTEGER,
    redcards        INTEGER
)
LOGGING;

ALTER TABLE playerstatistics ADD CONSTRAINT playerstatistics_pk PRIMARY KEY ( statisticid );

CREATE TABLE team (
    teamid          INTEGER NOT NULL,
    teamname        VARCHAR2(255),
    stadiumname     VARCHAR2(255),
    stadiumcapacity INTEGER,
    city            VARCHAR2(255),
    league_leagueid INTEGER
)
LOGGING;

ALTER TABLE team ADD CONSTRAINT team_pk PRIMARY KEY ( teamid );

ALTER TABLE coach
    ADD CONSTRAINT coach_team_fk FOREIGN KEY ( team_teamid )
        REFERENCES team ( teamid )
    NOT DEFERRABLE;

ALTER TABLE match
    ADD CONSTRAINT match_team_fk FOREIGN KEY ( team_teamid )
        REFERENCES team ( teamid )
    NOT DEFERRABLE;

ALTER TABLE match
    ADD CONSTRAINT match_team_fkv2 FOREIGN KEY ( team_teamid2 )
        REFERENCES team ( teamid )
    NOT DEFERRABLE;

ALTER TABLE matchstatistics
    ADD CONSTRAINT matchstatistics_match_fk FOREIGN KEY ( match_matchid )
        REFERENCES match ( matchid )
    NOT DEFERRABLE;

ALTER TABLE player
    ADD CONSTRAINT player_team_fk FOREIGN KEY ( team_teamid )
        REFERENCES team ( teamid )
    NOT DEFERRABLE;

ALTER TABLE playerstatistics
    ADD CONSTRAINT playerstatistics_match_fk FOREIGN KEY ( match_matchid )
        REFERENCES match ( matchid )
    NOT DEFERRABLE;

ALTER TABLE playerstatistics
    ADD CONSTRAINT playerstatistics_player_fk FOREIGN KEY ( player_playerid )
        REFERENCES player ( playerid )
    NOT DEFERRABLE;

ALTER TABLE team
    ADD CONSTRAINT team_league_fk FOREIGN KEY ( league_leagueid )
        REFERENCES league ( leagueid )
    NOT DEFERRABLE;