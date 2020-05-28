using Newtonsoft.Json;
using Oracle.DataAccess.Client;
using System;
using System.Configuration;
using System.Data;
using System.Web.Services;
using Npgsql;

namespace ASA
{
    public partial class HomeMaster : System.Web.UI.Page
    {
       

        protected void Page_Load(object sender, EventArgs e)
        {
           
            
        }
        [WebMethod]
        public static string ShareList(string search_value)
        {
            NpgsqlConnection cnn = new NpgsqlConnection("Server = localhost; Port=5432; User Id = postgres; password = admin; database = proje;Timeout=60;CommandTimeout=60;MaxPoolSize=150;Pooling=True; ");

            cnn.Open();
            String query = "SELECT EXPLAIN,CREATEDATE,MONEY,PATH,Q.ID FROM QUESTION Q INNER JOIN PHOTO P ON P.ID=Q.PHOTOID ";
            if (!String.IsNullOrEmpty(search_value))
            {
                query += "WHERE EXPLAIN LIKE '%" + search_value + "%'";
            }
            NpgsqlDataAdapter adp = new NpgsqlDataAdapter (query, cnn);
            


            DataSet ds = new DataSet();
            adp.Fill(ds);
            string data = JsonConvert.SerializeObject(ds, Formatting.Indented);
            return data;
        }
       
       
    }
}