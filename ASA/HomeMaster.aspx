<%@ Page Title="" Language="C#" MasterPageFile="~/Home.Master" AutoEventWireup="true" CodeBehind="HomeMaster.aspx.cs" Inherits="ASA.HomeMaster" %>


<asp:Content ID="search" ContentPlaceHolderID="Search_place" runat="server" >

   <div class="container">
<div >
	<input type="text" onkeyup="ata1()"   class="center-block form-control" id="search_value" placeholder="Search">
      
</div>
</div>
    <style>
    .btn-search {
	  background: #424242;
	  border-radius: 0;
	  color: #fff;
	  border-width: 1px;
	  border-style: solid;
	  border-color: #1c1c1c;

	}
	.btn-search:link, .btn-search:visited {
	  color: #fff;
	}
	.btn-search:active, .btn-search:hover {
	  background: #1c1c1c;
	  color: #fff;
	}
   
    
        #search_value {
            width: 130px;
            box-sizing: border-box;
            border: 2px solid #ccc;
            border-radius: 4px;
            font-size: 16px;
            
            background-color: white;
            background-image: url('/images/searchicon.png');
            background-position: 10px 10px;
            background-repeat: no-repeat;
            padding: 12px 20px 12px 40px;
            -webkit-transition: width 0.4s ease-in-out;
            transition: width 0.4s ease-in-out;
        }

      #search_value:focus {
    width: 50%;
}


    
    
    </style>
   
            
               
    

    
    

</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder2" runat="server">
     


      <body onload="ata1()">
    <div id="fh5co-main">
		<div class="container">

			<div class="row">

         <div id="fh5co-board" data-columns="">
             
         </div>
        </div>
       </div>
	</div>
          <script src="js/jquery-1.10.2.min.js"></script>
        </body>
    <script type="text/javascript">

        function createDiv(columnsize) {
            var columnsize = document.createElement('div');
            columnsize.setAttribute('class', 'column size-1of4');
            return columnsize;
        }

        $('div img').click(function (event) {
            // Remember the link href
            var href = this.href;

            // Don't follow the link
            event.preventDefault();
            alert("a");
            // Do the async thing
            startSomeAsyncThing(function () {
                alert("b");
                // This is the completion callback for the asynchronous thing;
                // go to the link
                window.location = href;
            });
        });

        function ata1() {
            var search_value
            search_value = document.getElementById("search_value").value;
            if (search_value == null) search_value = "";
            var classdiv = document.getElementsByClassName("item");

            while (classdiv.length > 0) {
                classdiv[0].parentNode.removeChild(classdiv[0]);
               
            }
            

                $.ajax({
                    type: "POST",
                    url: "HomeMaster.aspx/ShareList",
                    data: "{'search_value':'"+search_value+"'}",
                    contentType: "application/json;charset-utf-8",
                    success: function (result) {

                        var MyData = JSON.parse(result.d);
                        var maindiv = document.getElementById('fh5co-board');
                        var i;
                        var data = MyData.Table;
                       
                        var divs = [
                       createDiv("columnsize"),
                       createDiv("columnsize2"),
                       createDiv("columnsize3"),
                       createDiv("columnsize4")
                        ];

                       
                        for (i = 0; i < data.length; i++) {
                            var divitem = document.createElement('div');
                            divitem.setAttribute('class', 'item');

                            var divanimate = document.createElement('div');
                            divanimate.setAttribute('class', 'animate-box bounceIn animated');

                            var a = document.createElement('a');
                            a.setAttribute('class', 'image-popup fh5co-board-img');
                            a.setAttribute('href', "QuestionMaster.aspx?id=<%# Request.QueryString["GETID"] %>" + data[i].id);

                            console.log(data[i])
                            var img = document.createElement('img');
                            img.setAttribute('src', data[i].path);
                            a.appendChild(img);

                            var divText = document.createElement('div');
                            divText.setAttribute('class', 'fh5co-desc');

                            var stringName = '<p>' + data[i].explain + '</p>';


                            divText.innerHTML += stringName;

                            divanimate.appendChild(a);
                            divanimate.appendChild(divText);
                            divitem.appendChild(divanimate);
                            if (i % 4 == 0) {
                                divs[0].appendChild(divitem);

                            }
                            if (i % 4 == 1) {
                                divs[1].appendChild(divitem);
                            }
                            if (i % 4 == 2) {
                                divs[2].appendChild(divitem);
                            }
                            if (i % 4 == 3) {
                                divs[3].appendChild(divitem);
                            }


                        }

                        for (var j = 0; j < 4; j++) {
                            maindiv.appendChild(divs[j]);

                        }



                    },
                    error: function (hata) {

                        alert(hata);
                    }


                });


           
        }
        
</script>   
                    
</asp:Content>