<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Dashboard.aspx.cs" Inherits="AIExpenseTracker.Dashboard" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">

    <title>AI Expense Tracker</title>

    <style>

        * {
            box-sizing: border-box;
        }

        body {
            margin: 0;
            padding: 0;
            font-family: "Segoe UI", Arial, sans-serif;
            background: linear-gradient(135deg, #f5f3ff, #eef2ff, #f8fafc);
            color: #1f2937;
        }

        .page {
            max-width: 1200px;
            margin: 0 auto;
            padding: 35px 25px 50px;
        }

        /* HERO HEADER */

        .hero {
            background: linear-gradient(135deg, #6d28d9, #7c3aed, #4f46e5);
            color: white;
            padding: 35px 40px;
            border-radius: 24px;
            position: relative;
            overflow: hidden;
            box-shadow: 0 15px 35px rgba(79, 70, 229, 0.25);
        }

        .hero::before {
            content: "";
            position: absolute;
            width: 220px;
            height: 220px;
            border-radius: 50%;
            background: rgba(255,255,255,0.08);
            top: -100px;
            right: -50px;
        }

        .hero::after {
            content: "";
            position: absolute;
            width: 160px;
            height: 160px;
            border-radius: 50%;
            background: rgba(255,255,255,0.06);
            bottom: -90px;
            left: -40px;
        }

        .hero-content {
            position: relative;
            z-index: 2;
        }

        .brand {
            font-size: 15px;
            font-weight: 600;
            letter-spacing: 1px;
            opacity: 0.9;
            margin-bottom: 10px;
        }

        .hero h1 {
            margin: 0;
            font-size: 38px;
            font-weight: 700;
        }

        .hero p {
            margin: 10px 0 0;
            font-size: 16px;
            opacity: 0.9;
        }

        /* NAVIGATION */

        .navigation {
            display: flex;
            flex-wrap: wrap;
            gap: 10px;
            margin-top: 28px;
        }

        .nav-btn {
            display: inline-flex;
            align-items: center;
            justify-content: center;
            gap: 7px;
            padding: 11px 18px;
            border-radius: 12px;
            text-decoration: none;
            color: white;
            background: rgba(255,255,255,0.14);
            border: 1px solid rgba(255,255,255,0.22);
            font-size: 14px;
            font-weight: 600;
            transition: all 0.25s ease;
            backdrop-filter: blur(8px);
        }

        .nav-btn:hover {
            background: white;
            color: #5b21b6;
            transform: translateY(-2px);
        }

        .nav-btn.active {
            background: white;
            color: #5b21b6;
        }

        /* WELCOME */

        .welcome {
            margin: 35px 0 20px;
        }

        .welcome h2 {
            margin: 0;
            font-size: 25px;
            color: #111827;
        }

        .welcome p {
            margin-top: 6px;
            color: #6b7280;
        }

        /* STAT CARDS */

        .stats {
            display: grid;
            grid-template-columns: repeat(3, 1fr);
            gap: 20px;
        }

        .stat-card {
            background: rgba(255,255,255,0.9);
            border: 1px solid #e5e7eb;
            border-radius: 20px;
            padding: 25px;
            position: relative;
            overflow: hidden;
            box-shadow: 0 8px 25px rgba(15,23,42,0.07);
            transition: all 0.25s ease;
        }

        .stat-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 15px 30px rgba(15,23,42,0.12);
        }

        .stat-icon {
            width: 48px;
            height: 48px;
            border-radius: 14px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 23px;
            background: #ede9fe;
            margin-bottom: 18px;
        }

        .stat-title {
            color: #6b7280;
            font-size: 14px;
            font-weight: 600;
            margin-bottom: 8px;
        }

        .stat-value {
            color: #111827;
            font-size: 28px;
            font-weight: 700;
        }

        /* LOWER CARDS */

        .content-grid {
            display: grid;
            grid-template-columns: 1.4fr 1fr;
            gap: 20px;
            margin-top: 20px;
        }

        .content-card {
            background: rgba(255,255,255,0.92);
            border: 1px solid #e5e7eb;
            border-radius: 20px;
            padding: 28px;
            box-shadow: 0 8px 25px rgba(15,23,42,0.07);
        }

        .card-heading {
            display: flex;
            align-items: center;
            gap: 12px;
            margin-bottom: 20px;
        }

        .card-icon {
            width: 44px;
            height: 44px;
            border-radius: 12px;
            background: #ede9fe;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 21px;
        }

        .card-heading h3 {
            margin: 0;
            font-size: 18px;
            color: #111827;
        }

        .card-heading p {
            margin: 3px 0 0;
            color: #9ca3af;
            font-size: 13px;
        }

        .category-value {
            font-size: 20px;
            font-weight: 600;
            line-height: 1.9;
            color: #374151;
            white-space: pre-line;
        }

        .monthly-box {
            text-align: center;
            padding: 25px 10px;
        }

        .monthly-label {
            color: #6b7280;
            font-size: 14px;
            font-weight: 600;
        }

        .monthly-value {
            margin-top: 12px;
            font-size: 38px;
            font-weight: 750;
            color: #5b21b6;
        }

        .monthly-note {
            margin-top: 8px;
            font-size: 13px;
            color: #9ca3af;
        }

        /* FOOTER */

        .footer {
            text-align: center;
            margin-top: 35px;
            color: #9ca3af;
            font-size: 13px;
        }

        /* RESPONSIVE */

        @media (max-width: 800px) {

            .stats {
                grid-template-columns: 1fr;
            }

            .content-grid {
                grid-template-columns: 1fr;
            }

            .hero h1 {
                font-size: 30px;
            }

            .page {
                padding: 20px 15px 35px;
            }
        }

    </style>

</head>

<body>

<form id="form1" runat="server">

    <div class="page">

        <!-- HERO -->

        <section class="hero">

            <div class="hero-content">

                <div class="brand">
                    🤖 AI EXPENSE TRACKER
                </div>

                <h1>Smart Personal Finance</h1>

                <p>
                    Track your expenses, understand your spending and make smarter financial decisions.
                </p>

                <!-- NAVIGATION -->

                <div class="navigation">

                    <a href="Dashboard.aspx" class="nav-btn active">
                        🏠 Dashboard
                    </a>

                    <a href="AddExpense.aspx" class="nav-btn">
                        ➕ Add Expense
                    </a>

                    <a href="Expenses.aspx" class="nav-btn">
                        📋 Expenses
                    </a>

                    <a href="AIAnalysis.aspx" class="nav-btn">
                        🤖 AI Analysis
                    </a>

                </div>

            </div>

        </section>


        <!-- WELCOME -->

        <div class="welcome">

            <h2>Welcome back 👋</h2>

            <p>
                Here's an overview of your spending activity.
            </p>

        </div>


        <!-- STATISTICS -->

        <div class="stats">

            <div class="stat-card">

                <div class="stat-icon">
                    💰
                </div>

                <div class="stat-title">
                    TOTAL SPENDING
                </div>

                <div class="stat-value">
                    <asp:Label
                        ID="lblTotal"
                        runat="server"
                        Text="₹ 0.00">
                    </asp:Label>
                </div>

            </div>


            <div class="stat-card">

                <div class="stat-icon">
                    🧾
                </div>

                <div class="stat-title">
                    TOTAL EXPENSES
                </div>

                <div class="stat-value">
                    <asp:Label
                        ID="lblCount"
                        runat="server"
                        Text="0">
                    </asp:Label>
                </div>

            </div>


            <div class="stat-card">

                <div class="stat-icon">
                    🏷️
                </div>

                <div class="stat-title">
                    TOP CATEGORY
                </div>

                <div class="stat-value">
                    <asp:Label
                        ID="lblTopCategory"
                        runat="server"
                        Text="No data">
                    </asp:Label>
                </div>

            </div>

        </div>


        <!-- LOWER INFORMATION CARDS -->

        <div class="content-grid">


            <!-- CATEGORY -->

            <div class="content-card">

                <div class="card-heading">

                    <div class="card-icon">
                        📊
                    </div>

                    <div>

                        <h3>Category-wise Spending</h3>

                        <p>
                            See where your money is going
                        </p>

                    </div>

                </div>

                <div class="category-value">

                    <asp:Label
                        ID="lblCategoryWise"
                        runat="server"
                        Text="No data">
                    </asp:Label>

                </div>

            </div>


            <!-- MONTHLY -->

            <div class="content-card">

                <div class="card-heading">

                    <div class="card-icon">
                        📅
                    </div>

                    <div>

                        <h3>This Month</h3>

                        <p>
                            Current monthly spending
                        </p>

                    </div>

                </div>

                <div class="monthly-box">

                    <div class="monthly-label">
                        TOTAL THIS MONTH
                    </div>

                    <div class="monthly-value">

                        <asp:Label
                            ID="lblMonthly"
                            runat="server"
                            Text="₹ 0.00">
                        </asp:Label>

                    </div>

                    <div class="monthly-note">
                        Keep tracking your expenses to stay in control.
                    </div>

                </div>

            </div>

        </div>


        <!-- FOOTER -->

        <div class="footer">

            AI Expense Tracker • Smart Spending • Powered by AI

        </div>

    </div>

</form>

</body>
</html>