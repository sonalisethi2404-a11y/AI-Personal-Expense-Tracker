<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="AddExpense.aspx.cs" Inherits="AIExpenseTracker.AddExpense" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>AI Expense Tracker - Add Expense</title>

    <style>

        * {
            box-sizing: border-box;
        }

        body {
            margin: 0;
            font-family: Arial, sans-serif;
            background: #f3f4ff;
            color: #172033;
            padding: 35px;
        }

        .page {
            max-width: 1100px;
            margin: auto;
        }

        /* HEADER */

        .header {
            background: linear-gradient(135deg, #6d28d9, #7c3aed, #4f46e5);
            color: white;
            padding: 30px 40px;
            border-radius: 24px;
            box-shadow: 0 15px 35px rgba(91, 63, 190, 0.25);
            margin-bottom: 30px;
        }

        .brand {
            font-size: 14px;
            font-weight: bold;
            letter-spacing: 1px;
            opacity: 0.9;
        }

        .header h1 {
            margin: 12px 0 8px;
            font-size: 34px;
        }

        .header p {
            margin: 0 0 22px;
            opacity: 0.9;
        }

        /* NAVIGATION */

        .navigation {
            display: flex;
            gap: 10px;
            flex-wrap: wrap;
        }

        .navigation a {
            text-decoration: none;
            color: white;
            padding: 11px 18px;
            border-radius: 12px;
            border: 1px solid rgba(255,255,255,0.35);
            background: rgba(255,255,255,0.12);
            font-weight: bold;
            transition: 0.25s;
        }

        .navigation a:hover {
            background: white;
            color: #6d28d9;
            transform: translateY(-2px);
        }

        .navigation .active {
            background: white;
            color: #6d28d9;
        }

        /* MAIN AREA */

        .content {
            display: grid;
            grid-template-columns: 1.4fr 0.8fr;
            gap: 25px;
        }

        /* FORM CARD */

        .form-card {
            background: white;
            border-radius: 22px;
            padding: 35px;
            box-shadow: 0 12px 30px rgba(30, 41, 59, 0.08);
        }

        .form-card h2 {
            margin-top: 0;
            font-size: 25px;
        }

        .form-subtitle {
            color: #64748b;
            margin-bottom: 28px;
        }

        .field {
            margin-bottom: 20px;
        }

        label {
            display: block;
            font-weight: bold;
            margin-bottom: 8px;
            color: #334155;
        }

        .required {
            color: #ef4444;
        }

        input,
        select,
        textarea {
            width: 100%;
            padding: 13px 15px;
            border: 1px solid #d8def0;
            border-radius: 12px;
            font-size: 15px;
            background: #fafbff;
            outline: none;
            transition: 0.25s;
        }

        input:focus,
        select:focus,
        textarea:focus {
            border-color: #7c3aed;
            background: white;
            box-shadow: 0 0 0 4px rgba(124,58,237,0.10);
        }

        textarea {
            min-height: 100px;
            resize: vertical;
        }

        /* AMOUNT */

        .amount-box {
            position: relative;
        }

        .amount-symbol {
            position: absolute;
            left: 15px;
            top: 13px;
            font-weight: bold;
            color: #6d28d9;
        }

        .amount-input {
            padding-left: 35px;
        }

        /* BUTTON */

        .add-button {
            width: 100%;
            border: none;
            padding: 15px;
            border-radius: 13px;
            background: linear-gradient(135deg, #7c3aed, #4f46e5);
            color: white;
            font-size: 16px;
            font-weight: bold;
            cursor: pointer;
            box-shadow: 0 8px 18px rgba(99, 66, 190, 0.25);
            transition: 0.25s;
        }

        .add-button:hover {
            transform: translateY(-2px);
            box-shadow: 0 12px 24px rgba(99, 66, 190, 0.35);
        }

        /* MESSAGE */

        .message {
            display: block;
            margin-top: 15px;
            text-align: center;
            font-weight: bold;
            color: #16a34a;
        }

        /* SIDE CARD */

        .side-card {
            background: linear-gradient(145deg, #ffffff, #f5f3ff);
            border-radius: 22px;
            padding: 30px;
            box-shadow: 0 12px 30px rgba(30, 41, 59, 0.08);
            height: fit-content;
        }

        .side-icon {
            width: 60px;
            height: 60px;
            border-radius: 18px;
            background: #ede9fe;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 30px;
            margin-bottom: 20px;
        }

        .side-card h2 {
            margin: 0 0 10px;
        }

        .side-card p {
            color: #64748b;
            line-height: 1.6;
        }

        .tips {
            margin-top: 25px;
        }

        .tip {
            display: flex;
            gap: 10px;
            margin-bottom: 15px;
            padding: 12px;
            background: white;
            border-radius: 12px;
        }

        .tip-icon {
            font-size: 20px;
        }

        /* MOBILE */

        @media (max-width: 800px) {

            body {
                padding: 18px;
            }

            .content {
                grid-template-columns: 1fr;
            }

            .header h1 {
                font-size: 27px;
            }

        }

    </style>
</head>

<body>

<form id="form1" runat="server">

<div class="page">

    <!-- HEADER -->

    <div class="header">

        <div class="brand">🤖 AI EXPENSE TRACKER</div>

        <h1>Add a New Expense</h1>

        <p>Record your spending and keep your finances organized.</p>

        <div class="navigation">

            <a href="Dashboard.aspx">🏠 Dashboard</a>

            <a href="AddExpense.aspx" class="active">➕ Add Expense</a>

            <a href="Expenses.aspx">📋 Expenses</a>

            <a href="AIAnalysis.aspx">🤖 AI Analysis</a>

        </div>

    </div>


    <!-- CONTENT -->

    <div class="content">

        <!-- FORM -->

        <div class="form-card">

            <h2>💳 Expense Details</h2>

            <div class="form-subtitle">
                Enter the details of your expense below.
            </div>


            <div class="field">

                <label>
                    📅 Expense Date <span class="required">*</span>
                </label>

                <asp:TextBox
                    ID="txtExpenseDate"
                    runat="server"
                    TextMode="Date">
                </asp:TextBox>

            </div>


            <div class="field">

                <label>
                    📝 Expense Title <span class="required">*</span>
                </label>

                <asp:TextBox
                    ID="txtTitle"
                    runat="server"
                    placeholder="e.g. College Lunch">
                </asp:TextBox>

            </div>


            <div class="field">

                <label>
                    🏷️ Category <span class="required">*</span>
                </label>

                <asp:DropDownList
                    ID="ddlCategory"
                    runat="server">

                    <asp:ListItem Text="Select Category" Value=""></asp:ListItem>
                    <asp:ListItem Text="🍔 Food" Value="Food"></asp:ListItem>
                    <asp:ListItem Text="🚌 Travel" Value="Travel"></asp:ListItem>
                    <asp:ListItem Text="📚 Education" Value="Education"></asp:ListItem>
                    <asp:ListItem Text="🛍️ Shopping" Value="Shopping"></asp:ListItem>
                    <asp:ListItem Text="💡 Bills" Value="Bills"></asp:ListItem>
                    <asp:ListItem Text="🎯 Other" Value="Other"></asp:ListItem>

                </asp:DropDownList>

            </div>


            <div class="field">

                <label>
                    💰 Amount <span class="required">*</span>
                </label>

                <div class="amount-box">

                    <span class="amount-symbol">₹</span>

                    <asp:TextBox
                        ID="txtAmount"
                        runat="server"
                        CssClass="amount-input"
                        placeholder="0.00">
                    </asp:TextBox>

                </div>

            </div>


            <div class="field">

                <label>
                    🗒️ Notes
                </label>

                <asp:TextBox
                    ID="txtNotes"
                    runat="server"
                    TextMode="MultiLine"
                    placeholder="Add any additional details...">
                </asp:TextBox>

            </div>


            <asp:Button
                ID="btnAdd"
                runat="server"
                Text="➕ Add Expense"
                CssClass="add-button"
                OnClick="btnAddExpense_Click" />

            <asp:Label
                ID="lblMessage"
                runat="server"
                CssClass="message">
            </asp:Label>

        </div>


        <!-- SIDE INFORMATION -->

        <div class="side-card">

            <div class="side-icon">💡</div>

            <h2>Smart Spending</h2>

            <p>
                Keep your expenses updated to get better insights
                from the AI analysis feature.
            </p>

            <div class="tips">

                <div class="tip">
                    <span class="tip-icon">📊</span>
                    <span>Track every expense to understand your spending.</span>
                </div>

                <div class="tip">
                    <span class="tip-icon">🎯</span>
                    <span>Use categories to organize your expenses.</span>
                </div>

                <div class="tip">
                    <span class="tip-icon">🤖</span>
                    <span>AI Analysis can identify spending patterns.</span>
                </div>

                <div class="tip">
                    <span class="tip-icon">💰</span>
                    <span>Find areas where you may be able to save.</span>
                </div>

            </div>

        </div>

    </div>

</div>

</form>

</body>
</html>