-- Set up an event to back up your database at midnight every Friday night.
DELIMITER ;;
CREATE EVENT BACKUP_EVERY_FRIDAY
    ON SCHEDULE EVERY 1 WEEK
        STARTS TIMESTAMP(CASE DAYNAME(NOW())
            WHEN 'Friday' THEN NOW()
            WHEN 'Saturday' THEN NOW() + INTERVAL 6 DAY
            WHEN 'Sunday' THEN NOW() + INTERVAL 5 DAY
            WHEN 'Monday' THEN NOW() + INTERVAL 4 DAY
            WHEN 'Tuesday' THEN NOW() + INTERVAL 3 DAY
            WHEN 'Wednesday' THEN NOW() + INTERVAL 2 DAY
            WHEN 'Thursday' THEN NOW() + INTERVAL 1 DAY
            END, '00:00:00')
        DO
        BEGIN
            SELECT * INTO OUTFILE 'current_schedule.csv'
            FROM baseball.current_schedule;
            
            SELECT * INTO OUTFILE 'pastseasons.csv'
            FROM baseball.pastseasons;
            
            SELECT * INTO OUTFILE 'player_team.csv'
            FROM baseball.player_team;
            
            SELECT * INTO OUTFILE 'players.csv'
            FROM baseball.players;
            
            SELECT * INTO OUTFILE 'season.csv'
            FROM baseball.season;
            
            SELECT * INTO OUTFILE 'teams.csv'
            FROM baseball.season;
        END;
;;
DELIMITER ;

-- output player table to a csv file when event is created
DELIMITER ;;
CREATE EVENT outfile_players
    ON SCHEDULE AT NOW()
    DO
    SELECT * INTO OUTFILE 'players.csv'
    FROM hockey.players;
;;
DELIMITER ;
