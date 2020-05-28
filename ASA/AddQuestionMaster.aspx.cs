using Oracle.ManagedDataAccess.Client;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Globalization;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Npgsql;

namespace ASA
{
    public partial class AddQuestionMaster : System.Web.UI.Page
    {

        
        NpgsqlConnection cnn = new NpgsqlConnection("Server = localhost; Port=5432; User Id = postgres; password = admin; database = proje;Timeout=60;CommandTimeout=60;MaxPoolSize=150;Pooling=True; ");
        public static string gelen_id;
        protected void Page_Load(object sender, EventArgs e)
        {

        }
        protected void SendDatabase(Object sender, EventArgs e)
        {

           
            string image_read = ImageRead.Value.ToString();
            string explain_read = this.addName.InnerText;
            string comment_read = this.addComment.InnerText;
            string price_read = priceMedia.Value.ToString();
            string tag_read = tagMedia.Value.ToString();
            float price = float.Parse(price_read);

            string pathsw = "/images/" + image_read;
            cnn.Open();
            NpgsqlCommand profile_photo_cmd = new NpgsqlCommand("insert into PHOTO (Path) values ('" + pathsw + "') ", cnn);
            //profile_photo_cmd.Parameters.Add(new NpgsqlParameter("param1", pathsw));
            profile_photo_cmd.ExecuteNonQuery();

            //BURADAN DEVAM EDİLECEK MAX ID DONDURELECEK 
            NpgsqlCommand cmd2 = cnn.CreateCommand();
            cmd2.CommandText = "SELECT MAX(ID) AS ID FROM PHOTO ";
            cmd2.CommandType = CommandType.Text;

            NpgsqlDataReader dr = cmd2.ExecuteReader();
            dr.Read();
            string id = dr["ID"].ToString();
            int img_id = Int32.Parse(id);
            dr.Close();
            cnn.Close();

            string mailSession = "";

            if (Session["UserMail"] != null)
            {
                mailSession = Session["UserMail"].ToString();
            }

            cnn.Open();
            NpgsqlCommand cmdu = new NpgsqlCommand("INSERT INTO QUESTION (createdate,tag,status,money,photoid,ownid,explain) VALUES (current_date, '" + tag_read + "', 'T', '" + price + "', '"+ img_id + "', (SELECT ID FROM USERS WHERE MAIL = '"+mailSession+"'),'" + explain_read + "'); ",cnn);
            //cmdu.Connection = cnn;
            //cmdu.CommandText = "INSERT INTO QUESTION (CREATEDATE,TAG,STATUS,MONEY,PHOTOID,OWNID,EXPLAIN)VALUES(CURRENT_DATE(), ?t_read, 'T', ?pri_read, ?img_read, (SELECT ID FROM USERS WHERE MAIL = ?mail_id),?exp_read); ";
            //cmdu.CommandType = CommandType.Text;
            //cmdu.Parameters.Add(new NpgsqlParameter("?exp_read", explain_read));
            //cmdu.Parameters.Add(new NpgsqlParameter("?t_read", tag_read));
            //cmdu.Parameters.Add(new NpgsqlParameter("?pri_read", price));
            //cmdu.Parameters.Add(new NpgsqlParameter("?comment_read", comment_read));
            //cmdu.Parameters.Add(new NpgsqlParameter("?img_read", img_id));
            //cmdu.Parameters.Add(new NpgsqlParameter("?mail_id", mailSession));



            try
            {
                cmdu.ExecuteNonQuery();
            }
            catch (Exception ex)
            {
                Response.Write(ex);
            }
            cnn.Close();
            Response.Redirect("HomeMaster.aspx");
        }
    }
}