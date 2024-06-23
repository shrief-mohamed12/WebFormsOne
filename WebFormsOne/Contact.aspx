<%@ Page Title="Contact" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Contact.aspx.cs" Inherits="WebFormsOne.Contact" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <main aria-labelledby="title">
        <h2 id="title"><%: Title %>.</h2>
        <h3>Your contact page.</h3>
        <address>
            One Microsoft Way<br />
            Redmond, WA 98052-6399<br />
            <abbr title="Phone">P:</abbr>
            425.555.0100
        </address>

        <address>
            <strong>Support:</strong>   <a href="mailto:Support@example.com">Support@example.com</a><br />
            <strong>Marketing:</strong> <a href="mailto:Marketing@example.com">Marketing@example.com</a>
        </address>
    </main>
</asp:Content>





&lt;!DOCTYPE html&gt;
&lt;html&gt;
&lt;head&gt;
    &lt;script src="jquery-1.11.2.js"&gt;&lt;/script&gt;
    &lt;script type="text/javascript"&gt;
        $(document).ready(function () {
            var currentPage = 1;
            loadPageData(currentPage);
            $(window).scroll(function () {
                if ($(window).scrollTop() == $(document).height() - $(window).height()) {
                    currentPage += 1;
                    loadPageData(currentPage);
                }
            });

            function loadPageData(currentPageNumber) {
                $.ajax({
                    url: 'EmployeeService.asmx/GetEmployees',
                    method: 'post',
                    dataType: "json",
                    data: { pageNumber: currentPageNumber, pageSize: 50 },
                    success: function (data) {
                        var employeeTable = $('#tblEmployee tbody');

                        $(data).each(function (index, emp) {
                            employeeTable.append('&lt;tr&gt;&lt;td&gt;' + emp.ID + '&lt;/td&gt;&lt;td&gt;'
                                + emp.Name + '&lt;/td&gt;&lt;td&gt;' + emp.Gender
                                + '&lt;/td&gt;&lt;td&gt;' + emp.Salary + '&lt;/td&gt;&lt;/tr&gt;');
                        });
                    },
                    error: function (err) {
                        alert(err);
                    }
                });
            }
        });
    &lt;/script&gt;
&lt;/head&gt;
&lt;body style="font-family:Arial"&gt;
    &lt;h1&gt;The data will be loaded on demand as you scroll down the page&lt;/h1&gt;
    &lt;table id="tblEmployee" border="1" style="border-collapse:collapse; font-size:xx-large"&gt;
        &lt;thead&gt;
            &lt;tr&gt;
                &lt;th&gt;ID&lt;/th&gt;
                &lt;th&gt;Name&lt;/th&gt;
                &lt;th&gt;Gender&lt;/th&gt;
                &lt;th&gt;Salary&lt;/th&gt;
            &lt;/tr&gt;
        &lt;/thead&gt;
        &lt;tbody&gt;&lt;/tbody&gt;
    &lt;/table&gt;
&lt;/body&gt;
&lt;/html&gt;