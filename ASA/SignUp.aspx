<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="SignUp.aspx.cs" Inherits="ASA.SignUp" %>


<!DOCTYPE html>


<html>
<head>
    <meta charset="utf-8" />
    <title>Sign Up Form </title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />

    <link rel="stylesheet" type="text/css" href="bootstrap/css/bootstrap.min.css" />
    <link rel="stylesheet" type="text/css" href="font-awesome/css/font-awesome.min.css" />

    <script type="text/javascript" src="js/jquery-1.10.2.min.js"></script>
    <script type="text/javascript" src="bootstrap/js/bootstrap.min.js"></script>
    <script>
  $( function() {
      $("#datepicker").datepicker({ dateFormat: 'dd-mm-yy' });
      
  });
  </script>

     <link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
  <link rel="stylesheet" href="/resources/demos/style.css">
  <script src="https://code.jquery.com/jquery-1.12.4.js"></script>
  <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
</head>
<body>

<form runat="server" >
<div class="container">

<!-- Sign Up Form - START -->
<!-- you need to include the shieldui css and js assets in order for the charts to work -->

<div class="container" id="f1">
    <div class="col-md-3"></div>
    <div class="col-md-6">
        <div id="panel1" class="panel panel-default">
            <h1>Sign Up</h1>
            <div>
                <img id="output" runat="server" class="center-block" style="align-items:center;width:100px;height:100px;border-radius:50%"/>
                <input type="file" runat="server" id="profile_photo_add" class="center-block" accept="image/*" style="position:center" onchange="loadFile(event)">
                
            </div>
            <fieldset>
                <legend><span class="number">1</span>Your basic info</legend>
                <label for="name">Name:</label>
                <div class="input-group input-group-md">
                    <span class="input-group-addon" id="sizing-addon1"><span class="glyphicon glyphicon-user"></span></span>
                    <input type="text" runat="server" id="nikname" name="nikname" class="form-control" placeholder="Nickname" aria-describedby="sizing-addon1">
                </div>
                <br />
                <label for="mail">E-mail:</label>
                <div class="input-group input-group-md">
                    <span class="input-group-addon" id="sizing-addon2"><span class="glyphicon glyphicon-envelope"></span></span>
                    <input type="text" runat="server" name="email" id="email" class="form-control" placeholder="Type your e-mail here..." aria-describedby="sizing-addon2">
                </div>
                <br />
                <label for="pass">Password:</label>
                <div class="input-group input-group-md">
                    <span class="input-group-addon" id="sizing-addon3"><span class="glyphicon glyphicon-cog"></span></span>
                    <input type="password" runat="server" name="password" id="password" class="form-control" placeholder="Password" aria-describedby="sizing-addon3" >
                </div>
                <br />
                <label for="pass_confirm">Confirm password:</label>
                <div class="input-group input-group-md">
                    <span class="input-group-addon" id="sizing-addon4"><span class="glyphicon glyphicon-cog"></span></span>
                    <input type="password" class="form-control" placeholder="Confirm password" aria-describedby="sizing-addon4" id="confirmPass">
                </div>
                <p id="passwordMatch">
                    
                </p>
                <br />
                
            </fieldset>

            <fieldset>
                <legend><span class="number">2</span>Your profile</legend>
                <div class="input-group input-group-md">
                    <span class="input-group-addon" id="sizing-addon1"><span class="glyphicon glyphicon-user"></span></span>
                    <input type="text" runat="server" id="person_name" name="person_name" class="form-control" placeholder="Firstname" aria-describedby="sizing-addon1">
                </div>
                <br />
                <div class="input-group input-group-md">
                    <span class="input-group-addon" id="sizing-addon1"><span class="glyphicon glyphicon-user"></span></span>
                    <input type="text" runat="server" id="person_lastname" name="person_lastname" class="form-control" placeholder="Lastname" aria-describedby="sizing-addon1">
                </div>
                <br />
                
                <div class="input-group input-group-md">
                    <label>Gender:</label>
                    <select runat="server" id="gender" name="gender">
                        <option value="0">Male</option>
                        <option value="1">Female</option>
                    </select>
                </div>
                <br />
                <div >

                    <p>Date: <input runat="server" type="text" id="datepicker"></p>
                </div>
            </fieldset>

            <fieldset>
                <label for="job">Job Role:</label>
                 <asp:DropDownList runat="server" id="jobs" name="jobs">  
                                    <asp:ListItem Value="Developer"></asp:ListItem>  
                                    <asp:ListItem Value="Designer"></asp:ListItem>  
                                    <asp:ListItem Value="Developer"></asp:ListItem>  
                                    <asp:ListItem Value="Business_owner"></asp:ListItem>  
                                    <asp:ListItem Value="Freelancer"></asp:ListItem>   
                                    <asp:ListItem Value="Secretary"></asp:ListItem> 
                                    <asp:ListItem Value="Maintenance"></asp:ListItem> 
                                    <asp:ListItem Value="Student"></asp:ListItem> 
                                     
                             </asp:DropDownList>  
            </fieldset>

            <fieldset>
                <label>Interests:</label>
                <input type="checkbox" runat="server" id="develop" value="developmentInterest" name="user_interest"><label class="light" for="development">Development</label><br>
                <input type="checkbox" runat="server" id="design" value="designInterest" name="user_interest"><label class="light" for="design">Design</label><br>
                <input type="checkbox" runat="server" id="business" value="businessInterest" name="user_interest"><label class="light" for="business">Business</label>
            </fieldset>

             <asp:Button runat="server" OnClick="sign_up_Click" id="b1" Text="Sign Up"/> 						
	      

            <footer>
                <p id="footer">Desing provided by <a href="https://www.shieldui.com/">Shield UI</a></p>
            </footer>
        </div>
    </div>
    <div class="col-md-3"></div>
