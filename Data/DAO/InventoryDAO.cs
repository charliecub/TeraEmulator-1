using Data.Enums.Item;
using Data.Structures.Account;
using Data.Structures.Player;
using MySql.Data.MySqlClient;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Utils;

namespace Data.DAO
{
    public class InventoryDAO : BaseDAO
    {
        private MySqlConnection InvenDAOConnection;

        public InventoryDAO(string conStr)
            : base(conStr)
        {
            InvenDAOConnection = new MySqlConnection(conStr);
            InvenDAOConnection.Open();
            Log.Info("DAO: InventoryDAO Initialized.");
        }

        public bool AddItem(Player player, StorageType type, KeyValuePair<int, StorageItem> kvp)
        {
            string cmdString = "SELECT * FROM inventory WHERE PlayerId=?pid AND ItemId=?itemid AND Slot=?slot";
            MySqlCommand command = new MySqlCommand(cmdString, InvenDAOConnection);
            command.Parameters.AddWithValue("?pid", player.Id);
            command.Parameters.AddWithValue("?itemid", kvp.Value.ItemId);
            command.Parameters.AddWithValue("?slot", kvp.Key);
            MySqlDataReader reader = command.ExecuteReader();
            bool isExists = reader.HasRows;
            reader.Close();

            if (!isExists)
            {
                cmdString = "INSERT INTO inventory "
                + "(`AccountName`,`PlayerId`,`ItemId`,`Amount`,`Color`,`Slot`,`StorageType`) "
                + "VALUES (?aname, ?pid, ?itemid, ?count, ?color, ?slot, ?type); SELECT LAST_INSERT_ID();";
                command = new MySqlCommand(cmdString, InvenDAOConnection);
                command.Parameters.AddWithValue("?aname", player.AccountName);
                command.Parameters.AddWithValue("?pid", player.Id);
                command.Parameters.AddWithValue("?itemid", kvp.Value.ItemId);
                command.Parameters.AddWithValue("?count", kvp.Value.Count);
                command.Parameters.AddWithValue("?color", kvp.Value.Color);
                command.Parameters.AddWithValue("?slot", kvp.Key);
                command.Parameters.AddWithValue("?type", type.ToString());
            }
            else
            {
                cmdString = "UPDATE inventory SET "
                + "`Amount`=?count,`Color`=?color,`Slot`=?slot,`StorageType`=?type WHERE `ItemId`=?itemid AND `PlayerId`=?pid";
                command = new MySqlCommand(cmdString, InvenDAOConnection);
                command.Parameters.AddWithValue("?count", kvp.Value.Count);
                command.Parameters.AddWithValue("?color", kvp.Value.Color);
                command.Parameters.AddWithValue("?slot", kvp.Key);
                command.Parameters.AddWithValue("?type", type.ToString());
                command.Parameters.AddWithValue("?itemid", kvp.Value.ItemId);
                command.Parameters.AddWithValue("?pid", player.Id);
            }

            try
            {
                command.ExecuteNonQuery();
                return true;
            }
            catch (MySqlException ex)
            {
                Log.ErrorException("AddItem Error", ex);
            }

            return false;
        }

        public bool SaveStorage(Player player, Storage storage)
        {
            if (storage.Items.Count > 0)
            {
                foreach (var item in storage.Items)
                    AddItem(player, storage.StorageType, item);

                return true;
            }
            return false;
        }

        public Dictionary<int, StorageItem> LoadStorage(Player player, StorageType type)
        {
            string cmdString = "SELECT * FROM inventory WHERE PlayerId=?id AND StorageType=?type";
            MySqlCommand command = new MySqlCommand(cmdString, InvenDAOConnection);
            command.Parameters.AddWithValue("?id", player.Id);
            command.Parameters.AddWithValue("?type", type.ToString());
            MySqlDataReader reader = command.ExecuteReader();

            Dictionary<int, StorageItem> items = new Dictionary<int, StorageItem>();
            if (reader.HasRows)
            {
                while (reader.Read())
                {
                    StorageItem item = new StorageItem()
                    {
                        ItemId = reader.GetInt32(3),
                        Count = reader.GetInt32(4),
                        Color = reader.GetInt32(5),
                    };
                    items.Add(reader.GetInt32(6), item);
                }
            }
            reader.Close();

            return items;
        }

        public Dictionary<int, StorageItem> LoadAccountStorage(Account account)
        {
            string cmdString = "SELECT * FROM inventory WHERE AccountName=?aname AND StorageType=?type";
            MySqlCommand command = new MySqlCommand(cmdString, InvenDAOConnection);
            command.Parameters.AddWithValue("?aname", account.Name);
            command.Parameters.AddWithValue("?type", StorageType.AccountWarehouse.ToString());
            MySqlDataReader reader = command.ExecuteReader();

            Dictionary<int, StorageItem> items = new Dictionary<int, StorageItem>();
            if (reader.HasRows)
            {
                while (reader.Read())
                {
                    StorageItem item = new StorageItem()
                    {
                        ItemId = reader.GetInt32(3),
                        Count = reader.GetInt32(4),
                        Color = reader.GetInt32(5),
                    };
                    items.Add(reader.GetInt32(6), item);
                }
            }
            reader.Close();

            return items;
        }
    }
}
