USE Soccer_LeagueDB;
GO

UPDATE Team
SET GF = stats.total_goals
FROM (
    SELECT team_id, SUM(goals_scored) AS total_goals
    FROM (
        SELECT home_team_id AS team_id, home_team_goals_number AS goals_scored
        FROM Matchs 
        UNION ALL
        SELECT away_team_id, away_team_goals_number
        FROM Matchs
    ) AS all_goals
    GROUP BY team_id
) AS stats
WHERE Team.team_id = stats.team_id;

UPDATE Team
SET yellow_card_numbers = stats.total_yellows
FROM (
    SELECT team_id, SUM(yellows) AS total_yellows
    FROM (
        SELECT home_team_id AS team_id, home_team_yellow_cards_number AS yellows
        FROM Matchs
        UNION ALL
        SELECT away_team_id, away_team_yellow_cards_number
        FROM Matchs
    ) AS yellow_data
    GROUP BY team_id
) AS stats
WHERE Team.team_id = stats.team_id;

UPDATE Team
SET red_card_numbers = stats.total_reds
FROM (
    SELECT team_id, SUM(reds) AS total_reds
    FROM (
        SELECT home_team_id AS team_id, home_team_red_cards_number AS reds
        FROM Matchs
        UNION ALL
        SELECT away_team_id, away_team_red_cards_number
        FROM Matchs
    ) AS red_data
    GROUP BY team_id
) AS stats
WHERE Team.team_id = stats.team_id;

UPDATE Team
SET GA = stats.total_goals_against
FROM (
    SELECT team_id, SUM(goals_against) AS total_goals_against
    FROM (
        SELECT home_team_id AS team_id, away_team_goals_number AS goals_against
        FROM Matchs
        UNION ALL
        SELECT away_team_id, home_team_goals_number
        FROM Matchs
    ) AS all_goals_against
    GROUP BY team_id
) AS stats
WHERE Team.team_id = stats.team_id;

UPDATE Team
SET Wins = stats.total_wins
FROM (
    SELECT team_id, COUNT(*) AS total_wins
    FROM (
        SELECT home_team_id AS team_id
        FROM Matchs
        WHERE home_team_goals_number > away_team_goals_number
        UNION ALL
        SELECT away_team_id
        FROM Matchs
        WHERE away_team_goals_number > home_team_goals_number
    ) AS all_wins
    GROUP BY team_id
) AS stats
WHERE Team.team_id = stats.team_id;

UPDATE Team
SET Losts = stats.total_losses
FROM (
    SELECT team_id, COUNT(*) AS total_losses
    FROM (
        SELECT home_team_id AS team_id
        FROM Matchs
        WHERE home_team_goals_number < away_team_goals_number
        UNION ALL
        SELECT away_team_id
        FROM Matchs
        WHERE away_team_goals_number < home_team_goals_number
    ) AS all_losses
    GROUP BY team_id
) AS stats
WHERE Team.team_id = stats.team_id;

UPDATE Team
SET Draws = stats.total_draws
FROM (
    SELECT team_id, COUNT(*) AS total_draws
    FROM (
        SELECT home_team_id AS team_id
        FROM Matchs
        WHERE home_team_goals_number = away_team_goals_number
        UNION ALL
        SELECT away_team_id
        FROM Matchs
        WHERE away_team_goals_number = home_team_goals_number
    ) AS all_draws
    GROUP BY team_id
) AS stats
WHERE Team.team_id = stats.team_id;

UPDATE Team
SET MP = stats.total_matches
FROM (
    SELECT team_id, COUNT(*) AS total_matches
    FROM (
        SELECT home_team_id AS team_id
        FROM Matchs
        UNION ALL
        SELECT away_team_id
        FROM Matchs
    ) AS all_matches
    GROUP BY team_id
) AS stats
WHERE Team.team_id = stats.team_id;

UPDATE Player
SET goals_number = (
    SELECT COUNT(*)
    FROM Scored_Goal_in_Match s
    WHERE s.player_id = Player.player_id
      AND s.own_goal = 0
);

UPDATE Player
SET asists_numbers = (
    SELECT COUNT(*)
    FROM Assisted_Goal_in_Match a
    WHERE a.player_id = Player.player_id
);

UPDATE Player
SET total_yellow_cards_number = (
    SELECT COUNT(*)
    FROM Card_Received_in_Match c
    WHERE c.player_id = Player.player_id
      AND c.card_type = 'yellow'
);

UPDATE Player
SET total_red_cards_number = (
    SELECT COUNT(*)
    FROM Card_Received_in_Match c
    WHERE c.player_id = Player.player_id
      AND c.card_type = 'red'
);

UPDATE Player
SET Own_goal_number = (
    SELECT COUNT(*)
    FROM Scored_Goal_in_Match s
    WHERE s.player_id = Player.player_id
      AND s.own_goal = 1
);

UPDATE referee
SET total_yellow_cards_number = yellow_stats.total_yellows
FROM (
    SELECT rpm.referee_id, 
           SUM(m.home_team_yellow_cards_number + m.away_team_yellow_cards_number) AS total_yellows
    FROM Referee_Per_Match rpm
    JOIN Matchs m ON rpm.match_id = m.match_id
    WHERE rpm.role = 'main'
    GROUP BY rpm.referee_id
) AS yellow_stats
WHERE referee.referee_id = yellow_stats.referee_id;

UPDATE referee
SET total_red_cards_number = red_stats.total_reds
FROM (
    SELECT rpm.referee_id, 
           SUM(m.home_team_red_cards_number + m.away_team_red_cards_number) AS total_reds
    FROM Referee_Per_Match rpm
    JOIN Matchs m ON rpm.match_id = m.match_id
    WHERE rpm.role = 'main'
    GROUP BY rpm.referee_id
) AS red_stats
WHERE referee.referee_id = red_stats.referee_id;

UPDATE referee
SET total_matchs_number = match_stats.match_count
FROM (
    SELECT referee_id, COUNT(*) AS match_count
    FROM Referee_Per_Match
    GROUP BY referee_id
) AS match_stats
WHERE referee.referee_id = match_stats.referee_id;

UPDATE Team
SET Draws = 0 WHERE team_id = 7;

