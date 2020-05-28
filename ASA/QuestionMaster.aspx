<%@ Page Title="" Language="C#" MasterPageFile="~/Home.Master" AutoEventWireup="true" CodeBehind="QuestionMaster.aspx.cs" Inherits="ASA.QuestionMaster" %>
<asp:Content ID="Content1" ContentPlaceHolderID="ContentPlaceHolder2" runat="server">

<script src="//code.jquery.com/jquery-1.11.1.min.js"></script>
 <link href="//netdna.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap.min.css" rel="stylesheet" id="bootstrap-css">
<script src="//netdna.bootstrapcdn.com/bootstrap/3.2.0/js/bootstrap.min.js"></script>
    
    

    <body onload="ata()">
<div class="container" onload="ata()">
  <div class="row">
    <div class="col-sm-10 col-sm-offset-1" id="logout">
        <div class="page-header">
            <asp:Label runat="server" ID="session" value="" ClientIDMode="Static">
            <li class="media" style="list-style:none"   runat="server">
            <a class="pull-left" href=""><img runat="server" class="media-object img-circle" id="questionProfilePhoto" src=""></a>
            <div class="media-body">
            <div id="questionborder"class="well well-lg">
                <h4 class="media-heading text-uppercase reviews" runat="server" id="questionUserName"></h4>
                <ul class="media-date text-uppercase reviews list-inline">
                    <li class="dd" runat="server" id="questionyear"></li>
                    <li class="mm" runat="server" id="questionmonth"></li>
                    <li class="aaaa" runat="server" id="questionday"></li>

                </ul>
                <p class="media-comment" runat="server" id="questionComment"></p>
            </div>
            </div>
        </li>
            </asp:Label>
                </div>
        <div class="comment-tabs">
            <ul class="nav nav-tabs" role="tablist">
                <li class="active"><a href="#comments-logout" role="tab" data-toggle="tab"><h4 class="reviews text-capitalize">Comments</h4></a></li>
                <li><a href="#add-comment" role="tab" data-toggle="tab"><h4 class="reviews text-capitalize">Add comment</h4></a></li>
                
            </ul>            
            <div class="tab-content">   
                <div class="tab-pane active" id="comments-logout">                
                    <ul class="media-list" id="MediaMain">
                     <!-- Eklem islemi-->        
                      
                    </ul> 
                </div>
                <div class="tab-pane" id="add-comment">
                    <div class="form-horizontal" id="commentForm"> 
                        <div class="form-group">
                            <label for="email" class="col-sm-2 control-label">Comment</label>
                            <div class="col-sm-10">
                              <textarea class="form-control" name="addComment" id="addComment" rows="5" ></textarea>
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="uploadMedia" class="col-sm-2 control-label">Upload media</label>
                            <div class="col-sm-10">                    
                                <div class="input-group">
                                  <div class="input-group-addon">http://</div>
                                  <input type="text" class="form-control" name="uploadMedia" id="uploadMedia" />
                                </div>
                            </div>
                        </div>
                        <div class="form-group">
                            <div class="col-sm-offset-2 col-sm-10">                    
                                <button class="btn btn-success btn-circle text-uppercase" type="submit" id="submitComment" runat="server" onserverclick="SendDatabase" ><span runat="server" class="glyphicon glyphicon-send"></span> Summit comment</button>
                            </div>
                        </div>            
                    </div>
                </div>
            
            </div>
        </div>
	</div>
  </div>
  
  
</div>
</body>


    
<style type="text/css">


#login { display: none; }
.login,
.logout { 
    position: absolute; 
    top: -3px;
    right: 0;
}
.page-header { position: relative; }
.reviews {
    color: #555;    
    font-weight: bold;
    margin: 10px auto 20px;
}
.notes {
    color: #999;
    font-size: 12px;
}
.media .media-object { max-width: 120px; }
.media-body { position: relative; }
.media-date { 
    position: absolute; 
    right: 25px;
    top: 25px;
}
.media-date li { padding: 0; }
.media-date li:first-child:before { content: ''; }
.media-date li:before { 
    content: '.'; 
    margin-left: -2px; 
    margin-right: 2px;
}
.media-comment { margin-bottom: 20px; }
.media-replied { margin: 0 0 20px 50px; }
.media-replied .media-heading { padding-left: 6px; }

.btn-circle {
    font-weight: bold;
    font-size: 12px;
    padding: 6px 15px;
    border-radius: 20px;
}
.btn-circle span { padding-right: 6px; }
.embed-responsive { margin-bottom: 20px; }
.tab-content {
    padding: 50px 15px;
    border: 1px solid #ddd;
    border-top: 0;
    border-bottom-right-radius: 4px;
    border-bottom-left-radius: 4px;
}
.custom-input-file {
    overflow: hidden;
    position: relative;
    width: 120px;
    height: 120px;
    background: #eee     
    background-size: 120px;
    border-radius: 120px;
}
input[type="file"]{
    z-index: 999;
    line-height: 0;
    font-size: 0;
    position: absolute;
    opacity: 0;
    filter: alpha(opacity = 0);-ms-filter: "alpha(opacity=0)";
    margin: 0;
    padding:0;
    left:0;
}
.uploadPhoto {
    position: absolute;
    top: 25%;
    left: 25%;
    display: none;
    width: 50%;
    height: 50%;
    color: #fff;    
    text-align: center;
    line-height: 60px;
    text-transform: uppercase;    
    background-color: rgba(0,0,0,.3);
    border-radius: 50px;
    cursor: pointer;
}
.custom-input-file:hover .uploadPhoto { display: block; }
</style>
    <script src="https://ajax.aspnetcdn.com/ajax/jQuery/jquery-3.3.1.min.js"></script>
