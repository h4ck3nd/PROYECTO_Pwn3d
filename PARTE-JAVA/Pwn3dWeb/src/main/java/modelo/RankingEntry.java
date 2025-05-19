package modelo;

public class RankingEntry {
    private String username;
    private int totalPoints;

    public RankingEntry(String username, int totalPoints) {
        this.username = username;
        this.totalPoints = totalPoints;
    }

    public String getUsername() {
        return username;
    }

    public int getTotalPoints() {
        return totalPoints;
    }
}