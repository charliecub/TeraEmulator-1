using Communication.Interfaces;
using Communication.Logic;
using Data;
using Data.DAO;
using Data.Enums.Item;
using Data.Interfaces;
using Utils;

namespace Tera.Services
{
    class AccountService : IAccountService
    {
        public void Authorized(IConnection connection, string accountName)
        {
            connection.Account = DAOManager.accountDAO.LoadAccount(accountName);
            connection.Account.Players = DAOManager.playerDAO.LoadAccountPlayers(accountName);
            connection.Account.AccountWarehouse.Items = DAOManager.invenDAO.LoadAccountStorage(connection.Account);
            foreach (var player in connection.Account.Players)
            {
                player.Inventory.Items = DAOManager.invenDAO.LoadStorage(player, StorageType.Inventory);
                player.CharacterWarehouse.Items = DAOManager.invenDAO.LoadStorage(player, StorageType.CharacterWarehouse);
                player.Quests = DAOManager.questDAO.LoadQuests(player);
                player.PlayerData.IsGM = GamePlay.Default.Administrators.Contains(connection.Account.Name.ToLower());
            }

            //connection.Account = Cache.GetAccount(accountName);
        }

        public void AbortExitAction(IConnection connection)
        {
            if (connection.Account.ExitAction != null)
            {
                connection.Account.ExitAction.Abort();
                connection.Account.ExitAction = null;
            }
        }

        public void Action()
        {
            
        }
    }
}
