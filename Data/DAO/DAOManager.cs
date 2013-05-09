using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Data.DAO
{
    public static class DAOManager
    {
        public static AccountDAO accountDAO;
        public static InventoryDAO invenDAO;
        public static PlayerDAO playerDAO;
        public static QuestDAO questDAO;

        public static void Initialize(string constr)
        {
            accountDAO = new AccountDAO(constr);
            invenDAO = new InventoryDAO(constr);
            playerDAO = new PlayerDAO(constr);
            questDAO = new QuestDAO(constr);
            Console.WriteLine();
            Console.WriteLine("-------------------------------------------");
        }
    }
}
