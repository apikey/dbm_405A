
-- trigger on insert into player_shoots column
CREATE TRIGGER chk_player_shoot_insert
BEFORE INSERT ON hockey.players FOR EACH ROW 
BEGIN   
    IF NEW.player_shoots = 'Left' THEN   
        SET NEW.player_shoots = 'Left';   
    ELSEIF NEW.player_shoots = 'Right' THEN   
        SET NEW.player_shoots = 'Right';   
    ELSE SET NEW.player_shoots = NULL;  
    END IF; 
END; 
;;

-- trigger on update into player_shoots column
CREATE TRIGGER chk_player_shoot_update
BEFORE UPDATE ON hockey.players FOR EACH ROW
BEGIN
    IF NEW.player_shoots = 'Left' THEN
        SET NEW.player_shoots = 'Left';
    ELSEIF NEW.player_shoots = 'Right' THEN
        SET NEW.player_shoots = 'Right';
    ELSE SET NEW.player_shoots = NULL;
    END IF;
END;
;;
