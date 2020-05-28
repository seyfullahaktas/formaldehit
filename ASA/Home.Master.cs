using System;
using Oracle.DataAccess.Client;

using System.Configuration;
using System.Data;
using Npgsql;

namespace ASA
{
    public partial class Home : System.Web.UI.MasterPage
    {
        NpgsqlConnection cnn = new NpgsqlConnection("Server = localhost; Port=5432; User Id = postgres; password = admin; database = proje;Timeout=60;CommandTimeout=60;MaxPoolSize=150;Pooling=True; ");

        public static object ConfigureManager { get; private set; }

        protected void Page_Load(object sender, EventArgs e)
        {

            if (Session["UserMail"] != null)
            {
                NpgsqlConnection cnn = new NpgsqlConnection("Server = localhost; Port=5432; User Id = postgres; password = admin; database = proje;Timeout=60;CommandTimeout=60;MaxPoolSize=150;Pooling=True; ");
                cnn.Open();
                sesionLoadPage();
                cnn.Close();
                login_sign_up.Visible = false;
                profile.Visible = true;
            }
            else
            {
                login_sign_up.Visible = true;
                profile.Visible = false;

            }

        }

        protected void LoginBtn_Click(object sender, EventArgs e)
        {
            NpgsqlConnection cnn = new NpgsqlConnection("Server = localhost; Port=5432; User Id = postgres; password = admin; database = proje;Timeout=60;CommandTimeout=60;MaxPoolSize=150;Pooling=True; ");
            NpgsqlCommand cmd = cnn.CreateCommand();
            cmd.CommandText = "select * from USERS WHERE USERS.mail=@User_Id AND USERS.password=@User_password";
            cmd.CommandType = CommandType.Text;
            cmd.Parameters.Add(new NpgsqlParameter("@User_Id", username.Value));
            cmd.Parameters.Add(new NpgsqlParameter("@User_password", password.Value));
            
            cnn.Open();

            NpgsqlDataReader dr = cmd.ExecuteReader();
            if (dr.Read())
            {
                login_sign_up.Visible = false;
                profile.Visible = true;

                Session["UserMail"] = dr["MAIL"].ToString();
                sesionLoadPage();
               

            }
            else
            {
                cnn.Close();
                Response.Redirect("HomeMaster.aspx");
            }
            dr.Close();


           

            /*
            string loginsorgu2 = "select * from Kisi INNER JOIN Kullanici ON  Kullanici.KisiId=Kisi.Id INNER JOIN Mail ON Mail.Id=Kullanici.MailId WHERE Mail.MailAdresi=@KullaniciId AND Kullanici.Parola=@KullaniciParola";
            SqlCommand cmd2 = new SqlCommand(loginsorgu2, cnn);
            cmd2.Parameters.AddWithValue("@KullaniciId", KullaniciAdi.Text);
            cmd2.Parameters.AddWithValue("@KullaniciParola", Parola.Text);
            SqlDataReader dr2 = cmd2.ExecuteReader();
            if (dr2.Read())
            {

                Session["KiId"] = dr2["Id"].ToString();
            }
            else
            {
                Response.Write("Kullanıcı Girisi Saglanamadi");
            }

            dr2.Close();
            */

        }

        protected void logout_Click(object sender, EventArgs e)
        {
            Session.Clear();
            Session.RemoveAll();
            Session.Abandon();
            login_sign_up.Visible = true;
            profile.Visible = false;
            Response.Redirect("HomeMaster.aspx");
        }

        protected void sesionLoadPage()
        {
            cnn.Open();
            if (Session["UserMail"] != null)
            {
                string gelen = Session["UserMail"].ToString();

                NpgsqlCommand cmd4 = cnn.CreateCommand();
                NpgsqlCommand cmd3 = cnn.CreateCommand();
                NpgsqlCommand cmd2 = cnn.CreateCommand();
                cmd3.CommandText = "SELECT * from Person P WHERE P.ID=(SELECT PersonID FROM Users WHERE MAIL='" + gelen + "')";
                cmd2.CommandText = "SELECT * from Users WHERE Users.MAIL='" + gelen + "'";
                cmd4.CommandText = "select PATH from PROFILEPHOTO INNER JOIN USERS ON PROFILEPHOTO.ID=USERS.PROFILEPHOTOID WHERE MAIL=@gelen ";
                cmd4.Parameters.Add(new NpgsqlParameter("@gelen", gelen));

                cmd3.CommandType = CommandType.Text;
                cmd2.CommandType = CommandType.Text;
                cmd4.CommandType = CommandType.Text;
                NpgsqlDataReader dr3 = cmd3.ExecuteReader();
                if (dr3 != null)
                {
                    dr3.Read();
                    string name = dr3["Name"].ToString();
                    string lastname = dr3["Lastname"].ToString();

                    Share_Name_LastName.Text = name + " " + lastname;
                    dr3.Close();

                    NpgsqlDataReader dr2 = cmd2.ExecuteReader();
                    dr2.Read();
                    string nickname = dr2["nickname"].ToString();
                    string balance = dr2["Balance"].ToString();
                    Share_Nickname.Text = "@" + nickname;
                    Share_Balance.Text = "$" + balance;
                    dr2.Close();
                    try
                    {

                        NpgsqlDataReader dr4 = cmd4.ExecuteReader();
                        dr4.Read();
                        string url = dr4["PATH"].ToString();
                        profile_image.Src = url;
                        dr4.Close();
                    }
                    catch (Exception ex)
                    {
                        Response.Write(ex);
                    }

                }

                
            }

        }

        protected void AddQuestionBut_Click(object sender, EventArgs e)
        {
            if (Session["UserMail"] != null)
            {

                Response.Redirect("AddQuestionMaster.aspx");

            }else
            {
            
                Page.ClientScript.RegisterStartupScript(this.GetType(), "text", "$('#fh5co-offcanvass').toggleClass('fh5co-awake');", true);

            }
        }
    }
}