using System;
using System.Configuration;
using System.Data.SqlClient;
using System.Net;
using System.Text;
using System.Web.Script.Serialization;

namespace AIExpenseTracker
{
    public partial class AIAnalysis : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
        }

        protected void btnAnalyze_Click(object sender, EventArgs e)
        {
            try
            {
                // Get expense information from database
                string expenseData = GetExpenseData();

                if (string.IsNullOrEmpty(expenseData))
                {
                    lblResult.InnerText =
                        "No expenses found. Please add some expenses first.";
                    return;
                }

                // Create prompt for Ollama
                string prompt =
    "You are a personal finance assistant for a user in India. " +
    "Analyze the following expense data and provide simple practical suggestions to save money. " +
    "IMPORTANT: All amounts are in Indian Rupees. " +
    "Use the text INR before every monetary amount. " +
    "Do not use the dollar symbol or any other currency symbol.\n\n" +
    "Expense Data:\n" +
    expenseData +
    "\n\nPlease provide:\n" +
    "1. Spending summary\n" +
    "2. Highest spending category\n" +
    "3. Areas where the user can save money\n" +
    "4. Three practical saving suggestions\n" +
    "Use INR for every monetary amount.";

                // Send prompt to Ollama
                string response = AskOllama(prompt);

                // Ensure Indian Rupee symbol is displayed
                response = response.Replace("INR", "&#8377;");
                response = response.Replace("$", "&#8377;");

                lblResult.InnerHtml = response;
            }
            catch (Exception ex)
            {
                lblResult.InnerText = "Error: " + ex.Message;
            }
        }

        private string GetExpenseData()
        {
            StringBuilder data = new StringBuilder();

            string connectionString =
                ConfigurationManager.ConnectionStrings[
                    "AIExpenseTrackerDB"
                ].ConnectionString;

            using (SqlConnection con =
                   new SqlConnection(connectionString))
            {
                string query = @"
                    SELECT Category, SUM(Amount) AS TotalAmount
                    FROM Expenses
                    GROUP BY Category
                    ORDER BY TotalAmount DESC";

                using (SqlCommand cmd =
                       new SqlCommand(query, con))
                {
                    con.Open();

                    using (SqlDataReader reader =
                           cmd.ExecuteReader())
                    {
                        while (reader.Read())
                        {
                            data.AppendLine(
    reader["Category"].ToString() +
    ": INR " +
    Convert.ToDecimal(reader["TotalAmount"]).ToString("0.00")
);
                        }
                    }
                }
            }

            return data.ToString();
        }

        private string AskOllama(string prompt)
        {
            string url =
                "http://127.0.0.1:11434/api/generate";

            var requestData = new
            {
                model = "llama3.2:3b",
                prompt = prompt,
                stream = false
            };

            JavaScriptSerializer serializer =
                new JavaScriptSerializer();

            string json =
                serializer.Serialize(requestData);

            using (WebClient client = new WebClient())
            {
                // Do not use Windows proxy for local Ollama
                client.Proxy = null;

                client.Headers[HttpRequestHeader.ContentType] =
                    "application/json";

                string result =
                    client.UploadString(
                        url,
                        "POST",
                        json
                    );

                var ollamaResponse =
                    serializer.Deserialize<OllamaResponse>(
                        result
                    );

                return ollamaResponse.response;
            }
        }

        public class OllamaResponse
        {
            public string response { get; set; }
        }
    }
}