UPDATE Team
SET Losts = 0 WHERE team_id = 7;

UPDATE Team
SET GD = GF - GA;

UPDATE Team
SET points = Wins*3 + Draws;

UPDATE Matchs
SET away_team_ball_possession = 100 - home_team_ball_possession;

UPDATE Player_Match_Participation
SET position = p.position
FROM Player_Match_Participation as pmp
join Player as p ON pmp.player_id = p.player_id;

UPDATE Player_Match_Participation
SET minute_in = 0 ;

UPDATE Coach
SET coach_photo_url = 'D:\University\Bachelor\Term 6\Database\Project\images\Coachs\Coach (1)' WHERE coach_id = 1;
UPDATE Coach 
SET coach_photo_url = 'D:\University\Bachelor\Term 6\Database\Project\images\Coachs\Coach (2)' WHERE coach_id = 2;
UPDATE Coach 
SET coach_photo_url = 'D:\University\Bachelor\Term 6\Database\Project\images\Coachs\Coach (3)' WHERE coach_id = 3;
UPDATE Coach 
SET coach_photo_url = 'D:\University\Bachelor\Term 6\Database\Project\images\Coachs\Coach (4)' WHERE coach_id = 4;
UPDATE Coach 
 SET coach_photo_url = 'D:\University\Bachelor\Term 6\Database\Project\images\Coachs\Coach (5)' WHERE coach_id = 5;
UPDATE Coach 
 SET coach_photo_url = 'D:\University\Bachelor\Term 6\Database\Project\images\Coachs\Coach (6)' WHERE coach_id = 6;
UPDATE Coach 
 SET coach_photo_url = 'D:\University\Bachelor\Term 6\Database\Project\images\Coachs\Coach (7)' WHERE coach_id = 7;
UPDATE Coach 
 SET coach_photo_url = 'D:\University\Bachelor\Term 6\Database\Project\images\Coachs\Coach (8)' WHERE coach_id = 8;
UPDATE Coach 
 SET coach_photo_url = 'D:\University\Bachelor\Term 6\Database\Project\images\Coachs\Coach (9)' WHERE coach_id = 9;
UPDATE Coach 
 SET coach_photo_url = 'D:\University\Bachelor\Term 6\Database\Project\images\Coachs\Coach (10)' WHERE coach_id = 10;
UPDATE Coach 
 SET coach_photo_url = 'D:\University\Bachelor\Term 6\Database\Project\images\Coachs\Coach (11)' WHERE coach_id = 11;
UPDATE Coach 
 SET coach_photo_url = 'D:\University\Bachelor\Term 6\Database\Project\images\Coachs\Coach (12)' WHERE coach_id = 12;
UPDATE Coach 
 SET coach_photo_url = 'D:\University\Bachelor\Term 6\Database\Project\images\Coachs\Coach (13)' WHERE coach_id = 13;
UPDATE Coach 
 SET coach_photo_url = 'D:\University\Bachelor\Term 6\Database\Project\images\Coachs\Coach (14)' WHERE coach_id = 14;
UPDATE Coach 
 SET coach_photo_url = 'D:\University\Bachelor\Term 6\Database\Project\images\Coachs\Coach (15)' WHERE coach_id = 15;
UPDATE Coach 
 SET coach_photo_url = 'D:\University\Bachelor\Term 6\Database\Project\images\Coachs\Coach (16)' WHERE coach_id = 16;
UPDATE Coach 
 SET coach_photo_url = 'D:\University\Bachelor\Term 6\Database\Project\images\Coachs\Coach (17)' WHERE coach_id = 17;
UPDATE Coach
 SET coach_photo_url = 'D:\University\Bachelor\Term 6\Database\Project\images\Coachs\Coach (18)' WHERE coach_id = 18;
UPDATE Coach
 SET coach_photo_url = 'D:\University\Bachelor\Term 6\Database\Project\images\Coachs\Coach (19)' WHERE coach_id = 19;
UPDATE Coach
 SET coach_photo_url = 'D:\University\Bachelor\Term 6\Database\Project\images\Coachs\Coach (20)' WHERE coach_id = 20;
UPDATE Coach
 SET coach_photo_url = 'D:\University\Bachelor\Term 6\Database\Project\images\Coachs\Coach (21)' WHERE coach_id = 21;
UPDATE Coach
 SET coach_photo_url = 'D:\University\Bachelor\Term 6\Database\Project\images\Coachs\Coach (22)' WHERE coach_id = 22;
UPDATE Coach
 SET coach_photo_url = 'D:\University\Bachelor\Term 6\Database\Project\images\Coachs\Coach (23)' WHERE coach_id = 23;
UPDATE Coach
 SET coach_photo_url = 'D:\University\Bachelor\Term 6\Database\Project\images\Coachs\Coach (24)' WHERE coach_id = 24;
UPDATE Coach
 SET coach_photo_url = 'D:\University\Bachelor\Term 6\Database\Project\images\Coachs\Coach (25)' WHERE coach_id = 25;
UPDATE Coach
 SET coach_photo_url = 'D:\University\Bachelor\Term 6\Database\Project\images\Coachs\Coach (26)' WHERE coach_id = 26;
UPDATE Coach
 SET coach_photo_url = 'D:\University\Bachelor\Term 6\Database\Project\images\Coachs\Coach (27)' WHERE coach_id = 27;
UPDATE Coach
 SET coach_photo_url = 'D:\University\Bachelor\Term 6\Database\Project\images\Coachs\Coach (28)' WHERE coach_id = 28;
UPDATE Coach
 SET coach_photo_url = 'D:\University\Bachelor\Term 6\Database\Project\images\Coachs\Coach (29)' WHERE coach_id = 29;
UPDATE Coach
 SET coach_photo_url = 'D:\University\Bachelor\Term 6\Database\Project\images\Coachs\Coach (30)' WHERE coach_id = 30;
UPDATE Coach
 SET coach_photo_url = 'D:\University\Bachelor\Term 6\Database\Project\images\Coachs\Coach (31)' WHERE coach_id = 31;
UPDATE Coach
 SET coach_photo_url = 'D:\University\Bachelor\Term 6\Database\Project\images\Coachs\Coach (32)' WHERE coach_id = 32;
