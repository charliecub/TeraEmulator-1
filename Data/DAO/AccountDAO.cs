using Data.Structures.Account;
using MySql.Data.MySqlClient;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Utils;

namespace Data.DAO
{
    public class AccountDAO : BaseDAO
    {
        private MySqlConnection AccountDAOConnection;

        public AccountDAO(string conStr)
            : base(conStr)
        {
            AccountDAOConnection = new MySqlConnection(conStr);
            AccountDAOConnection.Open();
            Log.Info("DAO: AccountDAO Initialized.");
        }

        public Account LoadAccount(string username)
        {
            string cmdString = "SELECT * FROM accounts WHERE Name=?username";
            MySqlCommand command = new MySqlCommand(cmdString, AccountDAOConnection);
            command.Parameters.AddWithValue("?username", username);
            MySqlDataReader reader = command.ExecuteReader();

            Account acc = new Account();
            if (reader.HasRows)
            {
                while (reader.Read())
                {
                    acc.AccountId = reader.GetInt32(0);
                    acc.Name = reader.GetString(1);
                    acc.AccessLevel = (byte)reader.GetInt32(3);
                    acc.Membership = (byte)reader.GetInt32(4);
                    acc.LastOnlineUtc = reader.GetInt64(5);
                }
            }

            reader.Close();

            return (acc.Name == "") ? null : acc;
        }

        public bool SaveAccount(Account account)
        {
            string cmdString = "INSERT INTO accounts (`Name`,`Password`) VALUES (?name, ?pass);";
            MySqlCommand command = new MySqlCommand(cmdString, AccountDAOConnection);
            command.Parameters.AddWithValue("?name", account.Name);
            command.Parameters.AddWithValue("?pass", "test");

            try
            {
                command.ExecuteNonQuery();
                return true;
            }
            catch (MySqlException ex)
            {
                Log.ErrorException("SaveAccount Error", ex);
            }

            return false;
        }
    }
}
