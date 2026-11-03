using System;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Drawing;
using System.Web.UI;

namespace AIExpenseTracker
{
    public partial class Dashboard : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                LoadDashboard();
            }
        }

        private void LoadDashboard()
        {
            string connectionString =
                ConfigurationManager.ConnectionStrings["AIExpenseTrackerDB"].ConnectionString;

            using (SqlConnection con = new SqlConnection(connectionString))
            {
                con.Open();

                // Total spending
                string totalQuery = "SELECT ISNULL(SUM(Amount), 0) FROM Expenses";

                using (SqlCommand cmd = new SqlCommand(totalQuery, con))
                {
                    decimal total = Convert.ToDecimal(cmd.ExecuteScalar());
                    lblTotal.Text = "₹ " + total.ToString("N2");
                }

                // Total number of expenses
                string countQuery = "SELECT COUNT(*) FROM Expenses";

                using (SqlCommand cmd = new SqlCommand(countQuery, con))
                {
                    int count = Convert.ToInt32(cmd.ExecuteScalar());
                    lblCount.Text = count.ToString();
                }

                // Top spending category
                string categoryQuery = @"
                    SELECT TOP 1 Category
                    FROM Expenses
                    GROUP BY Category
                    ORDER BY SUM(Amount) DESC";
                // Category-wise spending
                string categoryWiseQuery = @"
    SELECT Category, SUM(Amount) AS Total
    FROM Expenses
    GROUP BY Category
    ORDER BY Total DESC";

                using (SqlCommand cmd = new SqlCommand(categoryWiseQuery, con))
                {
                    using (SqlDataReader reader = cmd.ExecuteReader())
                    {
                        string categoryData = "";

                        while (reader.Read())
                        {
                            categoryData += reader["Category"].ToString()
                                + ": ₹"
                                + Convert.ToDecimal(reader["Total"]).ToString("0.00")
                                + "<br />";
                        }

                        if (categoryData != "")
                        {
                            lblCategoryWise.Text = categoryData;
                        }
                        else
                        {
                            lblCategoryWise.Text = "No data";
                        }
                    }
                }

                // This month's spending
                string monthlyQuery = @"
    SELECT ISNULL(SUM(Amount), 0)
    FROM Expenses
    WHERE MONTH(ExpenseDate) = MONTH(GETDATE())
    AND YEAR(ExpenseDate) = YEAR(GETDATE())";

                using (SqlCommand monthlyCmd = new SqlCommand(monthlyQuery, con))
                {
                    decimal monthlyTotal = Convert.ToDecimal(monthlyCmd.ExecuteScalar());
                    lblMonthly.Text = "₹ " + monthlyTotal.ToString("0.00");
                }

                using (SqlCommand cmd = new SqlCommand(categoryQuery, con))
                {
                    object result = cmd.ExecuteScalar();

                    if (result != null)
                    {
                        lblTopCategory.Text = result.ToString();
                    }
                    else
                    {
                        lblTopCategory.Text = "No data";
                    }
                }
            }
            
            }
        }
    }
