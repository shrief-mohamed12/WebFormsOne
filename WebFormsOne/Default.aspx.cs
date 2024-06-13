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
                PopulateDataByJquery(1, 20);
            }

        }
        [WebMethod]
        public static List<GradeData> PopulateDataByJquery(int pageNo, int noOfRecord)
        {
            List<GradeData> data = new List<GradeData>();
            string connectionString = ConfigurationManager.ConnectionStrings["ConnectionString"].ConnectionString;

            // Calculate the number of records to skip
            int skip = (pageNo - 1) * noOfRecord;

            // SQL query to fetch paginated data
            string query = $@"SELECT G.[Grade]
                      ,G.[GradeName]
                      ,GG.[GradeGroupName]
                      ,G.[GradeCons]
                      ,G.[GradeNameCons]
                  FROM [dbo].[Grades] G
                  LEFT OUTER JOIN [dbo].[GradeGroups] GG
                  ON G.Grade = GG.GradeGroup
                  ORDER BY G.[Grade], G.[GradeName]
                  OFFSET @Skip ROWS
                  FETCH NEXT @NoOfRecord ROWS ONLY;";

            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                using (SqlCommand cmd = new SqlCommand(query, conn))
                {
                    cmd.Parameters.AddWithValue("@Skip", skip);
                    cmd.Parameters.AddWithValue("@NoOfRecord", noOfRecord);
                    conn.Open();

                    using (SqlDataReader reader = cmd.ExecuteReader())
                    {
                        while (reader.Read())
                        {
                            GradeData grade = new GradeData
                            {
                                Grade = reader["Grade"].ToString(),
                                GradeName = reader["GradeName"].ToString(),
                                GradeGroupName = reader["GradeGroupName"].ToString(),
                                GradeCons = reader["GradeCons"].ToString(),
                                GradeNameCons = reader["GradeNameCons"].ToString()
                            };
                            data.Add(grade);
                        }
                    }
                }
            }

            return data;
        }

        // Define a class to hold GradeData
        public class GradeData
        {
            public string Grade { get; set; }
            public string GradeName { get; set; }
            public string GradeGroupName { get; set; }
            public string GradeCons { get; set; }
            public string GradeNameCons { get; set; }
        }



    }
}