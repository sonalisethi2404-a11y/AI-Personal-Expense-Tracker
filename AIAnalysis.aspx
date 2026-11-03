<%@ Page Language="C#" Async="true" AutoEventWireup="true" CodeBehind="AIAnalysis.aspx.cs" Inherits="AIExpenseTracker.AIAnalysis" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">

<head runat="server">
    <meta charset="utf-8" />

    <title>AI Expense Analysis</title>

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
            max-width: 1100px;
            margin: auto;
        }

        /* ---------- HERO ---------- */

        .hero {
            position: relative;
            overflow: hidden;
            padding: 35px 40px;
            border-radius: 26px;
            background: linear-gradient(135deg, #6d28d9, #4f46e5);
            color: white;
            box-shadow: 0 18px 40px rgba(79, 70, 229, 0.25);
            margin-bottom: 28px;
        }

        .hero:before {
            content: "";
            position: absolute;
            width: 180px;
            height: 180px;
            border-radius: 50%;
            background: rgba(255,255,255,0.08);
            right: -45px;
            top: -70px;
        }

        .hero:after {
            content: "";
            position: absolute;
            width: 120px;
            height: 120px;
            border-radius: 50%;
            background: rgba(255,255,255,0.07);
            left: -50px;
            bottom: -70px;
        }

        .brand {
            position: relative;
            z-index: 2;
            font-size: 15px;
            font-weight: bold;
            letter-spacing: 1px;
            margin-bottom: 15px;
        }

        .hero h1 {
            position: relative;
            z-index: 2;
            margin: 0;
            font-size: 38px;
        }

        .hero p {
            position: relative;
            z-index: 2;
            margin-top: 12px;
            font-size: 17px;
            opacity: 0.92;
        }

        /* ---------- NAVIGATION ---------- */

        .navigation {
            position: relative;
            z-index: 3;
            display: flex;
            gap: 10px;
            flex-wrap: wrap;
            margin-top: 25px;
        }

        .navigation a {
            text-decoration: none;
            color: white;
            border: 1px solid rgba(255,255,255,0.35);
            padding: 11px 20px;
            border-radius: 12px;
            font-weight: bold;
            transition: 0.2s;
            background: rgba(255,255,255,0.08);
        }

        .navigation a:hover {
            background: white;
            color: #5b21b6;
            transform: translateY(-2px);
        }

        .navigation .active {
            background: white;
            color: #5b21b6;
        }

        /* ---------- MAIN CARD ---------- */

        .analysis-card {
            background: white;
            border-radius: 24px;
            padding: 35px;
            box-shadow: 0 12px 35px rgba(31, 41, 55, 0.10);
        }

        .section-header {
            display: flex;
            align-items: center;
            gap: 15px;
            margin-bottom: 10px;
        }

        .section-icon {
            width: 55px;
            height: 55px;
            border-radius: 16px;
            background: #ede9fe;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 28px;
        }

        .section-header h2 {
            margin: 0;
            font-size: 25px;
        }

        .description {
            color: #64748b;
            margin-left: 70px;
            margin-bottom: 28px;
            font-size: 15px;
        }

        /* ---------- AI INFO ---------- */

        .ai-info {
            display: grid;
            grid-template-columns: repeat(3, 1fr);
            gap: 15px;
            margin-bottom: 28px;
        }

        .info-box {
            padding: 20px;
            border-radius: 16px;
            background: #f8f7ff;
            border: 1px solid #ebe7ff;
        }

        .info-icon {
            font-size: 25px;
            margin-bottom: 8px;
        }

        .info-box strong {
            display: block;
            margin-bottom: 5px;
            color: #4c1d95;
        }

        .info-box span {
            color: #64748b;
            font-size: 14px;
        }

        /* ---------- BUTTON ---------- */

        .button-area {
            text-align: center;
            margin: 25px 0;
        }

        .button {
            border: none;
            border-radius: 14px;
            padding: 15px 32px;
            font-size: 16px;
            font-weight: bold;
            color: white;
            background: linear-gradient(135deg, #7c3aed, #4f46e5);
            cursor: pointer;
            box-shadow: 0 8px 20px rgba(99, 102, 241, 0.28);
            transition: 0.2s;
        }

        .button:hover {
            transform: translateY(-2px);
            box-shadow: 0 12px 25px rgba(99, 102, 241, 0.35);
        }

        /* ---------- RESULT ---------- */

        .result-title {
            margin-top: 30px;
            margin-bottom: 12px;
            font-size: 21px;
            font-weight: bold;
        }

        .result {
            min-height: 100px;
            padding: 25px;
            border-radius: 18px;
            background: #f8f8ff;
            border-left: 5px solid #673ab7;
            white-space: pre-wrap;
            overflow-wrap: break-word;
            line-height: 1.7;
            font-size: 15px;
            color: #222;
            box-shadow: inset 0 0 0 1px #eeeaff;
        }

        /* ---------- FOOTER ---------- */

        .footer {
            text-align: center;
            margin-top: 25px;
            color: #64748b;
            font-size: 13px;
        }

        /* ---------- RESPONSIVE ---------- */

        @media (max-width: 750px) {

            body {
                padding: 15px;
            }

            .hero {
                padding: 28px 22px;
            }

            .hero h1 {
                font-size: 30px;
            }

            .ai-info {
                grid-template-columns: 1fr;
            }

            .analysis-card {
                padding: 22px;
            }

            .description {
                margin-left: 0;
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

        <!-- HERO SECTION -->

        <div class="hero">

            <div class="brand">
                🤖 AI EXPENSE TRACKER
            </div>

            <h1>AI Expense Analysis</h1>

            <p>
                Understand your spending, discover patterns and find
                smarter ways to save.
            </p>

            <!-- NAVIGATION -->

            <div class="navigation">

                <a href="Dashboard.aspx">
                    🏠 Dashboard
                </a>

                <a href="AddExpense.aspx">
                    ➕ Add Expense
                </a>

                <a href="Expenses.aspx">
                    📋 Expenses
                </a>

                <a href="AIAnalysis.aspx" class="active">
                    🤖 AI Analysis
                </a>

            </div>

        </div>


        <!-- MAIN ANALYSIS CARD -->

        <div class="analysis-card">

            <div class="section-header">

                <div class="section-icon">
                    🤖
                </div>

                <div>
                    <h2>Smart Spending Insights</h2>
                </div>

            </div>

            <div class="description">

                Analyze your recorded expenses using the local
                <strong>Llama 3.2</strong> AI model and receive
                personalized spending insights.

            </div>


            <!-- AI INFORMATION -->

            <div class="ai-info">

                <div class="info-box">

                    <div class="info-icon">📊</div>

                    <strong>Spending Analysis</strong>

                    <span>
                        Understand where your money is being spent.
                    </span>

                </div>


                <div class="info-box">

                    <div class="info-icon">🔍</div>

                    <strong>Pattern Detection</strong>

                    <span>
                        Identify your highest spending categories.
                    </span>

                </div>


                <div class="info-box">

                    <div class="info-icon">💡</div>

                    <strong>Saving Suggestions</strong>

                    <span>
                        Get practical ideas to reduce unnecessary spending.
                    </span>

                </div>

            </div>


            <!-- ANALYZE BUTTON -->

            <div class="button-area">

                <asp:Button
                    ID="btnAnalyze"
                    runat="server"
                    Text="🤖  Analyze My Expenses"
                    CssClass="button"
                    OnClick="btnAnalyze_Click" />

            </div>


            <!-- RESULT -->

            <div class="result-title">
                ✨ AI Analysis Result
            </div>

            <div
                id="lblResult"
                runat="server"
                class="result">
            </div>


        </div>


        <div class="footer">

            Powered by local AI • AI Expense Tracker

        </div>

    </div>

</form>

</body>

</html>