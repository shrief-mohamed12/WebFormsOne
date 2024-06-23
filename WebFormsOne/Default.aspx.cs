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
                PopulateData(1, 50);

            }

        }
        private void PopulateData(int pageIndex, int noOfRecord)
        {
            int pageCount = 0;
            int totalRecord = 0;
            using (MyDatabaseEntities dc = new MyDatabaseEntities())
            {
                totalRecord = dc.MyTables.Count();
                List<MyTable> data = new List<MyTable>();
                int skip = (pageIndex - 1) * noOfRecord;
                data = dc.MyTables.OrderBy(a => a.Grade).Skip(skip).Take(noOfRecord).ToList();
                GridView1.DataSource = data;
                GridView1.DataBind();
            }
            if (totalRecord > 0 && noOfRecord > 0)
            {
                pageCount = (totalRecord / noOfRecord) + ((totalRecord % noOfRecord) > 0 ? 1 : 0);
                hfTotalPage.Value = pageCount.ToString();
            }
        }

        [WebMethod]
        public static List<MyTable> PopulateDataByJquery(int pageNo, int noOfRecord)
        {
            System.Threading.Thread.Sleep(2000);
            using (MyDatabaseEntities dc = new MyDatabaseEntities())
            {
                List<MyTable> data = new List<MyTable>();
                int skip = (pageNo - 1) * noOfRecord;
                data = dc.MyTables.OrderBy(a => a.Grade).Skip(skip).Take(noOfRecord).ToList();
                return data;
            }
        }


    }
}