UPDATE Coach
 SET coach_photo_url = 'D:\University\Bachelor\Term 6\Database\Project\images\Coachs\Coach (33)' WHERE coach_id = 33;
UPDATE Coach
 SET coach_photo_url = 'D:\University\Bachelor\Term 6\Database\Project\images\Coachs\Coach (34)' WHERE coach_id = 34;
UPDATE Coach
 SET coach_photo_url = 'D:\University\Bachelor\Term 6\Database\Project\images\Coachs\Coach (35)' WHERE coach_id = 35;
UPDATE Coach
 SET coach_photo_url = 'D:\University\Bachelor\Term 6\Database\Project\images\Coachs\Coach (36)' WHERE coach_id = 36;
UPDATE Coach
 SET coach_photo_url = 'D:\University\Bachelor\Term 6\Database\Project\images\Coachs\Coach (37)' WHERE coach_id = 37;
UPDATE Coach
 SET coach_photo_url = 'D:\University\Bachelor\Term 6\Database\Project\images\Coachs\Coach (38)' WHERE coach_id = 38;
UPDATE Coach
 SET coach_photo_url = 'D:\University\Bachelor\Term 6\Database\Project\images\Coachs\Coach (39)' WHERE coach_id = 39;
UPDATE Coach
 SET coach_photo_url = 'D:\University\Bachelor\Term 6\Database\Project\images\Coachs\Coach (40)' WHERE coach_id = 40;
UPDATE Coach
 SET coach_photo_url = 'D:\University\Bachelor\Term 6\Database\Project\images\Coachs\Coach (41)' WHERE coach_id = 41;
UPDATE Coach
 SET coach_photo_url = 'D:\University\Bachelor\Term 6\Database\Project\images\Coachs\Coach (42)' WHERE coach_id = 42;
UPDATE Coach
 SET coach_photo_url = 'D:\University\Bachelor\Term 6\Database\Project\images\Coachs\Coach (43)' WHERE coach_id = 43;
UPDATE Coach
 SET coach_photo_url = 'D:\University\Bachelor\Term 6\Database\Project\images\Coachs\Coach (44)' WHERE coach_id = 44;
UPDATE Coach
 SET coach_photo_url = 'D:\University\Bachelor\Term 6\Database\Project\images\Coachs\Coach (45)' WHERE coach_id = 45;
UPDATE Coach
 SET coach_photo_url = 'D:\University\Bachelor\Term 6\Database\Project\images\Coachs\Coach (46)' WHERE coach_id = 46;
UPDATE Coach
 SET coach_photo_url = 'D:\University\Bachelor\Term 6\Database\Project\images\Coachs\Coach (47)' WHERE coach_id = 47;
UPDATE Coach
 SET coach_photo_url = 'D:\University\Bachelor\Term 6\Database\Project\images\Coachs\Coach (48)' WHERE coach_id = 48;
UPDATE Coach
 SET coach_photo_url = 'D:\University\Bachelor\Term 6\Database\Project\images\Coachs\Coach (49)' WHERE coach_id = 49;
UPDATE Coach
 SET coach_photo_url = 'D:\University\Bachelor\Term 6\Database\Project\images\Coachs\Coach (50)' WHERE coach_id = 50;
UPDATE Coach
 SET coach_photo_url = 'D:\University\Bachelor\Term 6\Database\Project\images\Coachs\Coach (51)' WHERE coach_id = 51;
UPDATE Coach
 SET coach_photo_url = 'D:\University\Bachelor\Term 6\Database\Project\images\Coachs\Coach (52)' WHERE coach_id = 52;
UPDATE Coach
 SET coach_photo_url = 'D:\University\Bachelor\Term 6\Database\Project\images\Coachs\Coach (53)' WHERE coach_id = 53;
UPDATE Coach
 SET coach_photo_url = 'D:\University\Bachelor\Term 6\Database\Project\images\Coachs\Coach (54)' WHERE coach_id = 54;
UPDATE Coach
 SET coach_photo_url = 'D:\University\Bachelor\Term 6\Database\Project\images\Coachs\Coach (55)' WHERE coach_id = 55;
UPDATE Coach
 SET coach_photo_url = 'D:\University\Bachelor\Term 6\Database\Project\images\Coachs\Coach (56)' WHERE coach_id = 56;
UPDATE Coach
 SET coach_photo_url = 'D:\University\Bachelor\Term 6\Database\Project\images\Coachs\Coach (57)' WHERE coach_id = 57;
UPDATE Coach
 SET coach_photo_url = 'D:\University\Bachelor\Term 6\Database\Project\images\Coachs\Coach (58)' WHERE coach_id = 58;
UPDATE Coach
 SET coach_photo_url = 'D:\University\Bachelor\Term 6\Database\Project\images\Coachs\Coach (59)' WHERE coach_id = 59;
UPDATE Coach
 SET coach_photo_url = 'D:\University\Bachelor\Term 6\Database\Project\images\Coachs\Coach (60)' WHERE coach_id = 60;
UPDATE Coach
 SET coach_photo_url = 'D:\University\Bachelor\Term 6\Database\Project\images\Coachs\Coach (61)' WHERE coach_id = 61;
UPDATE Coach
 SET coach_photo_url = 'D:\University\Bachelor\Term 6\Database\Project\images\Coachs\Coach (62)' WHERE coach_id = 62;
UPDATE Coach
 SET coach_photo_url = 'D:\University\Bachelor\Term 6\Database\Project\images\Coachs\Coach (63)' WHERE coach_id = 63;
UPDATE Coach
 SET coach_photo_url = 'D:\University\Bachelor\Term 6\Database\Project\images\Coachs\Coach (64)' WHERE coach_id = 64;
UPDATE Coach
 SET coach_photo_url = 'D:\University\Bachelor\Term 6\Database\Project\images\Coachs\Coach (65)' WHERE coach_id = 65;
UPDATE Coach
 SET coach_photo_url = 'D:\University\Bachelor\Term 6\Database\Project\images\Coachs\Coach (66)' WHERE coach_id = 66;
UPDATE Coach
 SET coach_photo_url = 'D:\University\Bachelor\Term 6\Database\Project\images\Coachs\Coach (67)' WHERE coach_id = 67;