</div>
    
<style>
    .profilephotocss{
    margin-top: 100px;
    width: 200px;
    height: 200px;
    border-radius: 50%;
    display: block;
    margin: 0 auto;
    }

    .profilextra {
    opacity: 1;
    display: block;
    width: 100%;
    height: auto;
    transition: .5s ease;
    backface-visibility: hidden;
}
    .dosyasecim {
    background-color: transparent;
    color: white;
    font-size: 16px;
    padding: 16px 32px;
}
    #f1
    {
        font-family: 'Nunito', sans-serif;
        color: #384047;
    }

    #panel1
    {
        padding: 10px 20px;
        background: #f4f7f8;
        border-radius: 8px;
    }

    h1
    {
        margin: 0 0 30px 0;
        text-align: center;
    }

    #f1 input[type="text"],
    #f1 input[type="password"],
    #f1 input[type="date"],
    #f1 input[type="datetime"],
    #f1 input[type="email"],
    #f1 input[type="number"],
    #f1 input[type="search"],
    #f1 input[type="tel"],
    #f1 input[type="time"],
    #f1 input[type="url"],
    #f1 textarea,
    #f1 select
    {
        background: rgba(255,255,255,0.1);
        
        font-size: 16px;
        height: auto;
        margin: 0;
        outline: 0;
        padding: 15px;
        width: 100%;
        background-color: #fff;
        color: #8a97a0;
        box-shadow: 0 1px 0 rgba(0,0,0,0.03) inset;
    }

    #f1 textarea,
    #f1 select
    {
        border: 1px solid #ccc;
    }

    #f1 input[type="radio"],
    #f1 input[type="checkbox"]
    {
        margin: 0 4px 8px 0;
    }

    #f1 .sui-sprite.sui-calendar-icon
    {
        margin-top: 14px;
    }

    #b1
    {
        padding: 19px 39px 18px 39px;
        color: #FFF;
        background-color: #4bc970;
        font-size: 18px;
        text-align: center;
        font-style: normal;
        border-radius: 5px;
        width: 100%;
        border: 1px solid #3ac162;
        border-width: 1px 1px 3px;
        box-shadow: 0 -1px 0 rgba(255,255,255,0.1) inset;
        margin-bottom: 10px;
    }

    fieldset
    {
        margin-bottom: 30px;
        border: none;
    }

    legend
    {
        font-size: 1.4em;
        margin-bottom: 10px;
    }

    label
    {
        display: block;
        margin-bottom: 8px;
    }

        label.light
        {
            font-weight: 300;
            display: inline;
        }

    .number
    {
        background-color: #5fcf80;
        color: #fff;
        height: 30px;
        width: 30px;
        display: inline-block;
        font-size: 0.8em;
        margin-right: 4px;
        line-height: 30px;
        text-align: center;
        text-shadow: 0 1px 0 rgba(255,255,255,0.2);
        border-radius: 100%;
    }

    #footer
    {
        font-size: 10px;
        text-align: center;
        font-weight: bold;
    }

    #passwordMatch
    {
        text-align: center;
    }

    .input-group-addon
    {
        background-color: #e8eeef;
    }

    #or
    {
        text-align: center;
        font-weight: bold;
    }


    .social
    {
        list-style-type: none;
        background: #29AFBB;
        height: 52px;
        border: 2px solid#218C95;
    }

        .social li
        {
            padding-right: 20px;
            display: inline-block;
            font-size: 27px;
            border-bottom: 5px solid#29AFBB;
            cursor: pointer;
            margin-top: 5px;
        }

            .social li a
            {
                color: #fff;
                vertical-align: -webkit-baseline-middle;
            }
</style>

<script type="text/javascript">
    jQuery(function ($) {
        $(function () {
           


            $('#confirmPass').on('keyup', function () {
                if ($('#confirmPass').val() == $('#password').val()) {
                    $('#passwordMatch').html('Passwords match!').css('color', 'green');
                }
                else {
                    $('#passwordMatch').html('Passwords do not match!').css('color', 'red');
                }
            });
        });
    });
</script>

    <script>
  var loadFile = function(event) {
    var output = document.getElementById('output');
    output.src = URL.createObjectURL(event.target.files[0]);
  };
</script>

<!-- Sign Up Form - END -->

</div>
    </form>
</body>
</html>