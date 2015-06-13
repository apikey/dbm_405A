-- show all players
DELIMITER ;;
CREATE PROCEDURE selectPlayers()
BEGIN
    SELECT * FROM hockey.players;
END;
;;
DELIMITER ;

-- show all teams
DELIMITER ;;
CREATE PROCEDURE all_teams()
BEGIN
    SELECT * FROM hockey.all_teams;
END;
;;
DELIMITER ;

-- select player by id
DELIMITER ;;
CREATE PROCEDURE player(IN p_player_id INTEGER)
BEGIN
    SELECT * FROM hockey.players WHERE player_id = p_player_id;
END;
;;
DELIMITER ;

-- print 10 times 'Hello, ' <your_text_here>
DELIMITER ;;
CREATE PROCEDURE hello( IN inputText VARCHAR(255) )
BLOCK_1: BEGIN
	DECLARE iterator INTEGER DEFAULT 0;
	REPEAT 
		SELECT CONCAT('Hello, ', inputText, '!' );  
        SET iterator = iterator + 1; 
	UNTIL iterator > 10
    END REPEAT;
END;
;;
DELIMITER ;

-- CREATE A STORE PROCEDURE TO UPDATE THE home_team_score AND THE
-- away_team_score FOR THE CURRENT RECORD EVERY TIME THE PROCEDURE IS CALLED.
DELIMITER ;;
CREATE PROCEDURE updateScores(IN homeScore INTEGER, IN awayScore INTEGER, IN p_season INTEGER, IN p_play_date DATE)
BEGIN
    UPDATE baseball.season
    SET home_team_score = homeScore, away_team_score = awayScore
    WHERE season = p_season AND play_date = p_play_date;
END;
;;
DELIMITER ;


-- create a procedure that makes use of a cursor
-- DECLARE CURSOR
-- OPEN CURSOR
-- FETCH CURSOR
-- CLOSE CURSOR
DELIMITER ;;
CREATE PROCEDURE hockey.listPlayerFirstNames (OUT p_firstName VARCHAR(255))
BEGIN
    DECLARE FOUND BOOLEAN DEFAULT TRUE;
    DECLARE names VARCHAR(255) DEFAULT 'NO TEXT';
    DECLARE cursor_firstName CURSOR FOR SELECT players.player_firstname FROM hockey.players;
    DECLARE CONTINUE HANDLER FOR NOT FOUND
        SET FOUND = FALSE;
    SET p_firstName = '';
    
    OPEN cursor_firstName;
    
    FETCH cursor_firstName INTO names;
    
    WHILE FOUND DO
        p_firstName = CONCAT(p_firstName, ' ', names);
        FETCH cursor_firstName INTO names;
    END WHILE;
    CLOSE cursor_firstName;
END;
;;
DELIMITER ;


-- check if a value is greater or less than 50 but not greater than 100
DELIMITER ;;
CREATE PROCEDURE glt50 (IN p_value INTEGER)
BEGIN
DECLARE aValue INTEGER;
SET aValue = p_value;
    CASE
        WHEN aValue < 50 THEN 
            BEGIN
                SELECT CONCAT(aValue, ' is less than 50') "Less Than";
            END;
        WHEN aValue > 50 THEN 
            BEGIN
                SELECT CONCAT(avalue, ' is greater than 50') "Greater Than";
            END;
        WHEN aValue > 100 THEN 
            BEGIN
                SELECT "The value needs to be less than or equal to 100" "Too Big";
            END;
        WHEN aValue < 0 THEN 
            BEGIN
                SELECT "The value needs to be 0 or greater" "Too Little";
            END;
         WHEN aValue = 50 THEN
            BEGIN
                SELECT CONCAT(aValue, ' is equal to 50') "Equal To";
            END; 
    END CASE;
END;
;;
DELIMITER ;

-- increment numbers to 10
DELIMITER ;;
CREATE PROCEDURE incrementNumber(OUT a_number INTEGER)
FIRST_1: BEGIN
    SET a_number = 1;
    MY_LOOP:LOOP 
        SECOND_2: BEGIN
            SELECT a_number;
        END SECOND_2;
        SET a_number = a_number + 1;
        IF a_number > 10 THEN
            LEAVE FIRST_1;
        END IF;
    END LOOP MY_LOOP;
END FIRST_1;
;;
DELIMITER ;





































