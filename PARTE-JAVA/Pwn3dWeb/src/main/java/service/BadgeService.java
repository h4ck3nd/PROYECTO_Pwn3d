package service;

import java.sql.SQLException;

import dao.*;
import model.Badge;
import model.User;

public class BadgeService {

    private BadgeDAO badgeDAO = new BadgeDAO();
    private RankingDAO rankingDAO = new RankingDAO();
    private MachineDAO machinesDAO = new MachineDAO();
    private FlagsDAO flagsDAO = new FlagsDAO(null);
    private WriteupDAO writeupsDAO = new WriteupDAO();
    private StarsDAO starsMachinesDAO = new StarsDAO();
    private UserDAO usersDAO = new UserDAO();

    public void checkAndUpdateBadges(int userId) throws SQLException {
        Badge badge = badgeDAO.getBadgesByUserId(userId);
        if (badge == null) {
            badgeDAO.createBadgesForUser(userId);
            badge = badgeDAO.getBadgesByUserId(userId);
        }

        User user = usersDAO.getUserById(userId);
        if (user == null) return; // Usuario no encontrado

        String usuario = user.getUsuario();

        // 1. noob
        if (!badge.isNoob()) {
            badgeDAO.updateBadge(userId, "noob");
        }

        // 2. top1mes
        User topMes = rankingDAO.getTopUserByPeriod("mes");
        if (topMes != null && topMes.getId() == userId && !badge.isTop1mes()) {
            badgeDAO.updateBadge(userId, "top1mes");
        }

        // 3. top1año
        User topAnio = rankingDAO.getTopUserByPeriod("anio");
        if (topAnio != null && topAnio.getId() == userId && !badge.isTop1año()) {
            badgeDAO.updateBadge(userId, "top1año");
        }

        // 4. creador
        if (!badge.isCreador() && machinesDAO.isUserCreator(usuario)) {
            badgeDAO.updateBadge(userId, "creador");
        }

        // 5. máquinas hackeadas
        int hackedCount = flagsDAO.countMachinesHackedByUser(userId);
        System.out.println("DEBUG: Usuario ID " + userId + " ha hackeado " + hackedCount + " máquinas.");  // Depuración

        if (hackedCount >= 50 && !badge.isVms50()) {
            badgeDAO.updateBadge(userId, "vms50");
        }
        if (hackedCount >= 100) {
            if (!badge.isVms100()) badgeDAO.updateBadge(userId, "vms100");
            if (!badge.isHacker()) badgeDAO.updateBadge(userId, "hacker");
        }
        if (hackedCount >= 200 && !badge.isVms200()) {
            badgeDAO.updateBadge(userId, "vms200");
        }
        if (hackedCount >= 300 && !badge.isVms300()) {
            badgeDAO.updateBadge(userId, "vms300");
        }
        if (hackedCount >= 500 && !badge.isProHacker()) {
            System.out.println("DEBUG: Asignando badge 'prohacker' a usuario ID " + userId);
            badgeDAO.updateBadge(userId, "prohacker");
        }

        // 6. juniorVM
        if (hackedCount >= 1 && !badge.isJuniorvm()) {
            badgeDAO.updateBadge(userId, "juniorvm");
        }

        // 7. escritor y writeups100
        int writeupsCount = writeupsDAO.countWriteupsByUser(userId);
        if (writeupsCount >= 1 && !badge.isSolucionador()) {
            badgeDAO.updateBadge(userId, "solucionador");
        }
        if (writeupsCount >= 10 && !badge.isEscritor()) {
            badgeDAO.updateBadge(userId, "escritor");
        }
        if (writeupsCount >= 100 && !badge.isWriteups100()) {
            badgeDAO.updateBadge(userId, "writeups100");
        }

        // 8. firstRoot y firstUser
        if (flagsDAO.hasFirstRootFlag(userId) && !badge.isFirstroot()) {
            badgeDAO.updateBadge(userId, "firstroot");
        }
        if (flagsDAO.hasFirstUserFlag(userId) && !badge.isFirstuser()) {
            badgeDAO.updateBadge(userId, "firstuser");
        }

     // 9. puntos
        int puntos = usersDAO.getUserPoints(userId);  // <--- Aquí el cambio para obtener puntos actualizados desde DB
        System.out.println("DEBUG: Usuario ID " + userId + " tiene " + puntos + " puntos.");  // Depuración

        if (puntos >= 100 && !badge.isPuntos100()) {
            badgeDAO.updateBadge(userId, "puntos100");
            badge = badgeDAO.getBadgesByUserId(userId);
        }

        if (puntos >= 1000 && !badge.isPuntos1000()) {
            badgeDAO.updateBadge(userId, "puntos1000");
            badge = badgeDAO.getBadgesByUserId(userId);
        }

        if (puntos >= 2000 && !badge.isPuntos2000()) {
            badgeDAO.updateBadge(userId, "puntos2000");
            badge = badgeDAO.getBadgesByUserId(userId);
        }

        if (puntos >= 3000 && !badge.isPuntos3000()) {
            badgeDAO.updateBadge(userId, "puntos3000");
            badge = badgeDAO.getBadgesByUserId(userId);
        }

        // 10. estrellita
        if (starsMachinesDAO.hasStars(userId) && !badge.isEstrellita()) {
            badgeDAO.updateBadge(userId, "estrellita");
        }
    }
}
