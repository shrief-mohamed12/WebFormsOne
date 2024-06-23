<%@ Page Title="Home Page" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="WebFormsOne._Default" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

    <script src="Scripts/jquery-1.7.1.js"></script>
    <script language="javascript">
        $(document).ready(function () {
            var gridHeader = $('#<%=GridView1.ClientID%>').clone(true); // Here Clone Copy of Gridview with style
                    $(gridHeader).find("tr:gt(0)").remove(); // Here remove all rows except first row (header row)
                    $('#<%=GridView1.ClientID%> tr th').each(function (i) {
                        // Here Set Width of each th from gridview to new table(clone table) th 
                        $("th:nth-child(" + (i + 1) + ")", gridHeader).css('width', ($(this).width()).toString() + "px");
                    });
                    $("#GHead").append(gridHeader);
                    $('#GHead').css('position', 'absolute');
                    $('#GHead').css('top', $('#<%=GridView1.ClientID%>').offset().top);
                });
    </script>



    <main>
        <h3>Scrollable Gridview with fixed header in ASP.NET</h3>
        <br />
        <div style="width: 1000px;">
            <div id="GHead"></div>
            <%-- This GHead is added for Store Gridview Header  --%>
            <div style="height: 300px; overflow: auto">
                <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="false"
                    CellPadding="5" HeaderStyle-BackColor="#f3f3f3">
                    <Columns>
                        <asp:BoundField DataField="Grade" HeaderText="Grade" />
                        <asp:BoundField DataField="GradeName" HeaderText="Grade Name" />
                        <asp:BoundField DataField="GradeGroupName" HeaderText="Grade Group Name" />
                        <asp:BoundField DataField="GradeCons" HeaderText="Consideration Code" />
                        <asp:BoundField DataField="GradeNameCons" HeaderText="Consideration Name" />
                    </Columns>

                </asp:GridView>
            </div>
        </div>
    </main>



</asp:Content>
