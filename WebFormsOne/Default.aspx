<%@ Page Title="Home Page" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="WebFormsOne._Default" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

    <script src="Scripts/jquery-1.7.1.js"></script>
    <script language="javascript">
        $(document).ready(function () {
            $('#dvGrid').bind('scroll', function () {
                if ($(this).scrollTop() + $(this).innerHeight() >= $(this)[0].scrollHeight) {
                    var pageIndex = parseInt($('#<%=hfPageIndex.ClientID%>').val());
                    var totalPage = parseInt($('#<%=hfTotalPage.ClientID%>').val());
                    if (pageIndex < totalPage) {
                        // this is for check more data is exist to populate or not
                        // this is for show loading...
                        $('#LoadingPanel').css('display', 'block');
                        pageIndex = pageIndex + 1;
                        $('#<%=hfPageIndex.ClientID%>').val(pageIndex.toString());
                        // Call function here for load more data
                        populateData(pageIndex);
                    }
                }
            })
        });

        function populateData(pageIndex) {
            // populate data from database
            $.ajax({
                url: "Default.aspx/PopulateDataByJquery",
                data: "{pageNo: " + pageIndex + ", noOfRecord: 50}",
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
                var row = $('#<%=GridView1.ClientID%> tr').eq(1).clone(true); // here clone 2nd row on gridview
                $("td:nth-child(1)", row).html(d[i].StateID);
                $("td:nth-child(2)", row).html(d[i].Country);
                $("td:nth-child(3)", row).html(d[i].StateName);
                $('#<%=GridView1.ClientID%>').append(row); // This will Add to Existing Row
            }
            $('#LoadingPanel').css('display', 'none');
        }
        function onError() {
            alert('Failed!');
            $('#LoadingPanel').css('display', 'none');
        }

    </script>

    <main>
        <h3>Load Gridview rows on demand from database through scrolling in ASP.NET</h3>
        <div style="height: 30px;">
            <span id="LoadingPanel" style="color: red; font-weight: bold; display: none;">Please Wait...
            </span>
        </div>
        <div id="dvGrid" style="height: 300px; overflow: auto; width: 400px">
            <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="false"
                CellSpacing="5" Width="95%">

                <Columns>
                    <asp:BoundField DataField="Grade" HeaderText="Grade" />
                    <asp:BoundField DataField="GradeName" HeaderText="Grade Name" />
                    <asp:BoundField DataField="GradeGroupName" HeaderText="Grade Group Name" />
                    <asp:BoundField DataField="GradeCons" HeaderText="Consideration Code" />
                    <asp:BoundField DataField="GradeNameCons" HeaderText="Consideration Name" />
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
