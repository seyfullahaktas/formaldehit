using Newtonsoft.Json;
using Oracle.ManagedDataAccess.Client;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;
using Npgsql;


namespace ASA
{
    public partial class QuestionMaster : System.Web.UI.Page
    {
        String connectionString = "Server = localhost; Port=5432; User Id = postgres; password = admin; database = proje;Timeout=60;CommandTimeout=60;MaxPoolSize=150;Pooling=True; ";

        NpgsqlConnection cnn = null;

        private static int question_id, delete_id, bless_id;

        protected void SendDatabase(Object sender, EventArgs e)
        {
            string con_str = "Server = localhost; Port=5432; User Id = postgres; password = admin; database = proje;Timeout=60;CommandTimeout=60;MaxPoolSize=150;Pooling=True; ";
            NpgsqlConnection con = new NpgsqlConnection();
            con.ConnectionString = con_str;
            con.Open();


            string question_id_str = Request.QueryString[0];

            question_id = Int32.Parse(question_id_str);
            string comment_form = Request.Form["addComment"];
            string upload_form = Request.Form["uploadMedia"];
            string mailSession = "";
            if (Session["UserMail"] != null)
            {
                mailSession = Session["UserMail"].ToString();
            }

            try
            {
                NpgsqlCommand insert_cmd = new NpgsqlCommand("insert into ANSWER (EXPLAIN,STATUS,USERSID,QUESTIONID,CREATEDATE,MEDIA) values (@comment_forms,'T',(SELECT ID FROM USERS WHERE MAIL=@emailSession),@questionid,CURRENT_DATE,@uploadf)", con);
                insert_cmd.Parameters.Add(new NpgsqlParameter("@comment_forms", comment_form));
                insert_cmd.Parameters.Add(new NpgsqlParameter("@emailSession", mailSession));
                insert_cmd.Parameters.Add(new NpgsqlParameter("@questionid", question_id));
                insert_cmd.Parameters.Add(new NpgsqlParameter("@uploadf", upload_form));
                insert_cmd.ExecuteNonQuery();
            }
            catch (Exception ex)
            {
                Response.Write(ex);
            }

            cnn.Close();
        }

