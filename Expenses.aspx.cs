using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;

namespace AIExpenseTracker
{
    public partial class Expenses : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadExpenses();
            }
        }

        private void LoadExpenses()
        {
            string connectionString =
                ConfigurationManager.ConnectionStrings["AIExpenseTrackerDB"].ConnectionString;

            using (SqlConnection con = new SqlConnection(connectionString))
            {
                string query = "SELECT ExpenseDate, Title, Category, Amount, Notes FROM Expenses ORDER BY ExpenseDate DESC";

                using (SqlCommand cmd = new SqlCommand(query, con))
                {
                    using (SqlDataAdapter da = new SqlDataAdapter(cmd))
                    {
                        DataTable dt = new DataTable();
                        da.Fill(dt);

                        gvExpenses.DataSource = dt;
                        gvExpenses.DataBind();

                        decimal total = 0;

                        foreach (DataRow row in dt.Rows)
                        {
                            total += Convert.ToDecimal(row["Amount"]);
                        }

                        lblTotal.Text = total.ToString("N2");
                    }
                }
            }
        }
    }
}