<%@ Page Language="C#" AutoEventWireup="true"
    CodeBehind="Expenses.aspx.cs"
    Inherits="AIExpenseTracker.Expenses" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">

<head runat="server">

    <title>AI Expense Tracker - Expenses</title>

    <style>

        * {
            box-sizing: border-box;
        }

        body {
            margin: 0;
            padding: 35px;
            font-family: Arial, sans-serif;
            background: linear-gradient(135deg, #f5f3ff, #eef2ff);
            color: #172033;
        }

        .container {
            max-width: 1200px;
            margin: auto;
        }

        /* HEADER */

        .hero {
            position: relative;
            overflow: hidden;
            background: linear-gradient(135deg, #7028e4, #4f46e5);
            color: white;
            border-radius: 28px;
            padding: 35px 40px;
            box-shadow: 0 15px 35px rgba(79, 70, 229, 0.25);
            margin-bottom: 28px;
        }

        .hero:before {
            content: "";
            position: absolute;
            width: 180px;
            height: 180px;
            border-radius: 50%;
            background: rgba(255,255,255,0.10);
            right: -50px;
            top: -70px;
        }

        .hero:after {
            content: "";
            position: absolute;
            width: 130px;
            height: 130px;
            border-radius: 50%;
            background: rgba(255,255,255,0.08);
            left: -45px;
            bottom: -70px;
        }

        .brand {
            font-size: 15px;
            font-weight: bold;
            letter-spacing: 1px;
            position: relative;
            z-index: 1;
        }

        .hero h1 {
            margin: 12px 0 8px;
            font-size: 36px;
            position: relative;
            z-index: 1;
        }

        .hero p {
            margin: 0;
            font-size: 16px;
            opacity: 0.9;
            position: relative;
            z-index: 1;
        }

        /* NAVIGATION */

        .navigation {
            display: flex;
            gap: 10px;
            margin-top: 28px;
            flex-wrap: wrap;
            position: relative;
            z-index: 2;
        }

        .navigation a {
            text-decoration: none;
            color: white;
            padding: 11px 20px;
            border-radius: 12px;
            border: 1px solid rgba(255,255,255,0.35);
            background: rgba(255,255,255,0.10);
            font-weight: bold;
            transition: 0.25s;
        }

        .navigation a:hover {
            background: white;
            color: #5b32d6;
            transform: translateY(-2px);
        }

        .navigation .active {
            background: white;
            color: #5b32d6;
        }

        /* SUMMARY */

        .summary {
            background: white;
            border-radius: 22px;
            padding: 25px 30px;
            margin-bottom: 22px;
            box-shadow: 0 8px 25px rgba(30, 41, 59, 0.08);
            display: flex;
            align-items: center;
            justify-content: space-between;
        }

        .summary-title {
            font-size: 15px;
            color: #64748b;
            margin-bottom: 5px;
        }

        .summary-value {
            font-size: 30px;
            font-weight: bold;
            color: #5b32d6;
        }

        .summary-icon {
            width: 58px;
            height: 58px;
            border-radius: 16px;
            background: #eee8ff;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 28px;
        }

        /* EXPENSE CARD */

        .expense-card {
            background: white;
            border-radius: 22px;
            padding: 28px;
            box-shadow: 0 8px 25px rgba(30, 41, 59, 0.08);
            overflow-x: auto;
        }

        .section-heading {
            display: flex;
            align-items: center;
            justify-content: space-between;
            margin-bottom: 22px;
        }

        .section-heading h2 {
            margin: 0;
            font-size: 22px;
        }

        .section-heading span {
            color: #64748b;
            font-size: 14px;
        }

        /* GRIDVIEW */

        .grid {
            width: 100%;
            border-collapse: separate;
            border-spacing: 0;
            overflow: hidden;
            border-radius: 14px;
            border: 1px solid #e5e7eb;
        }

        .grid th {
            background: linear-gradient(135deg, #6d35d8, #5145cd);
            color: white;
            padding: 15px 14px;
            text-align: left;
            font-size: 14px;
            border: none;
        }

        .grid td {
            padding: 15px 14px;
            border-bottom: 1px solid #edf0f5;
            color: #334155;
            background: white;
        }

        .grid tr:last-child td {
            border-bottom: none;
        }

        .grid tr:hover td {
            background: #f8f6ff;
        }

        /* CATEGORY BADGE */

        .category {
            display: inline-block;
            padding: 6px 11px;
            border-radius: 20px;
            background: #eee8ff;
            color: #5b32d6;
            font-size: 13px;
            font-weight: bold;
        }

        /* MOBILE */

        @media (max-width: 700px) {

            body {
                padding: 15px;
            }

            .hero {
                padding: 25px;
            }

            .hero h1 {
                font-size: 28px;
            }

            .summary {
                padding: 20px;
            }

            .expense-card {
                padding: 18px;
            }

            .navigation a {
                flex: 1;
                text-align: center;
            }
        }

    </style>

</head>

<body>

<form id="form1" runat="server">

<div class="container">

    <!-- HEADER -->

    <div class="hero">

        <div class="brand">
            🤖 AI EXPENSE TRACKER
        </div>

        <h1>Expense History</h1>

        <p>
            View, organize and understand all your recorded expenses.
        </p>

        <div class="navigation">

            <a href="Dashboard.aspx">
                🏠 Dashboard
            </a>

            <a href="AddExpense.aspx">
                ➕ Add Expense
            </a>

            <a href="Expenses.aspx" class="active">
                📋 Expenses
            </a>

            <a href="AIAnalysis.aspx">
                🤖 AI Analysis
            </a>

        </div>

    </div>


    <!-- TOTAL SPENDING -->

    <div class="summary">

        <div>

            <div class="summary-title">
                TOTAL SPENDING
            </div>

            <asp:Label
                ID="lblTotal"
                runat="server"
                CssClass="summary-value"
                Text="₹ 0.00">
            </asp:Label>

        </div>

        <div class="summary-icon">
            💰
        </div>

    </div>


    <!-- EXPENSE TABLE -->

    <div class="expense-card">

        <div class="section-heading">

            <div>
                <h2>📋 Your Expenses</h2>

                <span>
                    Complete record of your spending
                </span>
            </div>

        </div>


        <asp:GridView
            ID="gvExpenses"
            runat="server"
            AutoGenerateColumns="False"
            CssClass="grid"
            GridLines="None">

            <Columns>

                <asp:BoundField
                    DataField="ExpenseDate"
                    HeaderText="📅 Date"
                    DataFormatString="{0:dd-MM-yyyy}" />

                <asp:BoundField
                    DataField="Title"
                    HeaderText="📝 Expense" />

                <asp:TemplateField HeaderText="🏷️ Category">

                    <ItemTemplate>

                        <span class="category">
                            <%# Eval("Category") %>
                        </span>

                    </ItemTemplate>

                </asp:TemplateField>

                <asp:BoundField
                    DataField="Amount"
                    HeaderText="💰 Amount"
                    DataFormatString="₹ {0:N2}" />

                <asp:BoundField
                    DataField="Notes"
                    HeaderText="📌 Notes" />

            </Columns>

        </asp:GridView>

    </div>

</div>

</form>

</body>

</html>