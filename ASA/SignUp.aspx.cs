using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Npgsql;

namespace ASA
{
    public partial class SignUp : System.Web.UI.Page
    {
        string sex,interest;
        NpgsqlConnection con = new NpgsqlConnection("Server = localhost; Port=5432; User Id = postgres; password = admin; database = proje;Timeout=60;CommandTimeout=60;MaxPoolSize=150;Pooling=True; ");


        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["UserMail"] != null)
            {
                profileUpdate();
            }
           
}

        protected void sign_up_Click(object sender, EventArgs e)
        {

            HttpPostedFile file = Request.Files["profile_photo_add"];
            con.Open();

            if (Session["UserMail"] != null)
            {
                profileUpdateFunction();
            }

            if (file != null && file.ContentLength > 0)
                {
                    try
                    {
                        string str = Path.GetFileName(file.FileName);
                        file.SaveAs(Server.MapPath(Path.Combine("~/images/", str)));
                        string pathsw = "/images/" + str.ToString();
                        NpgsqlCommand profile_photo_cmd = new NpgsqlCommand("insert into ProfilePhoto (Path) values ('"+pathsw+"') ", con);
                        //profile_photo_cmd.Parameters.Add(new NpgsqlParameter("?path", pathsw));
                        profile_photo_cmd.ExecuteNonQuery();
                    }
                    catch (Exception ex)
                    {
                        Response.Write(ex);
                    }
                }


                string a = gender.SelectedIndex.ToString();

                if (int.Parse(a) == 0)
                {
                    sex = "M";
                }
                else if (int.Parse(a) == 1)
                {
                    sex = "F";
                }
                try
                {


                    NpgsqlCommand cmd = new NpgsqlCommand("insert into person (name,lastname,job,sex) values ('"+ person_name.Value.ToString() + "','"+ person_lastname.Value.ToString() + "','"+ jobs.Text + "', '"+ sex + "')", con);
                //cmd.Parameters.Add("?Name",NpgsqlDbType.VarChar).Value= person_name.Value.ToString();
                //cmd.Parameters.Add("?Lastname", NpgsqlDbType.VarChar).Value=person_lastname.Value.ToString();
                //cmd.Parameters.Add("?Birthday", NpgsqlDbType.Date).Value= datepicker.Value;
                //cmd.Parameters.Add("?Job", NpgsqlDbType.VarChar).Value=jobs.Text;
                //cmd.Parameters.Add("?Sex", NpgsqlDbType.VarChar).Value=sex;
                //cmd.Connection = con;
                //cmd.CommandText = "insert into person (name,lastname,job,sex) values ('seyf','aktas', 'student', 'male')";
                cmd.ExecuteNonQuery();

                    NpgsqlCommand user_cmd = new NpgsqlCommand("insert into users(nickname,password,balance,point,mail,status,profilephotoid,personid) values ('" + nikname.Value.ToString() + "','"+ password.Value.ToString() + "',0,0,'"+ email.Value.ToString() + "','T',(select max(id) from profilephoto),(select max(id) from person))", con);
                     //user_cmd.Parameters.Add("?nik", NpgsqlDbType.VarChar).Value= nikname.Value.ToString();
                    //user_cmd.Parameters.Add("?pass",NpgsqlDbType.Int32).Value= password.Value.ToString();
                    //user_cmd.Parameters.Add("?mail",NpgsqlDbType.VarChar).Value=email.Value.ToString();

                user_cmd.ExecuteNonQuery();

                }
                catch (Exception ex)
                {
                    Response.Redirect(ex.ToString());
                }


                if (develop.Checked)
                {
                    CheckBox(develop.Value.ToString());

                }
                if (design.Checked)
                {
                    CheckBox(design.Value.ToString());
                }
                if (business.Checked)
                {
                    CheckBox(business.Value.ToString());
                }

            Response.Redirect("HomeMaster.aspx");
           
            con.Close();
            
           
        }

        private void profileUpdateFunction()
        {
            
        }

        private void CheckBox(string content)
        {
            try { 
            NpgsqlCommand interest_cmd = new NpgsqlCommand("insert into INTEREST (CONTENT,USERSID) VALUES('"+content+"',(select max(ID) from USERS ))", con);
            //interest_cmd.Parameters.Add(new NpgsqlParameter("?interest", content));
            interest_cmd.ExecuteNonQuery();
            }
            catch (Exception ex)
            {
                Response.Write(ex);
            }

        }




        private void profileUpdate()
        {
           con.Open();

            NpgsqlCommand read_users_cmd = new NpgsqlCommand("select * from USERS where MAIL='"+ Session["UserMail"] + "'", con);
            //read_users_cmd.Parameters.Add(new NpgsqlParameter("?user_mail", Session["UserMail"]));
            NpgsqlDataReader read_users = read_users_cmd.ExecuteReader();
            read_users.Read();
            nikname.Value = read_users["NICKNAME"].ToString();
            email.Value = read_users["MAIL"].ToString();
            password.Value = read_users["PASSWORD"].ToString();
            read_users.Close();

            NpgsqlCommand read_person_cmd = new NpgsqlCommand("select * from USERS INNER JOIN PERSON ON USERS.PERSONID=PERSON.ID where USERS.MAIL='"+ Session["UserMail"] + "'  ", con);
            //read_person_cmd.Parameters.Add(new NpgsqlParameter("?user_mail", Session["UserMail"]));
            NpgsqlDataReader read_person = read_person_cmd.ExecuteReader();
            read_person.Read();
            person_name.Value = read_person["NAME"].ToString();
            person_lastname.Value = read_person["LASTNAME"].ToString();
            datepicker.Value = read_person["BIRTHDAY"].ToString();
            jobs.SelectedValue = read_person["JOB"].ToString();
            string gender_str = read_person["SEX"].ToString();
            if (gender_str == "M") gender.Value = "Male";
            else if (gender_str == "F") gender.Value = "Famale";
            read_person.Close();

            NpgsqlCommand read_profilephoto_cmd = new NpgsqlCommand("select PATH from PROFILEPHOTO INNER JOIN USERS ON PROFILEPHOTO.ID=USERS.PROFILEPHOTOID WHERE USERS.MAIL='" + Session["UserMail"] + "' ", con);
            //read_profilephoto_cmd.Parameters.Add(new NpgsqlParameter("?user_mail", Session["UserMail"]));
            NpgsqlDataReader read_profilephoto = read_profilephoto_cmd.ExecuteReader();
            read_profilephoto.Read();
            output.Src = read_profilephoto["PATH"].ToString();
            read_profilephoto.Close();


            con.Close();

        }

    }
}