<script type="text/javascript">
    function ata() {
        $.ajax({
            type: "POST",
            url: "QuestionMaster.aspx/ShareList",
            contentType: "application/json;charset-utf-8",
            success: function (result) {

                var MyData = JSON.parse(result.d);
                var maindiv = document.getElementById('MediaMain');
                var i;
                var data = MyData.Table;
                var qrStr = "";
                var linke=qrStr = window.location.search;
                var someSession = '<%= Session["UserMail"].ToString() %>';
                var ses = document.getElementById('session').getAttribute("value");
                qrStr = linke.split("?")[1].split("=")[1].split("&")[0];
                if (someSession === "admin" || someSession == ses) {
                    var questionElement = document.getElementById("questionborder");
                    var questionDeleteBut = document.createElement('a');
                    questionDeleteBut.setAttribute('class', 'glyphicon glyphicon-remove btn btn-danger text-uppercase');
                    questionDeleteBut.setAttribute('style', 'float:right');
                    questionDeleteBut.setAttribute('id', 'deleteQuestion_');
                    questionDeleteBut.setAttribute('href', 'QuestionMaster.aspx?id=' + qrStr + '&isDeleteQuestion=True');
                    questionElement.appendChild(questionDeleteBut);
                    questionElement.appendChild(document.createElement("br"));
                }
                for (i = 0; i < data.length; i++) {

                   
                    var li_item = document.createElement('li');
                    li_item.setAttribute('class', 'media');
                    
                    var profilephoto = document.createElement('a');
                    profilephoto.setAttribute('class', 'pull-left');
                    profilephoto.setAttribute('href', 'QuestionMaster.aspx');
                    var img = document.createElement('img');
                    img.setAttribute('class', 'media-object img-circle');
                    img.setAttribute('src', data[i].path);

                    profilephoto.appendChild(img);
                    li_item.appendChild(profilephoto);

                    var divbody = document.createElement('div');
                    divbody.setAttribute('class', 'media-body');
                    var divwell = document.createElement('div');
                    divwell.setAttribute('class', 'well well-lg');
                    var nickname = document.createElement('h4');
                    nickname.setAttribute('class', 'media-heading text-uppercase reviews');

                    var stringName = data[i].nickname;
                    nickname.innerHTML += stringName;
                    var h4ul = document.createElement('ul');
                    h4ul.setAttribute('class', 'media-date text-uppercase reviews list-inline');
                    var lih4 = document.createElement('li');
                    var lih41 = document.createElement('li');
                    var lih42 = document.createElement('li');
                    lih42.setAttribute('class', 'aaaa');
                    lih41.setAttribute('class', 'mm');
                    lih4.setAttribute('class', 'dd');
                    
                    

                    var dateString = data[i].createdate;
                    var dateArray = dateString.split('-');
                    lih4.innerHTML += dateArray[0];
                    lih41.innerHTML += dateArray[1];
                    var ye = dateArray[2].split('T');
                    lih42.innerHTML += ye[0];
                    h4ul.appendChild(lih4);
                    h4ul.appendChild(lih41);
                    h4ul.appendChild(lih42);


                    divwell.appendChild(nickname);
                    divwell.appendChild(h4ul);
                    var commentline = document.createElement('p');
                    commentline.setAttribute('class', 'media-comment');
                    var commentString = data[i].explain;
                    commentline.innerHTML += commentString;
                    divwell.appendChild(commentline);

                    qrStr = linke.split("?")[1].split("=")[1].split("&")[0];
                 
                    var btn = document.createElement('a');
                    btn.setAttribute('class', 'glyphicon glyphicon-usd btn btn-info text-uppercase');
                    btn.setAttribute('style', 'float:right');
                    btn.setAttribute('href', 'QuestionMaster.aspx?id=' + qrStr + '&bless=<%# Request.QueryString["BLESSID"] %>' + data[i].id);
                    
                    btn.setAttribute('id', 'reply_' + data[i].id);
                   
                    qrStr = linke.split("?")[1].split("=")[1].split("&")[0];

                    var btn2 = document.createElement('a');
                    btn2.setAttribute('class', 'glyphicon glyphicon-remove btn btn-danger text-uppercase');
                    btn2.setAttribute('style', 'float:right');
                    btn2.setAttribute('id', 'delete_' + data[i].id);

                    btn2.setAttribute('href', 'QuestionMaster.aspx?id='+qrStr+'&delete=<%# Request.QueryString["DELETEID"] %>' + data[i].id);
                   

                    
                    if (someSession === "admin" || someSession == ses)
                    {
                        /* divwell.appendChild(btn);*/
                        divwell.appendChild(btn);
                        divwell.appendChild(btn2);
                        divwell.appendChild(document.createElement("br"));
                    }

                    
                    
                    divbody.appendChild(divwell);
                    li_item.appendChild(divbody);
                    maindiv.appendChild(li_item);
                
                }





            },
            error: function (hata) {

                alert(hata);
            }
        });
      
    }
   

    </script>
</asp:Content>