UPDATE Coach
 SET coach_photo_url = 'D:\University\Bachelor\Term 6\Database\Project\images\Coachs\Coach (68)' WHERE coach_id = 68;
UPDATE Coach
 SET coach_photo_url = 'D:\University\Bachelor\Term 6\Database\Project\images\Coachs\Coach (69)' WHERE coach_id = 69;
UPDATE Coach
 SET coach_photo_url = 'D:\University\Bachelor\Term 6\Database\Project\images\Coachs\Coach (70)' WHERE coach_id = 70;
UPDATE Coach
 SET coach_photo_url = 'D:\University\Bachelor\Term 6\Database\Project\images\Coachs\Coach (71)' WHERE coach_id = 71;
UPDATE Coach
 SET coach_photo_url = 'D:\University\Bachelor\Term 6\Database\Project\images\Coachs\Coach (72)' WHERE coach_id = 72;
UPDATE Coach
 SET coach_photo_url = 'D:\University\Bachelor\Term 6\Database\Project\images\Coachs\Coach (73)' WHERE coach_id = 73;
UPDATE Coach
 SET coach_photo_url = 'D:\University\Bachelor\Term 6\Database\Project\images\Coachs\Coach (74)' WHERE coach_id = 74;
UPDATE Coach
 SET coach_photo_url = 'D:\University\Bachelor\Term 6\Database\Project\images\Coachs\Coach (75)' WHERE coach_id = 75;
UPDATE Coach
 SET coach_photo_url = 'D:\University\Bachelor\Term 6\Database\Project\images\Coachs\Coach (76)' WHERE coach_id = 76;
UPDATE Coach
 SET coach_photo_url = 'D:\University\Bachelor\Term 6\Database\Project\images\Coachs\Coach (77)' WHERE coach_id = 77;
UPDATE Coach
 SET coach_photo_url = 'D:\University\Bachelor\Term 6\Database\Project\images\Coachs\Coach (78)' WHERE coach_id = 78;
UPDATE Coach
 SET coach_photo_url = 'D:\University\Bachelor\Term 6\Database\Project\images\Coachs\Coach (79)' WHERE coach_id = 79;
UPDATE Coach
 SET coach_photo_url = 'D:\University\Bachelor\Term 6\Database\Project\images\Coachs\Coach (80)' WHERE coach_id = 80;
UPDATE Coach
 SET coach_photo_url = 'D:\University\Bachelor\Term 6\Database\Project\images\Coachs\Coach (81)' WHERE coach_id = 81;
UPDATE Coach
 SET coach_photo_url = 'D:\University\Bachelor\Term 6\Database\Project\images\Coachs\Coach (82)' WHERE coach_id = 82;
UPDATE Coach
 SET coach_photo_url = 'D:\University\Bachelor\Term 6\Database\Project\images\Coachs\Coach (83)' WHERE coach_id = 83;
UPDATE Coach
 SET coach_photo_url = 'D:\University\Bachelor\Term 6\Database\Project\images\Coachs\Coach (84)' WHERE coach_id = 84;
UPDATE Coach
 SET coach_photo_url = 'D:\University\Bachelor\Term 6\Database\Project\images\Coachs\Coach (85)' WHERE coach_id = 85;
UPDATE Coach
 SET coach_photo_url = 'D:\University\Bachelor\Term 6\Database\Project\images\Coachs\Coach (86)' WHERE coach_id = 86;
UPDATE Coach
 SET coach_photo_url = 'D:\University\Bachelor\Term 6\Database\Project\images\Coachs\Coach (87)' WHERE coach_id = 87;
UPDATE Coach
 SET coach_photo_url = 'D:\University\Bachelor\Term 6\Database\Project\images\Coachs\Coach (88)' WHERE coach_id = 88;
UPDATE Coach
 SET coach_photo_url = 'D:\University\Bachelor\Term 6\Database\Project\images\Coachs\Coach (89)' WHERE coach_id = 89;
UPDATE Coach
 SET coach_photo_url = 'D:\University\Bachelor\Term 6\Database\Project\images\Coachs\Coach (90)' WHERE coach_id = 90;
UPDATE Coach
 SET coach_photo_url = 'D:\University\Bachelor\Term 6\Database\Project\images\Coachs\Coach (91)' WHERE coach_id = 91;


UPDATE head_coach
SET head_coach_photo_url = 'D:\University\Bachelor\Term 6\Database\Project\images\Head Coachs\1' WHERE head_coach_id = 1;
UPDATE head_coach
SET head_coach_photo_url = 'D:\University\Bachelor\Term 6\Database\Project\images\Head Coachs\2' WHERE head_coach_id = 2;
UPDATE head_coach
SET head_coach_photo_url = 'D:\University\Bachelor\Term 6\Database\Project\images\Head Coachs\3' WHERE head_coach_id = 3;
UPDATE head_coach
SET head_coach_photo_url = 'D:\University\Bachelor\Term 6\Database\Project\images\Head Coachs\4' WHERE head_coach_id = 4;
UPDATE head_coach
SET head_coach_photo_url = 'D:\University\Bachelor\Term 6\Database\Project\images\Head Coachs\5' WHERE head_coach_id = 5;
UPDATE head_coach
SET head_coach_photo_url = 'D:\University\Bachelor\Term 6\Database\Project\images\Head Coachs\6' WHERE head_coach_id = 6;
UPDATE head_coach
SET head_coach_photo_url = 'D:\University\Bachelor\Term 6\Database\Project\images\Head Coachs\7' WHERE head_coach_id = 7;


