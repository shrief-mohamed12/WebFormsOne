using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Data;
using System.Linq;
using System.Runtime.InteropServices.ComTypes;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Services;

namespace WebFormsOne
{
    public partial class _Default : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                PopulateData();
         
            }

        }
        [WebMethod]
       private void PopulateData()
            {
                using (MyDatabaseEntities dc = new MyDatabaseEntities())
                {
                    GridView1.DataSource = dc.MyTables.ToList();
                    GridView1.DataBind();
                }
            }

       
      
    }
}