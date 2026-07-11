import random
goal_types = ["Inside Box Shot"," Outside Box Shot", "Header", "Penalty","Free Kick", "Rebound", "One-Touch Finish", "Dribble Past Goalkeeper","Goal from Corner", "Counter-Attack Goal"]
goals = [[1, 1 ,2 , 4, 3],
         [2,2,1,2,2],
         [3,1,3,3,1],
         [4,3,1,4,0],
         [5,1,4,4,1],
         [6,4,1,1,3],
         [7,1,5,3,4],
         [8,5,1,0,3],
         [9,1,6,4,1],
         [10,6,1,1,3],
         [11,2,3,2,4],
         [12,3,2,3,0],
         [13,2,4,0,0],
         [14,4,2,4,1],
         [15,2,5,2,0],
         [16,5,2,3,3],
         [17,2,6,2,2],
         [18,6,2,3,1],
         [19,3,4,0,4],
         [20,4,3,4,4],
         [21,3,5,3,2],
         [22,5,3,0,1],
         [23,3,6,0,1],
         [24,6,3,4,3],
         [25,4,5,0,1],
         [26,5,4,3,2],
         [27,4,6,0,3],
         [28,6,4,3,0],
         [29,5,6,4,4],
         [30,6,5,4,2],
         [31,7,1,3,0],
         [32,1,7,0,4],
         [33,7,2,4,2],
         [34,2,7,0,4],
         [35,7,3,3,0],
         [36,3,7,0,5],
         [37,7,4,5,0],
         [38,4,7,2,5],
         [39,7,5,3,1],
         [40,5,7,2,3],
         [41,7,6,4,0],
         [42,6,7,2,6]]

yellow_cards = [[1,1,2,4,2],
         [2,2,1,2,3],
         [3,1,3,3,0],
         [4,3,1,0,1],
         [5,1,4,1,2],
         [6,4,1,2,2],
         [7,1,5,2,2],
         [8,5,1,3,3],
         [9,1,6,0,0],
         [10,6,1,1,1],
         [11,2,3,1,2],
         [12,3,2,4,1],
         [13,2,4,0,0],
         [14,4,2,4,2],
         [15,2,5,0,0],
         [16,5,2,2,3],
         [17,2,6,1,1],
         [18,6,2,3,1],
         [19,3,4,0,0],
         [20,4,3,1,0],
         [21,3,5,2,4],
         [22,5,3,2,1],
         [23,3,6,1,4],
         [24,6,3,2,3],
         [25,4,5,2,3],
         [26,5,4,4,0],
         [27,4,6,1,1],
         [28,6,4,2,2],
         [29,5,6,2,4],
         [30,6,5,3,4],
         [31,7,1,1,1],
         [32,1,7,2,1],
         [33,7,2,1,2],
         [34,2,7,2,1],
         [35,7,3,2,1],
         [36,3,7,1,2],
         [37,7,4,1,2],
         [38,4,7,2,1],
         [39,7,5,1,2],
         [40,5,7,2,1],
         [41,7,6,1,2],
         [42,6,7,2,1]]

red_cards = [[1,1,2,1,1],
         [2,2,1,0,0],
         [3,1,3,0,0],
         [4,3,1,1,0],
         [5,1,4,1,0],
         [6,4,1,1,0],
         [7,1,5,0,0],
         [8,5,1,0,0],
         [9,1,6,1,0],
         [10,6,1,1,0],
         [11,2,3,0,0],
         [12,3,2,0,0],
         [13,2,4,0,0],
         [14,4,2,0,0],
         [15,2,5,0,0],
         [16,5,2,0,1],
         [17,2,6,1,0],
         [18,6,2,1,0],
         [19,3,4,1,0],
         [20,4,3,0,0],
         [21,3,5,1,0],
         [22,5,3,0,0],
         [23,3,6,1,0],
         [24,6,3,1,1],
         [25,4,5,0,1],
         [26,5,4,0,0],
         [27,4,6,0,1],
         [28,6,4,0,0],
         [29,5,6,1,1],
         [30,6,5,1,0],
         [31,7,1,0,0],
         [32,1,7,0,0],
         [33,7,2,0,0],
         [34,2,7,0,0],
         [35,7,3,0,0],
         [36,3,7,0,0],
         [37,7,4,0,0],
         [38,4,7,0,0],
         [39,7,5,0,0],
         [40,5,7,0,0],
         [41,7,6,0,0],
         [42,6,7,0,0]]

games = [[1,1,2,],
         [2,2,1,],
         [3,1,3,],
         [4,3,1,],
         [5,1,4,],
         [6,4,1,],
         [7,1,5,],
         [8,5,1,],
         [9,1,6,],
         [10,6,1,],
         [11,2,3,],
         [12,3,2,],
         [13,2,4,],
         [14,4,2,],
         [15,2,5,],
         [16,5,2,],
         [17,2,6,],
         [18,6,2,],
         [19,3,4,],
         [20,4,3,],
         [21,3,5,],
         [22,5,3,],
         [23,3,6,],
         [24,6,3,],
         [25,4,5,],
         [26,5,4,],
         [27,4,6,],
         [28,6,4,],
         [29,5,6,],
         [30,6,5,],
         [31,7,1,],
         [32,1,7,],
         [33,7,2,],
         [34,2,7,],
         [35,7,3,],
         [36,3,7,],
         [37,7,4,],
         [38,4,7,],
         [39,7,5,],
         [40,5,7,],
         [41,7,6,],
         [42,6,7,]]

