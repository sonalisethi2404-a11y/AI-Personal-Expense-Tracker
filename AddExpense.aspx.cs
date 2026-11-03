using System;
using System.Configuration;
using System.Data.SqlClient;

namespace AIExpenseTracker
{
    public partial class AddExpense : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                txtExpenseDate.Text = DateTime.Today.ToString("yyyy-MM-dd");
            }
        }

        protected void btnAddExpense_Click(object sender, EventArgs e)
        {
            try
            {
                DateTime expenseDate = DateTime.Parse(txtExpenseDate.Text);
                string title = txtTitle.Text.Trim();
                string category = ddlCategory.SelectedValue;
                decimal amount = decimal.Parse(txtAmount.Text);
                string notes = txtNotes.Text.Trim();

                if (string.IsNullOrEmpty(title))
                {
                    lblMessage.Text = "Please enter an expense title.";
                    return;
                }

                if (amount <= 0)
                {
                    lblMessage.Text = "Please enter a valid amount.";
                    return;
                }

                string connectionString =
                    ConfigurationManager.ConnectionStrings["AIExpenseTrackerDB"].ConnectionString;

                using (SqlConnection con = new SqlConnection(connectionString))
                {
                    string query = @"INSERT INTO Expenses
                                    (ExpenseDate, Title, Category, Amount, Notes)
                                    VALUES
                                    (@ExpenseDate, @Title, @Category, @Amount, @Notes)";

                    using (SqlCommand cmd = new SqlCommand(query, con))
                    {
                        cmd.Parameters.AddWithValue("@ExpenseDate", expenseDate);
                        cmd.Parameters.AddWithValue("@Title", title);
                        cmd.Parameters.AddWithValue("@Category", category);
                        cmd.Parameters.AddWithValue("@Amount", amount);
                        cmd.Parameters.AddWithValue("@Notes",
                            string.IsNullOrEmpty(notes) ? (object)DBNull.Value : notes);

                        con.Open();
                        cmd.ExecuteNonQuery();
                    }
                }

                lblMessage.Text = "Expense added successfully!";

                txtTitle.Text = "";
                txtAmount.Text = "";
                txtNotes.Text = "";
                ddlCategory.SelectedIndex = 0;
                txtExpenseDate.Text = DateTime.Today.ToString("yyyy-MM-dd");
            }
            catch (Exception ex)
            {
                lblMessage.Text = "Error: " + ex.Message;
            }
        }
    }
}