UPDATE Player
SET player_photo_url = 'D:\University\Bachelor\Term 6\Database\Project\images\Players\Player  (1)' WHERE player_id = 1;
UPDATE Player
SET player_photo_url = 'D:\University\Bachelor\Term 6\Database\Project\images\Players\Player  (2)' WHERE player_id = 2;
UPDATE Player
SET player_photo_url = 'D:\University\Bachelor\Term 6\Database\Project\images\Players\Player  (3)' WHERE player_id = 3;
UPDATE Player
SET player_photo_url = 'D:\University\Bachelor\Term 6\Database\Project\images\Players\Player  (4)' WHERE player_id = 4;
UPDATE Player
SET player_photo_url = 'D:\University\Bachelor\Term 6\Database\Project\images\Players\Player  (5)' WHERE player_id = 5;
UPDATE Player
SET player_photo_url = 'D:\University\Bachelor\Term 6\Database\Project\images\Players\Player  (6)' WHERE player_id = 6;
UPDATE Player
SET player_photo_url = 'D:\University\Bachelor\Term 6\Database\Project\images\Players\Player  (7)' WHERE player_id = 7;
UPDATE Player
SET player_photo_url = 'D:\University\Bachelor\Term 6\Database\Project\images\Players\Player  (8)' WHERE player_id = 8;
UPDATE Player
SET player_photo_url = 'D:\University\Bachelor\Term 6\Database\Project\images\Players\Player  (9)' WHERE player_id = 9;
UPDATE Player
SET player_photo_url = 'D:\University\Bachelor\Term 6\Database\Project\images\Players\Player  (10)' WHERE player_id = 10;
UPDATE Player
SET player_photo_url = 'D:\University\Bachelor\Term 6\Database\Project\images\Players\Player  (11)' WHERE player_id = 11;
UPDATE Player
SET player_photo_url = 'D:\University\Bachelor\Term 6\Database\Project\images\Players\Player  (12)' WHERE player_id = 12;
UPDATE Player
SET player_photo_url = 'D:\University\Bachelor\Term 6\Database\Project\images\Players\Player  (13)' WHERE player_id = 13;
UPDATE Player
SET player_photo_url = 'D:\University\Bachelor\Term 6\Database\Project\images\Players\Player  (14)' WHERE player_id = 14;
UPDATE Player
SET player_photo_url = 'D:\University\Bachelor\Term 6\Database\Project\images\Players\Player  (15)' WHERE player_id = 15;
UPDATE Player
SET player_photo_url = 'D:\University\Bachelor\Term 6\Database\Project\images\Players\Player  (16)' WHERE player_id = 16;
UPDATE Player
SET player_photo_url = 'D:\University\Bachelor\Term 6\Database\Project\images\Players\Player  (17)' WHERE player_id = 17;
UPDATE Player
SET player_photo_url = 'D:\University\Bachelor\Term 6\Database\Project\images\Players\Player  (18)' WHERE player_id = 18;
UPDATE Player
SET player_photo_url = 'D:\University\Bachelor\Term 6\Database\Project\images\Players\Player  (19)' WHERE player_id = 19;
UPDATE Player
SET player_photo_url = 'D:\University\Bachelor\Term 6\Database\Project\images\Players\Player  (20)' WHERE player_id = 20;
UPDATE Player
SET player_photo_url = 'D:\University\Bachelor\Term 6\Database\Project\images\Players\Player  (21)' WHERE player_id = 21;
UPDATE Player
SET player_photo_url = 'D:\University\Bachelor\Term 6\Database\Project\images\Players\Player  (22)' WHERE player_id = 22;
UPDATE Player
SET player_photo_url = 'D:\University\Bachelor\Term 6\Database\Project\images\Players\Player  (23)' WHERE player_id = 23;
UPDATE Player
SET player_photo_url = 'D:\University\Bachelor\Term 6\Database\Project\images\Players\Player  (24)' WHERE player_id = 24;
UPDATE Player
SET player_photo_url = 'D:\University\Bachelor\Term 6\Database\Project\images\Players\Player  (25)' WHERE player_id = 25;
UPDATE Player
SET player_photo_url = 'D:\University\Bachelor\Term 6\Database\Project\images\Players\Player  (26)' WHERE player_id = 26;
UPDATE Player
SET player_photo_url = 'D:\University\Bachelor\Term 6\Database\Project\images\Players\Player  (27)' WHERE player_id = 27;
UPDATE Player
SET player_photo_url = 'D:\University\Bachelor\Term 6\Database\Project\images\Players\Player  (28)' WHERE player_id = 28;
UPDATE Player
SET player_photo_url = 'D:\University\Bachelor\Term 6\Database\Project\images\Players\Player  (29)' WHERE player_id = 29;
UPDATE Player
SET player_photo_url = 'D:\University\Bachelor\Term 6\Database\Project\images\Players\Player  (30)' WHERE player_id = 30;
UPDATE Player
SET player_photo_url = 'D:\University\Bachelor\Term 6\Database\Project\images\Players\Player  (31)' WHERE player_id = 31;
UPDATE Player
SET player_photo_url = 'D:\University\Bachelor\Term 6\Database\Project\images\Players\Player  (32)' WHERE player_id = 32;
UPDATE Player
SET player_photo_url = 'D:\University\Bachelor\Term 6\Database\Project\images\Players\Player  (33)' WHERE player_id = 33;
UPDATE Player
SET player_photo_url = 'D:\University\Bachelor\Term 6\Database\Project\images\Players\Player  (34)' WHERE player_id = 34;
UPDATE Player
SET player_photo_url = 'D:\University\Bachelor\Term 6\Database\Project\images\Players\Player  (35)' WHERE player_id = 35;
UPDATE Player
SET player_photo_url = 'D:\University\Bachelor\Term 6\Database\Project\images\Players\Player  (36)' WHERE player_id = 36;
UPDATE Player
SET player_photo_url = 'D:\University\Bachelor\Term 6\Database\Project\images\Players\Player  (37)' WHERE player_id = 37;
UPDATE Player
SET player_photo_url = 'D:\University\Bachelor\Term 6\Database\Project\images\Players\Player  (38)' WHERE player_id = 38;
UPDATE Player
SET player_photo_url = 'D:\University\Bachelor\Term 6\Database\Project\images\Players\Player  (39)' WHERE player_id = 39;
UPDATE Player
SET player_photo_url = 'D:\University\Bachelor\Term 6\Database\Project\images\Players\Player  (40)' WHERE player_id = 40;
UPDATE Player
SET player_photo_url = 'D:\University\Bachelor\Term 6\Database\Project\images\Players\Player  (41)' WHERE player_id = 41;
UPDATE Player
SET player_photo_url = 'D:\University\Bachelor\Term 6\Database\Project\images\Players\Player  (42)' WHERE player_id = 42;
UPDATE Player
SET player_photo_url = 'D:\University\Bachelor\Term 6\Database\Project\images\Players\Player  (43)' WHERE player_id = 43;
UPDATE Player
SET player_photo_url = 'D:\University\Bachelor\Term 6\Database\Project\images\Players\Player  (44)' WHERE player_id = 44;
UPDATE Player
SET player_photo_url = 'D:\University\Bachelor\Term 6\Database\Project\images\Players\Player  (45)' WHERE player_id = 45;
UPDATE Player
SET player_photo_url = 'D:\University\Bachelor\Term 6\Database\Project\images\Players\Player  (46)' WHERE player_id = 46;
UPDATE Player
SET player_photo_url = 'D:\University\Bachelor\Term 6\Database\Project\images\Players\Player  (47)' WHERE player_id = 47;
UPDATE Player
SET player_photo_url = 'D:\University\Bachelor\Term 6\Database\Project\images\Players\Player  (48)' WHERE player_id = 48;
UPDATE Player
SET player_photo_url = 'D:\University\Bachelor\Term 6\Database\Project\images\Players\Player  (49)' WHERE player_id = 49;
UPDATE Player
SET player_photo_url = 'D:\University\Bachelor\Term 6\Database\Project\images\Players\Player  (50)' WHERE player_id = 50;
UPDATE Player
SET player_photo_url = 'D:\University\Bachelor\Term 6\Database\Project\images\Players\Player  (51)' WHERE player_id = 51;
UPDATE Player
SET player_photo_url = 'D:\University\Bachelor\Term 6\Database\Project\images\Players\Player  (52)' WHERE player_id = 52;
UPDATE Player
SET player_photo_url = 'D:\University\Bachelor\Term 6\Database\Project\images\Players\Player  (53)' WHERE player_id = 53;
UPDATE Player
SET player_photo_url = 'D:\University\Bachelor\Term 6\Database\Project\images\Players\Player  (54)' WHERE player_id = 54;
UPDATE Player
SET player_photo_url = 'D:\University\Bachelor\Term 6\Database\Project\images\Players\Player  (55)' WHERE player_id = 55;
UPDATE Player
SET player_photo_url = 'D:\University\Bachelor\Term 6\Database\Project\images\Players\Player  (56)' WHERE player_id = 56;
UPDATE Player
SET player_photo_url = 'D:\University\Bachelor\Term 6\Database\Project\images\Players\Player  (57)' WHERE player_id = 57;
UPDATE Player
SET player_photo_url = 'D:\University\Bachelor\Term 6\Database\Project\images\Players\Player  (58)' WHERE player_id = 58;
UPDATE Player
SET player_photo_url = 'D:\University\Bachelor\Term 6\Database\Project\images\Players\Player  (59)' WHERE player_id = 59;
UPDATE Player
SET player_photo_url = 'D:\University\Bachelor\Term 6\Database\Project\images\Players\Player  (60)' WHERE player_id = 60;
UPDATE Player
SET player_photo_url = 'D:\University\Bachelor\Term 6\Database\Project\images\Players\Player  (61)' WHERE player_id = 61;
UPDATE Player
SET player_photo_url = 'D:\University\Bachelor\Term 6\Database\Project\images\Players\Player  (62)' WHERE player_id = 62;
UPDATE Player
SET player_photo_url = 'D:\University\Bachelor\Term 6\Database\Project\images\Players\Player  (63)' WHERE player_id = 63;
UPDATE Player
SET player_photo_url = 'D:\University\Bachelor\Term 6\Database\Project\images\Players\Player  (64)' WHERE player_id = 64;
UPDATE Player
SET player_photo_url = 'D:\University\Bachelor\Term 6\Database\Project\images\Players\Player  (65)' WHERE player_id = 65;
UPDATE Player
SET player_photo_url = 'D:\University\Bachelor\Term 6\Database\Project\images\Players\Player  (66)' WHERE player_id = 66;
UPDATE Player
SET player_photo_url = 'D:\University\Bachelor\Term 6\Database\Project\images\Players\Player  (67)' WHERE player_id = 67;
UPDATE Player
SET player_photo_url = 'D:\University\Bachelor\Term 6\Database\Project\images\Players\Player  (68)' WHERE player_id = 68;
UPDATE Player
SET player_photo_url = 'D:\University\Bachelor\Term 6\Database\Project\images\Players\Player  (69)' WHERE player_id = 69;
UPDATE Player
SET player_photo_url = 'D:\University\Bachelor\Term 6\Database\Project\images\Players\Player  (70)' WHERE player_id = 70;
UPDATE Player
SET player_photo_url = 'D:\University\Bachelor\Term 6\Database\Project\images\Players\Player  (71)' WHERE player_id = 71;
UPDATE Player
SET player_photo_url = 'D:\University\Bachelor\Term 6\Database\Project\images\Players\Player  (72)' WHERE player_id = 72;
UPDATE Player
SET player_photo_url = 'D:\University\Bachelor\Term 6\Database\Project\images\Players\Player  (73)' WHERE player_id = 73;
UPDATE Player
SET player_photo_url = 'D:\University\Bachelor\Term 6\Database\Project\images\Players\Player  (74)' WHERE player_id = 74;
UPDATE Player
SET player_photo_url = 'D:\University\Bachelor\Term 6\Database\Project\images\Players\Player  (75)' WHERE player_id = 75;
UPDATE Player
SET player_photo_url = 'D:\University\Bachelor\Term 6\Database\Project\images\Players\Player  (76)' WHERE player_id = 76;
UPDATE Player
SET player_photo_url = 'D:\University\Bachelor\Term 6\Database\Project\images\Players\Player  (77)' WHERE player_id = 77;
UPDATE Player
SET player_photo_url = 'D:\University\Bachelor\Term 6\Database\Project\images\Players\Player  (78)' WHERE player_id = 78;
UPDATE Player
SET player_photo_url = 'D:\University\Bachelor\Term 6\Database\Project\images\Players\Player  (79)' WHERE player_id = 79;
UPDATE Player
SET player_photo_url = 'D:\University\Bachelor\Term 6\Database\Project\images\Players\Player  (80)' WHERE player_id = 80;
UPDATE Player
SET player_photo_url = 'D:\University\Bachelor\Term 6\Database\Project\images\Players\Player  (81)' WHERE player_id = 81;
UPDATE Player
SET player_photo_url = 'D:\University\Bachelor\Term 6\Database\Project\images\Players\Player  (82)' WHERE player_id = 82;
UPDATE Player
SET player_photo_url = 'D:\University\Bachelor\Term 6\Database\Project\images\Players\Player  (83)' WHERE player_id = 83;
UPDATE Player
SET player_photo_url = 'D:\University\Bachelor\Term 6\Database\Project\images\Players\Player  (84)' WHERE player_id = 84;
UPDATE Player
SET player_photo_url = 'D:\University\Bachelor\Term 6\Database\Project\images\Players\Player  (85)' WHERE player_id = 85;
UPDATE Player
SET player_photo_url = 'D:\University\Bachelor\Term 6\Database\Project\images\Players\Player  (86)' WHERE player_id = 86;
UPDATE Player
SET player_photo_url = 'D:\University\Bachelor\Term 6\Database\Project\images\Players\Player  (87)' WHERE player_id = 87;
UPDATE Player
SET player_photo_url = 'D:\University\Bachelor\Term 6\Database\Project\images\Players\Player  (88)' WHERE player_id = 88;
UPDATE Player
SET player_photo_url = 'D:\University\Bachelor\Term 6\Database\Project\images\Players\Player  (89)' WHERE player_id = 89;
UPDATE Player
SET player_photo_url = 'D:\University\Bachelor\Term 6\Database\Project\images\Players\Player  (90)' WHERE player_id = 90;
UPDATE Player
SET player_photo_url = 'D:\University\Bachelor\Term 6\Database\Project\images\Players\Player  (91)' WHERE player_id = 91;
UPDATE Player
SET player_photo_url = 'D:\University\Bachelor\Term 6\Database\Project\images\Players\Player  (92)' WHERE player_id = 92;
UPDATE Player
SET player_photo_url = 'D:\University\Bachelor\Term 6\Database\Project\images\Players\Player  (93)' WHERE player_id = 93;
UPDATE Player
SET player_photo_url = 'D:\University\Bachelor\Term 6\Database\Project\images\Players\Player  (94)' WHERE player_id = 94;
UPDATE Player
SET player_photo_url = 'D:\University\Bachelor\Term 6\Database\Project\images\Players\Player  (95)' WHERE player_id = 95;
UPDATE Player
SET player_photo_url = 'D:\University\Bachelor\Term 6\Database\Project\images\Players\Player  (96)' WHERE player_id = 96;
UPDATE Player
SET player_photo_url = 'D:\University\Bachelor\Term 6\Database\Project\images\Players\Player  (97)' WHERE player_id = 97;
UPDATE Player
SET player_photo_url = 'D:\University\Bachelor\Term 6\Database\Project\images\Players\Player  (98)' WHERE player_id = 98;
UPDATE Player
SET player_photo_url = 'D:\University\Bachelor\Term 6\Database\Project\images\Players\Player  (99)' WHERE player_id = 99;
UPDATE Player
SET player_photo_url = 'D:\University\Bachelor\Term 6\Database\Project\images\Players\Player  (100)' WHERE player_id = 100;
UPDATE Player
SET player_photo_url = 'D:\University\Bachelor\Term 6\Database\Project\images\Players\Player  (101)' WHERE player_id = 101;
UPDATE Player
SET player_photo_url = 'D:\University\Bachelor\Term 6\Database\Project\images\Players\Player  (102)' WHERE player_id = 102;
UPDATE Player
SET player_photo_url = 'D:\University\Bachelor\Term 6\Database\Project\images\Players\Player  (103)' WHERE player_id = 103;
UPDATE Player
SET player_photo_url = 'D:\University\Bachelor\Term 6\Database\Project\images\Players\Player  (104)' WHERE player_id = 104;
UPDATE Player
SET player_photo_url = 'D:\University\Bachelor\Term 6\Database\Project\images\Players\Player  (105)' WHERE player_id = 105;
UPDATE Player
SET player_photo_url = 'D:\University\Bachelor\Term 6\Database\Project\images\Players\Player  (106)' WHERE player_id = 106;
UPDATE Player
SET player_photo_url = 'D:\University\Bachelor\Term 6\Database\Project\images\Players\Player  (107)' WHERE player_id = 107;
UPDATE Player
SET player_photo_url = 'D:\University\Bachelor\Term 6\Database\Project\images\Players\Player  (108)' WHERE player_id = 108;
UPDATE Player
SET player_photo_url = 'D:\University\Bachelor\Term 6\Database\Project\images\Players\Player  (109)' WHERE player_id = 109;
UPDATE Player
SET player_photo_url = 'D:\University\Bachelor\Term 6\Database\Project\images\Players\Player  (110)' WHERE player_id = 110;
UPDATE Player
SET player_photo_url = 'D:\University\Bachelor\Term 6\Database\Project\images\Players\Player  (111)' WHERE player_id = 111;
UPDATE Player
SET player_photo_url = 'D:\University\Bachelor\Term 6\Database\Project\images\Players\Player  (112)' WHERE player_id = 112;
UPDATE Player
SET player_photo_url = 'D:\University\Bachelor\Term 6\Database\Project\images\Players\Player  (113)' WHERE player_id = 113;
UPDATE Player
SET player_photo_url = 'D:\University\Bachelor\Term 6\Database\Project\images\Players\Player  (114)' WHERE player_id = 114;
UPDATE Player
SET player_photo_url = 'D:\University\Bachelor\Term 6\Database\Project\images\Players\Player  (115)' WHERE player_id = 115;
UPDATE Player
SET player_photo_url = 'D:\University\Bachelor\Term 6\Database\Project\images\Players\Player  (116)' WHERE player_id = 116;
UPDATE Player
SET player_photo_url = 'D:\University\Bachelor\Term 6\Database\Project\images\Players\Player  (117)' WHERE player_id = 117;
UPDATE Player
SET player_photo_url = 'D:\University\Bachelor\Term 6\Database\Project\images\Players\Player  (118)' WHERE player_id = 118;
UPDATE Player
SET player_photo_url = 'D:\University\Bachelor\Term 6\Database\Project\images\Players\Player  (119)' WHERE player_id = 119;
UPDATE Player
SET player_photo_url = 'D:\University\Bachelor\Term 6\Database\Project\images\Players\Player  (120)' WHERE player_id = 120;
UPDATE Player
SET player_photo_url = 'D:\University\Bachelor\Term 6\Database\Project\images\Players\Player  (121)' WHERE player_id = 121;
UPDATE Player
SET player_photo_url = 'D:\University\Bachelor\Term 6\Database\Project\images\Players\Player  (122)' WHERE player_id = 122;
UPDATE Player
SET player_photo_url = 'D:\University\Bachelor\Term 6\Database\Project\images\Players\Player  (123)' WHERE player_id = 123;
UPDATE Player
SET player_photo_url = 'D:\University\Bachelor\Term 6\Database\Project\images\Players\Player  (124)' WHERE player_id = 124;
UPDATE Player
SET player_photo_url = 'D:\University\Bachelor\Term 6\Database\Project\images\Players\Player  (125)' WHERE player_id = 125;
UPDATE Player
SET player_photo_url = 'D:\University\Bachelor\Term 6\Database\Project\images\Players\Player  (126)' WHERE player_id = 126;
UPDATE Player
SET player_photo_url = 'D:\University\Bachelor\Term 6\Database\Project\images\Players\Player  (127)' WHERE player_id = 127;
UPDATE Player
SET player_photo_url = 'D:\University\Bachelor\Term 6\Database\Project\images\Players\Player  (128)' WHERE player_id = 128;
UPDATE Player
SET player_photo_url = 'D:\University\Bachelor\Term 6\Database\Project\images\Players\Player  (129)' WHERE player_id = 129;
UPDATE Player
SET player_photo_url = 'D:\University\Bachelor\Term 6\Database\Project\images\Players\Player  (130)' WHERE player_id = 130;
UPDATE Player
SET player_photo_url = 'D:\University\Bachelor\Term 6\Database\Project\images\Players\Player  (131)' WHERE player_id = 131;
UPDATE Player
SET player_photo_url = 'D:\University\Bachelor\Term 6\Database\Project\images\Players\Player  (132)' WHERE player_id = 132;
UPDATE Player
SET player_photo_url = 'D:\University\Bachelor\Term 6\Database\Project\images\Players\Player  (133)' WHERE player_id = 133;
UPDATE Player
SET player_photo_url = 'D:\University\Bachelor\Term 6\Database\Project\images\Players\Player  (134)' WHERE player_id = 134;
UPDATE Player
SET player_photo_url = 'D:\University\Bachelor\Term 6\Database\Project\images\Players\Player  (135)' WHERE player_id = 135;
UPDATE Player
SET player_photo_url = 'D:\University\Bachelor\Term 6\Database\Project\images\Players\Player  (136)' WHERE player_id = 136;
UPDATE Player
SET player_photo_url = 'D:\University\Bachelor\Term 6\Database\Project\images\Players\Player  (137)' WHERE player_id = 137;
UPDATE Player
SET player_photo_url = 'D:\University\Bachelor\Term 6\Database\Project\images\Players\Player  (138)' WHERE player_id = 138;
UPDATE Player
SET player_photo_url = 'D:\University\Bachelor\Term 6\Database\Project\images\Players\Player  (139)' WHERE player_id = 139;
UPDATE Player
SET player_photo_url = 'D:\University\Bachelor\Term 6\Database\Project\images\Players\Player  (140)' WHERE player_id = 140;
-------------------------------------------------------------------------- Ready Queries --------------------------------------------------------------------------