def first(team_id):
    if team_id == 1:
        return 1
    if team_id == 2:
        return 21
    if team_id == 3:
        return 41
    if team_id == 4:
        return 61
    if team_id == 5:
        return 81
    if team_id == 6:
        return 101
    if team_id == 7:
        return 121
    
def second(team_id):
    if team_id == 1:
        return 20
    if team_id == 2:
        return 40
    if team_id == 3:
        return 60
    if team_id == 4:
        return 80
    if team_id == 5:
        return 100
    if team_id == 6:
        return 120
    if team_id == 7:
        return 140
    
# queries = []
# for i in goals:
#     for j in range(i[3]):
#         queries.append(f"INSERT INTO Scored_Goal_in_Match VALUES({i[0]},{i[1]}, {random.randint(first(i[1]), second(i[1]))}, {random.randint(1,97)}, {random.randint(first(i[1]), second(i[1]))},'{random.choice(goal_types)}', 0);")
#     for t in range(i[4]):
#         queries.append(f"INSERT INTO Scored_Goal_in_Match VALUES({i[0]},{i[2]}, {random.randint(first(i[2]), second(i[2]))}, {random.randint(1,97)}, {random.randint(first(i[2]), second(i[2]))},'{random.choice(goal_types)}', 0);")

# refree_queries = []
# refree_roles = ["main", "asist"]
# for i in range(1,43):
#     for j in range(4):
#         refree_queries.append(f"INSERT INTO Referee_Per_Match VALUES({i},{random.randint(1,20)},'{random.choice(refree_roles)}');")

# red_cards_queries = []
# for i in red_cards:
#     print(f"-- Match {i[0]}")
#     for j in range(i[3]):
#         red_cards_queries.append(f"INSERT INTO Card_Received_in_Match VALUES({i[0]},{i[1]}, {random.randint(first(i[1]), second(i[1]))}, {random.randint(1,97)}, {random.randint(first(i[1]), second(i[1]))},'{random.choice(goal_types)}', 0);")
#     for t in range(i[4]):
#         red_cards_queries.append(f"INSERT INTO Card_Received_in_Match VALUES({i[0]},{i[2]}, {random.randint(first(i[2]), second(i[2]))}, {random.randint(1,97)}, {random.randint(first(i[2]), second(i[2]))},'{random.choice(goal_types)}', 0);")
# yellow_cards_queries = []
# for i in yellow_cards:
#     print(f"-- Match {i[0]}")
#     for j in range(i[3]):
#         yellow_cards_queries.append(f"INSERT INTO Card_Received_in_Match VALUES({i[0]},{i[1]}, {random.randint(first(i[1]), second(i[1]))}, {random.randint(1,97)}, {random.randint(first(i[1]), second(i[1]))},'{random.choice(goal_types)}', 0);")
#     for t in range(i[4]):
#         yellow_cards_queries.append(f"INSERT INTO Card_Received_in_Match VALUES({i[0]},{i[2]}, {random.randint(first(i[2]), second(i[2]))}, {random.randint(1,97)}, {random.randint(first(i[2]), second(i[2]))},'{random.choice(goal_types)}', 0);")

positions = ["CAM", "CB", "CDM", "CM", "GK", "LB", "LW", "RB", "RW", "ST"]
games_queries = []
for i in games:
    print(f"-- Match {i[0]}")
    for j in range(11):
        # games_queries.append(f"INSERT INTO Card_Received_in_Match VALUES({i[0]},{i[1]}, {random.randint(first(i[1]), second(i[1]))}, NULL, 1 , 0 ,{random.randint(1,97)}, 100,{random.uniform(5.5, 10)} );")
        print(f"INSERT INTO Player_Match_Participation VALUES({i[0]},{i[1]}, {random.randint(first(i[1]), second(i[1]))}, NULL, 1 , 0 ,{random.randint(1,97)}, 100,{round(random.uniform(5.5, 10), 1)});")
    for t in range(11):
        # games_queries.append(f"INSERT INTO Card_Received_in_Match VALUES({i[0]},{i[2]}, {random.randint(first(i[1]), second(i[1]))}, NULL, 1 , 0 ,{random.randint(1,97)}, 100,{random.uniform(5.5, 10)} );")
        print(f"INSERT INTO Player_Match_Participation VALUES({i[0]},{i[2]}, {random.randint(first(i[2]), second(i[2]))}, NULL, 1 , 0 ,{random.randint(1,97)}, 100,{round(random.uniform(5.5, 10), 1)});")

for i in range(2, 121):
    print(f"UPDATE Player \nSET player_photo_url = 'D:\\University\\Bachelor\\Term 6\\Database\\Project\\images\\Players\\Player ({i})' WHERE player_id = {i};")