        protected void Page_Load(object sender, EventArgs e)
        {

            if (Session["UserMail"] == null) Response.Redirect("HomeMaster.aspx");
            string id = Request.QueryString["ID"];
            question_id = Int32.Parse(id);
            cnn = new NpgsqlConnection(connectionString);
            NpgsqlCommand cmd = cnn.CreateCommand();
            cmd.CommandText = "SELECT Q.EXPLAIN, Q.CREATEDATE, P.PATH,U.NICKNAME FROM QUESTION Q INNER JOIN USERS U ON Q.OWNID = U.ID INNER JOIN PROFILEPHOTO P ON U.PROFILEPHOTOID = P.ID WHERE Q.ID =@question_id";

            cmd.CommandType = CommandType.Text;
            cmd.Parameters.Add(new NpgsqlParameter("@question_id", question_id));

            NpgsqlCommand cmd2 = cnn.CreateCommand();
            cmd2.CommandText = "SELECT MAIL FROM USERS U INNER JOIN QUESTION Q ON U.ID=Q.OWNID WHERE Q.ID=@question_id";
            cmd2.CommandType = CommandType.Text;
            cmd2.Parameters.Add(new NpgsqlParameter("@question_id", question_id));

            cnn.Open();
            NpgsqlDataReader dr = cmd.ExecuteReader();
            if (dr.Read())
            {
                string path_read = dr["path"].ToString();
                questionProfilePhoto.Attributes["src"] = path_read;
                questionUserName.InnerHtml = dr["nickname"].ToString();
                string a = dr["createdate"].ToString();
                string[] date = a.Split('-');
                questionyear.InnerHtml = date[0];
                questionmonth.InnerHtml = date[1];
                questionday.InnerHtml = date[2];
                questionComment.InnerHtml = dr["explain"].ToString();

            }
            dr.Close();
            NpgsqlDataReader dr2 = cmd2.ExecuteReader();
            if (dr2.Read())
            {
                session.Attributes["value"] = dr2["mail"].ToString();

            }
            cnn.Close();
            string deletequest = Request.QueryString["delete"];
            string blessquest = Request.QueryString["bless"];
            bool questionDeletedId = Convert.ToBoolean (Request.QueryString["isDeleteQuestion"]);
            if (deletequest != null)
            {
                
                delete_id = Int32.Parse(deletequest);
                cnn = new NpgsqlConnection(connectionString);
                cnn.Open();
                NpgsqlCommand cmddelete = cnn.CreateCommand();
                cmddelete.CommandText = "DELETE FROM ANSWER WHERE ID=@answer_id";
                cmddelete.CommandType = CommandType.Text;
                cmddelete.Parameters.Add(new NpgsqlParameter("@answer_id", delete_id));
                cmddelete.ExecuteNonQuery();
                cnn.Close();
            }
            else if (blessquest != null)
            {

                bless_id = Int32.Parse(blessquest);
                cnn = new NpgsqlConnection(connectionString);
                cnn.Open();
                NpgsqlCommand cmdbless = cnn.CreateCommand();
                cmdbless.CommandType = CommandType.Text;
                cmdbless.CommandText = "select ((select balance from users where id =(select usersid from answer where id=@bless_id))+(select money from question where id=@question_id)) as result";
                cmdbless.Parameters.Add(new NpgsqlParameter("@bless_id", bless_id));
                cmdbless.Parameters.Add(new NpgsqlParameter("@question_id", question_id));
                var result = cmdbless.ExecuteScalar();
                int totbalance = result != null ? Convert.ToInt32(result) : 0;
                //float totbalance = (float)cmdbless.ExecuteScalar();
                cmdbless = cnn.CreateCommand();
                cmdbless.CommandText = "UPDATE users SET balance=" + totbalance + " WHERE ID=(select usersid from answer where id=@bless_id)";
                cmdbless.CommandType = CommandType.Text;
                cmdbless.Parameters.Add(new NpgsqlParameter("@bless_id", bless_id));
                cmdbless.ExecuteNonQuery();
                cmdbless.CommandText = "UPDATE ANSWER SET STATUS='F' WHERE ID=@bless_id";
                cmdbless.Parameters.Add(new NpgsqlParameter("@bless_id", bless_id));
                cmdbless.ExecuteNonQuery();
                cnn.Close();

            }
            else if (questionDeletedId)
            {
               
                cnn = new NpgsqlConnection(connectionString);
                cnn.Open();
                NpgsqlCommand cmddelete = cnn.CreateCommand();
                cmddelete.CommandText = "DELETE FROM ANSWER WHERE questionid=@question_id";
                cmddelete.CommandType = CommandType.Text;
                cmddelete.Parameters.Add(new NpgsqlParameter("@question_id", question_id));
                cmddelete.ExecuteNonQuery();

                cmddelete.CommandText = "DELETE FROM question WHERE ID=@question_id";
                cmddelete.CommandType = CommandType.Text;
                cmddelete.Parameters.Add(new NpgsqlParameter("@question_id", question_id));
                cmddelete.ExecuteNonQuery();
                cnn.Close();
                Response.Redirect("HomeMaster.aspx");


            }
            }

        [WebMethod]
        public static string ShareList()
        {
            string data = "";

            NpgsqlConnection cnn = new NpgsqlConnection("Server = localhost; Port=5432; User Id = postgres; password = admin; database = proje;Timeout=60;CommandTimeout=60;MaxPoolSize=150;Pooling=True; ");
            NpgsqlCommand cmdu = cnn.CreateCommand();
            cmdu.CommandText = "SELECT A.ID,A.Explain, A.CreateDate, P.Path, U.NickName FROM Answer A INNER JOIN Users U ON A.USERSID = U.ID INNER JOIN PROFILEPHOTO P ON U.PROFILEPHOTOID = P.ID WHERE A.QUESTIONID=@question_id ORDER BY A.CreateDate DESC";
            cmdu.CommandType = CommandType.Text;
            cmdu.Parameters.Add(new NpgsqlParameter("@question_id", question_id));
            NpgsqlDataAdapter adp = new NpgsqlDataAdapter(); ;
            adp.SelectCommand = cmdu;

            DataSet ds = new DataSet();
            try
            {
                adp.Fill(ds);
                data = JsonConvert.SerializeObject(ds, Formatting.Indented);
            }
            catch (Exception ex)
            {

            }

            cnn.Close();
            return data;
        }

    }
}