-- Best Strikers
select TOP 10 player_id, first_name, last_name, goals_number
from Player
order by goals_number desc;

 -- Best Assists
select TOP 10 player_id, first_name, last_name, asists_numbers
from Player
order by asists_numbers desc;

-- Best Attack lines
select Top 5 team_id, team_name, GF
from Team
order by GF desc;

-- Best Deffence lines
select Top 5 team_id, team_name, GA
from Team
order by GA asc;

-- Best Goal Keepers
select TOP 3 p.first_name, p.last_name, gk.clean_sheets_number
from Goal_Keeper as gk
join Player as p on gk.player_id = p.player_id
order by gk.clean_sheets_number desc

-- The most expensive players
select TOP 10 player_id, first_name, last_name, market_value
from Player
order by market_value desc;

-- The best players (According to G/A)
select TOP 10 player_id, first_name, last_name, (goals_number + asists_numbers) as 'G/A'
from Player
order by 'G/A' desc;

-- Number of games played by players (Desc)
select p.player_id, p.first_name, p.last_name , count(p.player_id) as game_played
from Player as p
join Player_Match_Participation as pmp on pmp.player_id = p.player_id
group by p.player_id,p.first_name, p.last_name
order by game_played desc

-- Players with the most red cards
select p.player_id, p.first_name, p.last_name , count(p.player_id) as red_card_numbers
from Player as p
join Card_Received_in_Match as crm on crm.player_id = p.player_id
where crm.card_type = 'red'
group by p.player_id,p.first_name, p.last_name
order by red_card_numbers desc

-- Players with the most yellow cards
select p.player_id, p.first_name, p.last_name , count(p.player_id) as yellow_card_numbers
from Player as p
join Card_Received_in_Match as crm on crm.player_id = p.player_id
where crm.card_type = 'yellow'
group by p.player_id,p.first_name, p.last_name
order by yellow_card_numbers desc

-- Team With the most wins
select team_id , team_name, Wins
from Team
order by Wins desc

-- Team With the most draws
select team_id , team_name, Draws
from Team
order by Draws desc

-- Team With the most Losts
select team_id , team_name, Losts
from Team
order by Losts desc

-- The best players (According to avg of player's metrica score)
select p.player_id, p.first_name, p.last_name , avg(pmp.player_metrica_score) as metrica_score_avg
from Player as p
join Player_Match_Participation as pmp on pmp.player_id = p.player_id
group by p.player_id,p.first_name, p.last_name
order by metrica_score_avg desc

-- Players with the most minutes game played
select p.player_id, p.first_name, p.last_name , (sum(pmp.minute_out) - sum(pmp.minute_in)) as minute_played
from Player as p
join Player_Match_Participation as pmp on pmp.player_id = p.player_id
group by p.player_id,p.first_name, p.last_name
order by minute_played desc
