﻿using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Introduction
{
    class Program
    {
        static void Main(string[] args)
        {
            
            SqlConnection connection =
                new SqlConnection(@"Server=(LocalDb)\MSSQLLocalDB;Integrated Security=true;");

            connection.Open();
            // string sqlCreateDB = "CREATE DATABASE MinionsDB";
            //  SqlCommand createDBCommand = new SqlCommand(sqlCreateDB, connection);


            using (connection)
            {
                // createDBCommand.ExecuteNonQuery();
                //CreateTables(createTablesCommand);
                // ShowVillains(connection);
                // FindMinionsByVillainId(connection);
                Console.Write("Minion: ");
                string[] arr = Console.ReadLine().Split(' ')
                    .ToArray();

                Console.Write("Villain: ");
                string villain = Console.ReadLine();

                string isTownExist = "USE MinionsDB SELECT * FROM Towns WHERE Name = @town";
                SqlCommand isTownExistComand = new SqlCommand(isTownExist, connection);
                SqlParameter town = new SqlParameter("@town", arr[2]);
                isTownExistComand.Parameters.Add(town);

                SqlDataReader reader = isTownExistComand.ExecuteReader();
                if (!reader.Read())
                {
                    Console.Write("Country: ");
                    string countryName = Console.ReadLine();

                    string addMinionQuery = File.ReadAllText("../../AddMinion1.sql");
                    SqlCommand addMinionComand = new SqlCommand(addMinionQuery, connection);

                    addMinionComand.Parameters.AddRange(new[]
                    {
                        new SqlParameter("@name", arr[0]),
                        new SqlParameter("@age", int.Parse(arr[1])),
                        new SqlParameter("@town", arr[2]),
                        new SqlParameter("@villain", villain),
                        new SqlParameter("@country", countryName)
                    });
                    reader.Close();
                    Console.WriteLine(addMinionComand.ExecuteNonQuery());

                }
                else
                {
                    string addMinionQuery = File.ReadAllText("../../AddMinion.sql");
                    SqlCommand addMinionComand = new SqlCommand(addMinionQuery, connection);

                    addMinionComand.Parameters.AddRange(new[]
                    {
                        new SqlParameter("@name", arr[0]),
                        new SqlParameter("@age", int.Parse(arr[1])),
                        new SqlParameter("@town", arr[2]),
                        new SqlParameter("@villain", villain)
                    });
                    reader.Close();
                    Console.WriteLine(addMinionComand.ExecuteNonQuery());
                }
            }
        }

        private static void FindMinionsByVillainId(SqlConnection connection)
        {
            int villainId = int.Parse(Console.ReadLine());
            string findNameQuery = File.ReadAllText("../../VillainNameById.sql");
            SqlCommand findVillainNameComand = new SqlCommand(findNameQuery, connection);
            SqlParameter villainParam =
                  new SqlParameter("@villainId", villainId);
            findVillainNameComand.Parameters.Add(villainParam);

            SqlDataReader reader = findVillainNameComand.ExecuteReader();

            if (reader.Read())
            {
                string villName = (string)reader["name"];
                Console.WriteLine($"Villain: {villName}");

                string findMinionsQuery = File.ReadAllText("../../FindMinions.sql");
                SqlCommand findMinionsCommand = new SqlCommand(findMinionsQuery, connection);
                SqlParameter param = new SqlParameter("@villainId", villainId);
                findMinionsCommand.Parameters.Add(param);
                reader.Close();

                SqlDataReader minionsReader = findMinionsCommand.ExecuteReader();
                int index = 1;
                while (minionsReader.Read())
                {
                    string minionName = (string)minionsReader["name"];
                    int minionAge = (int)minionsReader["age"];
                    Console.WriteLine($"{index}. {minionName} {minionAge}");
                    index++;
                }
            }
            else
            {
                Console.WriteLine("No villain with ID 10 exists in the database.");
            }
        }

        private static void ShowVillains(SqlConnection connection)
        {
            string query = File.ReadAllText("../../VillainNames.sql");
            SqlCommand command = new SqlCommand(query, connection);

            SqlDataReader reader = command.ExecuteReader();
            
            using (reader)
            {
                while (reader.Read())
                {
                    string villainName = (string)reader["Name"];
                    int countSubordinates = (int)reader["MinionsCount"];

                    Console.WriteLine($"{villainName} {countSubordinates}");
                }
            }
        }

        private static void CreateTables(SqlConnection connection)
        {
            string query = File.ReadAllText("../../Setup.sql");
            SqlCommand createTablesCommand = new SqlCommand(query, connection);
            Console.WriteLine(createTablesCommand.ExecuteNonQuery());
        }
    }
}
