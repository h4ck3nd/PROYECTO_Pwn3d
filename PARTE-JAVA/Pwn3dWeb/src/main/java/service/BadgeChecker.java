package service;

import dao.BadgeDAO;
import dao.UserStatsDAO;

public class BadgeChecker {

    private final BadgeDAO badgeDAO = new BadgeDAO();
    private final UserStatsDAO statsDAO = new UserStatsDAO();

    public void verificarLogros(int userId) {
        // Chequeos ejemplo con nombres nuevos
        int maquinasResueltas = statsDAO.getMaquinasResueltas(userId);
        if (maquinasResueltas >= 50) {
			badgeDAO.updateBadge(userId, "vms50");
		}
        if (maquinasResueltas >= 100) {
			badgeDAO.updateBadge(userId, "vms100");
		}
        if (maquinasResueltas >= 200) {
			badgeDAO.updateBadge(userId, "vms200");
		}
        if (maquinasResueltas >= 300) {
			badgeDAO.updateBadge(userId, "vms300");
		}
        if (maquinasResueltas >= 500) {
            System.out.println("DEBUG: Asignando badge 'prohacker'");
            badgeDAO.updateBadge(userId, "prohacker");
        }

        int writeups = statsDAO.getWriteupsCount(userId);
        if (writeups > 0) {
			badgeDAO.updateBadge(userId, "escritor");
		}
        if (writeups >= 100) {
			badgeDAO.updateBadge(userId, "writeups100");
		}

        int puntos = statsDAO.getPuntos(userId);
        if (puntos >= 100) {
			badgeDAO.updateBadge(userId, "puntos100");
		}
        if (puntos >= 1000) {
			badgeDAO.updateBadge(userId, "puntos1000");
		}
        if (puntos >= 2000) {
			badgeDAO.updateBadge(userId, "puntos2000");
		}
        if (puntos >= 3000) {
			badgeDAO.updateBadge(userId, "puntos3000");
		}

        if (puntos >= 100) {
			badgeDAO.updateBadge(userId, "aprendiz");
		}
        if (puntos >= 1000) {
			badgeDAO.updateBadge(userId, "0xcoffee");
		}
        if (puntos >= 2000) {
			badgeDAO.updateBadge(userId, "anonymous");
		}
        if (puntos >= 3000) {
			badgeDAO.updateBadge(userId, "FuckSystem");
		}
        if (puntos >= 5000) {
			badgeDAO.updateBadge(userId, "god");
		}
    }

    public BadgeDAO getBadgeDAO() {
        return badgeDAO;
    }

    public UserStatsDAO getStatsDAO() {
        return statsDAO;
    }
}
