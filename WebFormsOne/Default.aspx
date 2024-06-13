<%@ Page Title="Home Page" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="WebFormsOne._Default" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

    <main>
        <script src="Scripts/jquery-3.7.0.js"></script>
        <script language="javascript">
            $(document).ready(function () {
                $('#dvGrid').bind('scroll', function () {
                    if ($(this).scrollTop() + $(this).innerHeight() >= $(this)[0].scrollHeight) {
                        var pageIndex = parseInt($('#<%=hfPageIndex.ClientID%>').val());
                    var totalPage = parseInt($('#<%=hfTotalPage.ClientID%>').val());
                    if (pageIndex < totalPage) {
                        // Show loading...
                        $('#LoadingPanel').css('display', 'block');
                        pageIndex = pageIndex + 1;
                        $('#<%=hfPageIndex.ClientID%>').val(pageIndex.toString());
                        // Call function to load more data
                        populateData(pageIndex);
                    }
                }
            });
        });

            function populateData(pageIndex) {
                // Populate data from database
                $.ajax({
                    url: "Default.aspx/PopulateDataByJquery",
                    data: JSON.stringify({ pageNo: pageIndex, noOfRecord: 50 }),
                    type: "POST",
                    dataType: "json",
                    contentType: "application/json; charset=utf-8",
                    success: OnSuccess,
                    error: onError
                });
            }

            function OnSuccess(data) {
                var d = data.d;
                for (var i = 0; i < d.length; i++) {
                    var row = $('#<%=GridView1.ClientID%> tr:last').clone(); // Clone the last row of the GridView
            $("td:nth-child(1)", row).html(d[i].Grade);
            $("td:nth-child(2)", row).html(d[i].GradeName);
            $("td:nth-child(3)", row).html(d[i].GradeGroupName);
            $("td:nth-child(4)", row).html(d[i].GradeCons);
            $("td:nth-child(5)", row).html(d[i].GradeNameCons);
            $('#<%=GridView1.ClientID%>').append(row); // Append the cloned row
                }
                $('#LoadingPanel').css('display', 'none');
            }

            function onError() {
                alert('Failed!');
                $('#LoadingPanel').css('display', 'none');
            }
        </script>



        <h3>Load Gridview rows on demand from database through scrolling in ASP.NET</h3>
        <div style="height: 30px;">
            <span id="LoadingPanel" style="color: red; font-weight: bold; display: none;">Please Wait...
            </span>
        </div>
        <div id="dvGrid" style="height: 500px; overflow: auto; width: 800px">
            <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="false">
                <Columns>
                    <asp:BoundField DataField="Grade" HeaderText="Grade" />
                    <asp:BoundField DataField="GradeName" HeaderText="GradeName" />
                    <asp:BoundField DataField="GradeGroupName" HeaderText="GradeGroupName" />
                    <asp:BoundField DataField="GradeCons" HeaderText="Considiration Code" />
                    <asp:BoundField DataField="GradeNameCons" HeaderText=" Considiration Name" />
                </Columns>
            </asp:GridView>
            <br />
            <%-- Here i have added 2 hidden fields for store current page & total page no --%>
            <asp:HiddenField ID="hfPageIndex" runat="server" Value="1" />
            <asp:HiddenField ID="hfTotalPage" runat="server" Value="0" />
            <br />
        </div>

    </main>

</asp:Content>
