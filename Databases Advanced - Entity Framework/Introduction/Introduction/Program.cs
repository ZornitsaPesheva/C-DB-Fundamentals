using System;
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

                Console.WriteLine("Select an option:");
                Console.WriteLine("2. Show Villains");
                Console.WriteLine("3. Find Minions By Villain Id");
                Console.WriteLine("4. Add Minion");
                Console.WriteLine("5. Towns To Upper Case");
                Console.WriteLine("7. Print All Minion Names");
                Console.WriteLine("8. Increase Minions Age");
                Console.WriteLine("9. Increase Age Stored Procedure");
                var option = int.Parse(Console.ReadLine());
                switch (option)
                {
                    case 2: ShowVillains(connection); break;
                    case 3: FindMinionsByVillainId(connection); break;
                    case 4: AddMinion(connection); break;
                    case 5: TownsToUpperCase(connection); break;
                    case 7: PrintAllMinionNames(connection); break;
                    case 8: IncreaseAge(connection); break;
                    case 9: IncreaseAgeProc(connection); break;
                    default: break;
                }
            }
        }

        private static void IncreaseAgeProc(SqlConnection connection)
        {
            Console.Write("Enter the minion ID: ");
            int ageParam = int.Parse(Console.ReadLine());
            string increaseAge =
            File.ReadAllText("../../IncreaseAge.sql");
            SqlCommand increaseAgeCommand =
            new SqlCommand(increaseAge, connection);
            SqlParameter param =
            new SqlParameter("@mid", ageParam);
            increaseAgeCommand.Parameters.Add(param);
            SqlDataReader reader = increaseAgeCommand.ExecuteReader();
            if (reader.Read())
            {
                Console.WriteLine($"{(string)reader["Name"]} {(int)reader["Age"]}");
            }
        }

        private static void IncreaseAge(SqlConnection connection)
        {
            Console.WriteLine("Enter the minion IDs separated by space:");
            int[] ids = Console.ReadLine().Split(' ')
                .Select(int.Parse).ToArray();
            string idsParam = String.Join(",", ids);
         
            string increaseAge =
                File.ReadAllText("../../IncreaseMinionsAge.sql");
            SqlCommand increaseAgeCommand =
                new SqlCommand(increaseAge, connection);
            SqlParameter param1 =
                new SqlParameter("@idsParam", idsParam);
            increaseAgeCommand.Parameters.Add(param1);
          //  Console.WriteLine(increaseAgeCommand.ExecuteNonQuery());
            SqlDataReader reader = increaseAgeCommand.ExecuteReader();
            while (reader.Read())
            {
                Console.WriteLine($"{(string)reader["Name"]} {(int)reader["Age"]}");
            }
        }

        private static void PrintAllMinionNames(SqlConnection connection)
        {
            string queryCountNames = "USE MinionsDB SELECT COUNT(*) AS Count FROM Minions";
            SqlCommand printMinionNames =
                new SqlCommand(queryCountNames, connection);
            SqlDataReader reader = printMinionNames.ExecuteReader();
            int last = 0;
            if (reader.Read())
            {
                last = (int)reader["Count"];
            }
            reader.Close();
            string queryAllNames = "USE MinionsDB SELECT Name FROM Minions";
            SqlCommand printAllMinionNames =
                new SqlCommand(queryAllNames, connection);
            SqlDataReader readerNames = printAllMinionNames.ExecuteReader();
            List<string> list = new List<string>();
            while (readerNames.Read())
            {
                list.Add((string)readerNames["Name"]);
            }
            while (list.LongCount() > 0)
            {
                Console.WriteLine(list.First());
                list.RemoveAt(0);
                if (list.LongCount() > 0)
                {
                    Console.WriteLine(list.Last());
                    list.RemoveAt(last - 2);
                    last--;
                }
                last--;
            }
        }

        private static void TownsToUpperCase(SqlConnection connection)
        {
            Console.Write("Country: ");
            string country = Console.ReadLine();
            string changeToUpperQuery =
                File.ReadAllText("../../ChangeTownNames.sql");
            SqlCommand changeToUpperCommand =
                new SqlCommand(changeToUpperQuery, connection);
            SqlParameter countryName =
                new SqlParameter("@countryName", country);
            changeToUpperCommand.Parameters.Add(countryName);

            SqlDataReader reader = changeToUpperCommand.ExecuteReader();
            int count = 0;
            List<string> townsList = new List<string>();
            using (reader)
            {
                while (reader.Read())
                {
                    count++;
                    townsList.Add(reader[0].ToString());
                }
            }

            Console.Write(changeToUpperCommand.ExecuteNonQuery());
            if (count > 0)
            {
                Console.WriteLine(" town names were affected.");
                Console.WriteLine($"[{String.Join(", ", townsList)}]");
            }
            else
            {
                Console.WriteLine("No town names were affected.");
            }
        }

        private static void AddMinion(SqlConnection connection)
        {
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
                Console.WriteLine($"{arr[0]} and {arr[2]} ware added");

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
                Console.WriteLine($"{arr[0]} was added");
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
