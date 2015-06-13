import java.sql.*;
import java.util.Scanner;

public class MainClass 
{
	// database connection parameters
	private static final String DATABASE_URL = "jdbc:mysql://localhost:3306/baseball";
	private static final String USER_NAME = "jason";
	private static final String PASSWORD = "password";
	
	// database connection object
	private static Connection connection;
	
	// prepared statements for queries
	private static PreparedStatement selectSeason;
	private static PreparedStatement updateScores;
	
	
	private static ResultSet selectSeasonResultSet;

	
	public static void main(String[] args) 
	{
		
		try
		{
			// database connection object
			connection = DriverManager.getConnection(DATABASE_URL, USER_NAME, PASSWORD);
			
			// select all records from SEASON table
			selectSeason = connection.prepareStatement("SELECT * FROM baseball.season");
			
			// execute query and store result into ResulSet object
			selectSeasonResultSet = selectSeason.executeQuery();
			
			// call update scores stored procedure
			updateScores = connection.prepareStatement("CALL updateScores(?, ?, ?, ?)");
			
			// Scanner object used for input
			Scanner input = new Scanner(System.in);
			
			// iterate through the table
			while (selectSeasonResultSet.next())
			{
				
				// get the season and play_date values from the Season table
				int seasonValue = selectSeasonResultSet.getInt("season");
				String playDate = selectSeasonResultSet.getString("play_date");
				System.out.printf("SEASON: %d\t GAME DATE: %s\n", seasonValue, playDate );
					
				// Prompt user to enter home team's score
				String homeTeam = selectSeasonResultSet.getString("home_team");
				System.out.printf("Enter home team %s score: ", homeTeam);
				int homeTeamScore = input.nextInt();
					
				// Prompt user to enter away team's score
				String awayTeam = selectSeasonResultSet.getString("away_team");
				System.out.printf("Enter away team %s score: ", awayTeam);
				int awayTeamScore = input.nextInt();
					
				// call the stored procedure and update the Season table with the scores entered
				updateScores.setInt(1, homeTeamScore);
				updateScores.setInt(2, awayTeamScore);
				updateScores.setInt(3,  seasonValue);
				updateScores.setString(4,  playDate);
				updateScores.execute();
				
				System.out.println();
			}
			
			input.close();
		}
		catch (SQLException sqlException)
		{
			sqlException.printStackTrace();
		}
		finally
		{
			// close down result set connections
			try
			{
				selectSeasonResultSet.close();
				updateScores.close();
			}
			catch (SQLException sqlException)
			{
				sqlException.printStackTrace();
			}
		}
		
	}
}
