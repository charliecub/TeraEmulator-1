using Data.Enums;
using Data.Structures.Player;
using Data.Structures.Quest;
using MySql.Data.MySqlClient;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Utils;

namespace Data.DAO
{
    public class QuestDAO : BaseDAO
    {
        private MySqlConnection QuestDAOConnection;

        public QuestDAO(string conStr)
            : base(conStr)
        {
            QuestDAOConnection = new MySqlConnection(conStr);
            QuestDAOConnection.Open();
            Log.Info("DAO: QuestDAO Initialized.");
        }

        public void AddQuest(Player player, QuestData questdata)
        {
            string cmdString = "SELECT * FROM questdata WHERE QuestId=?qid AND PlayerId=?pid";
            MySqlCommand command = new MySqlCommand(cmdString, QuestDAOConnection);
            command.Parameters.AddWithValue("?qid", questdata.QuestId);
            command.Parameters.AddWithValue("?pid", player.Id);
            MySqlDataReader reader = command.ExecuteReader();
            bool isExists = reader.HasRows;
            reader.Close();

            if (!isExists)
            {
                cmdString = "INSERT INTO questdata "
                + "(`PlayerId`,`QuestId`,`Status`,`Step`,`Counters`) "
                + "VALUES (?pid, ?qid, ?qstatus, ?qstep, ?qcounter);";
                command = new MySqlCommand(cmdString, QuestDAOConnection);
                command.Parameters.AddWithValue("?pid", player.Id);
                command.Parameters.AddWithValue("?qid", questdata.QuestId);
                command.Parameters.AddWithValue("?qstatus", questdata.Status.ToString());
                command.Parameters.AddWithValue("?qstep", questdata.Step);
                command.Parameters.AddWithValue("?qcounter", string.Join(",", questdata.Counters));
            }
            else
            {
                cmdString = "UPDATE questdata SET"
                + "`Status`=?qstatus,`Step`=?qstep,`Counters`=?qcounter WHERE QuestId=?qid AND PlayerId=?pid";
                command = new MySqlCommand(cmdString, QuestDAOConnection);
                command.Parameters.AddWithValue("?qstatus", questdata.Status.ToString());
                command.Parameters.AddWithValue("?qstep", questdata.Step);
                command.Parameters.AddWithValue("?qcounter", string.Join(",", questdata.Counters));
                command.Parameters.AddWithValue("?qid", questdata.QuestId);
                command.Parameters.AddWithValue("?pid", player.Id);
            }

            try
            {
                command.ExecuteNonQuery();
            }
            catch (MySqlException ex)
            {
                Log.ErrorException("SaveQuest Error", ex);
            }
        }

        public QuestData LoadQuest(Player player, int questId)
        {
            string cmdString = "SELECT * FROM questdata WHERE QuestId=?qid AND PlayerId=?pid";
            MySqlCommand command = new MySqlCommand(cmdString, QuestDAOConnection);
            command.Parameters.AddWithValue("?qid", questId);
            command.Parameters.AddWithValue("?pid", player.Id);
            MySqlDataReader reader = command.ExecuteReader();

            QuestData quest = new QuestData(questId);
            if (reader.HasRows)
            {
                while (reader.Read())
                {
                    quest = new QuestData(questId)
                    {
                        QuestId = reader.GetInt32(1),
                        Status = (QuestStatus)Enum.Parse(typeof(QuestStatus), reader.GetString(2)),
                        Step = reader.GetInt32(3),
                        Counters = reader.GetString(4).Split(',').Select(n => int.Parse(n)).ToList()
                    };
                }
            }
            reader.Close();

            return quest;
        }

        public Dictionary<int, QuestData> LoadQuests(Player player)
        {
            string cmdString = "SELECT * FROM questdata WHERE PlayerId=?pid";
            MySqlCommand command = new MySqlCommand(cmdString, QuestDAOConnection);
            command.Parameters.AddWithValue("?pid", player.Id);
            MySqlDataReader reader = command.ExecuteReader();

            Dictionary<int, QuestData> questlist = new Dictionary<int, QuestData>();
            if (reader.HasRows)
            {
                while (reader.Read())
                {
                    QuestData quest = new QuestData(0)
                    {
                        QuestId = reader.GetInt32(2),
                        Status = (QuestStatus)Enum.Parse(typeof(QuestStatus), reader.GetString(3)),
                        Step = reader.GetInt32(4),
                        Counters = reader.GetString(5).Split(',').Select(n => int.Parse(n)).ToList()
                    };
                    questlist.Add(quest.QuestId, quest);
                }
            }
            reader.Close();

            return questlist;
        }
    }
}
