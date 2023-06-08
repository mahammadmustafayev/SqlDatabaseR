

using Microsoft.SqlServer.Server;
using Newtonsoft.Json;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Globalization;
using TestLibrary.Models;

public  class PersonTest
{
    [Microsoft.SqlServer.Server.SqlFunction]
    public static string ReturnsPersonJson()
    {
        string query = $"SELECT * FROM Persons  ";
        string ConnectionString = "Server=localhost;Database=PhoneBook;Trusted_Connection=true;TrustServerCertificate=yes;";
		var persons = new List<Person>();
        //string resultJson;
		using (SqlConnection connection = new SqlConnection(connectionString: ConnectionString))
        {
            using (SqlCommand command = new SqlCommand(cmdText: query, connection: connection))
            {
                connection.Open();
                using (SqlDataReader reader = command.ExecuteReader())
                {
                    while (reader.Read())
                    {
                        Person person = new Person();
						foreach (var property in typeof(Person).GetProperties())
						{
                            
							property.SetValue(person, reader[property.Name]);
						}
						persons.Add(person);

					}
                }
            }

        }
        return  JsonConvert.SerializeObject(persons);
    }
    [SqlFunction]
    public static string ToToListCase(string text)
    {

        return CultureInfo.CurrentCulture.TextInfo.ToTitleCase(text);
    }
}
