<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Defaults.aspx.vb" Inherits="PMS.Defaults" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
     <title>Project Management System</title>
  <%--   <link href="Resources/Styles/PMStyle.css"  rel="Stylesheet" type="text/css" />  --%>
     <link href="Content/bootstrap.min.css"  rel="Stylesheet" type="text/css" /> 
  <link href="Content/font-awesome-4.7.0/css/font-awesome.min.css"  rel="Stylesheet" type="text/css" /> 
    <!------ Include the above in your HEAD tag ---------->
  <script src="scripts/jquery-2.2.4.min.js" ></script>
     <script src="scripts/bootstrap.min.js" ></script>
       <script src="scripts/jquery.signalR-2.4.0.min.js" ></script>
    <script src="signalr/hubs" type="text/javascript" ></script>
        <link href="Resources/Styles/PMStyle.css"  rel="Stylesheet" type="text/css" /> 
  <script type="text/javascript" src="//cdnjs.cloudflare.com/ajax/libs/jquery.lazy/1.7.9/jquery.lazy.min.js"></script>
    <script type="text/javascript" src="//cdnjs.cloudflare.com/ajax/libs/jquery.lazy/1.7.9/jquery.lazy.plugins.min.js"></script>
          
    <script>

        $(function () {
            $('.NotificationText').Lazy();
        });
 
        window.LoadProject = function () {
        

        $.ajax({
            type: "POST",
            contentType: "application/json",
            data: "{}",
            url: "Defaults.aspx/GetProject",
            dataType: "json",
            success: function (data) {


                for (i = 0; i < data.d.length; i++) {



                    $(".ProjectMenu").append('<li class="sub-nav-item Project" id="' + data.d[i][1] + '"><h4>' + data.d[i][0] + '</h4></li>')

                }



            },
            error: function (XMLHttpRequest, textStatus, errorThrown) {
                debugger;
            }
        });
    };
         
     

</script>
    
    
  


</head>
 <body>
    <form id="form1" runat="server">

        <asp:HiddenField ID="UserId" runat="server"  />
        <article id="container">
  <header id="main-nav">
    <h1 class="logo">AlGhalbi Operaions <span id="ScreenName" > </span></h1>
    <div id="bun"><div class="mmm-Project"></div></div>

    <div class="dropdown"  id="Notification" style="position: absolute;right: 10px;top: 30%;">
    <a href="#" onclick="return false;" role="button" data-toggle="dropdown" id="dropdownMenu1" data-target="#" style="float: left" aria-expanded="true">
        <i class="fa fa-bell-o" style="font-size: 20px; float: left; color: white">
        </i>
    </a>
    <span id="NotificationCount" class="badge badge-danger"> </span>
    <ul class="dropdown-menu dropdown-menu-left pull-right" id="drpnot" role="menu" aria-labelledby="dropdownMenu1"      
  style="height: 60vh;
    overflow: auto;"  >
        <li role="presentation">
            <a href="#" class="dropdown-menu-header">Notifications</a>
        </li>
        <ul id="ulTimeLine" class="timeline timeline-icons timeline-sm" style="margin:10px;width:210px">
                                   
                                        
                                    </ul>
        <li role="presentation">
            <a href="#" class="dropdown-menu-header"></a>
        </li>
    </ul>
</div>
  </header>
  <section id="content">
<%--    <div class="left-Project"><div class="triangle"></div><h2></h2></div>
    <div class="right-slider"><h2></h2></div>--%>

       <iframe id="IFMain"  src="Index.aspx"   width="100%" style="border:0;height:88vh"></iframe> 


         <div class="row" style="height:5vh ">
<div class="col-sm-12 col-md-12 col-lg-12 col-xl-12 Box">
</div>
</div>
  </section>
</article>
<aside id='sidebar'>
    <nav id='mobile-nav'>
      <h1 class="mobile-logo"> <asp:Label ID="lblUserName" runat="server" BackColor="Transparent" BorderWidth="0" ForeColor="White" ></asp:Label> </h1>
      <ul>
        <li class="nav-item Task  MainMenu"><h3>Home</h3></li>
        <li class="nav-item MainMenu"><h3>Projects</h3></li>
          <ul class="sub-nav ProjectMenu">
 
              
          </ul>
         <li class="nav-item Logout"><h3><asp:Button BorderColor="Transparent" Width="100%" ForeColor="White"  BackColor="Transparent" ID="Logout" runat="server" Text="Logout" ></asp:Button>  </h3></li>
        
      </ul>
  </nav>
</aside>
    <div class="container-fluid">
 

     
        </div>
        </form>
     </body>
    </html>



<script>

    $(document).click(function () {
        if ($(this).id != "Notification") {
            $("#drpnot").hide("slow")
        }
    });
    $("#Notification").click(function () {

      

        $("#drpnot").toggle("slow")



        $.ajax({
            type: "POST",
            contentType: "application/json",
            data: "{}",
            url: "Defaults.aspx/UpdateNotification",
            dataType: "json",
            success: function (data) {

 



            },
            error: function (XMLHttpRequest, textStatus, errorThrown) {
                debugger;
            }
        });
    });

  
    $(document).on("click", ".Project", function () {
       
        $("#IFMain").attr("src", "Projects.aspx?ProjectID=" + $(this).attr("Id"));

        $("#ScreenName").text(" - " + $(this).children(0).text( ))
            closeOut()
          
         
     
     
    });


    $(document).on("click", ".Task", function () {

 

        $("#IFMain").attr("src", "Index.aspx");

        closeOut()

    });


    $('document').ready(function () {
        LoadProject()
        var screenHeight = $(window).height();
        var screenWidth = $(window).width();
        var navHeight = $('#main-nav').height();
        var contentHeight = screenHeight - navHeight;

        var delay = 300;
        $('.nav-item').each(function () {
            $(this).css('transition-delay', delay + 'ms');
            delay = delay + 100;
        });

        $('.MainMenu').click(function () {
            $("#ScreenName").text("")
        });

        $('#mobile-nav').height(screenHeight);
        $('#content').css({
            'height': contentHeight,
            'margin-top': navHeight
        });

        $('.nav-item').each(function () {
            if ($(this).next().is('.sub-nav')) {
                $(this).addClass('arrowed');
            } else { };
        });
        $('#bun').click(function () {
            closeOut()
        });
        $('#content').click(function () {
            if ($('#container').hasClass('body-slide')) {
                closeOut()
            } else { };
        });
        $('.arrowed').click(function () {
            $(this).toggleClass('selected');
            $(this).siblings().removeClass("selected");
            $('.sub-nav').each(function () {
                $(this).slideUp("slow");
            });
            if ($(this).next('.sub-nav').is(':visible')) {
                $(this).next('.sub-nav').slideUp('slow');
            } else {
                $(this).next('.sub-nav').slideDown('slow');
            };
        });
    });

    function closeOut() {
        $('body').toggleClass('scroll-jam');
        $('#sidebar').toggleClass('nav-slide');
        $('#container').toggleClass('body-slide');
        $('.nav-item').toggleClass('item-slide');
        $('.nav-item').removeClass('selected');
        $('.sub-nav').each(function () {
            $(this).hide();
        });
        
    }


    function LoadProject() {
       
        $.ajax({
            type: "POST",
            contentType: "application/json",
            data: "{}",
            url: "Defaults.aspx/GetProject",
            dataType: "json",
            success: function (data) {


                for (i = 0; i < data.d.length; i++) {

                    $(".ProjectMenu").append('<li class="sub-nav-item Project" id="' + data.d[i][1] + '"><h4>' + data.d[i][0] + '</h4></li>')

                }



            },
            error: function (XMLHttpRequest, textStatus, errorThrown) {
                debugger;
            }
        });
    };
    $(function () {
     
        // Declare a proxy to reference the hub.          

        var notifications = $.connection.notificationHub;

        // Create a function that the hub can call to broadcast messages.

        notifications.client.RecieveNotification = function (Datas) {
           
            var notifcount = 0

            $("#ulTimeLine").text("")
            for (i = 0; i < Datas.length; i++) {
                if (Datas[i][3] == 0)
                {
                    notifcount = notifcount + 1;
                }

                //$("#ulTimeLine").append(" <li class='NotificationText'><p>" + Datas[i][0] + "," + Datas[i][1] + " <span class='timeline-icon'><i class='fa fa-info-circle' style='color:red'></i></span><span class='timeline-date'>" + Datas[i][2] + "</span>   </p> </li>")

                $("#ulTimeLine").append(" <li class='NotificationText'><p>" + Datas[i][0] + "," + Datas[i][1] + " <span class='timeline-icon'></span><span class='timeline-date'>" + Datas[i][2] + "</span>   </p> </li>")


               // alert(Datas[i][0])
            }
            if (notifcount>0)
                $("#NotificationCount").text(notifcount)
            else
                $("#NotificationCount").text("")
        };


        notifications.client.ChangeNotification = function (Datas) {
          
            var v = $("#UserId").val();
            notifications.server.sendNotifications(v, $.connection.hub.id);
        };
        // Start the connection.
        var v = $("#UserId").val();
        debugger;
        $.connection.hub.start().done(function () {

            notifications.server.sendNotifications(v, $.connection.hub.id);

        }).fail(function (e) {

            alert(e);

        });


    
    });

</script>

 <style>
body {
  width: 100%;
  overflow-x: hidden;
  font-family: "Bree Serif", serif;
  font-weight: 400;
  letter-spacing: 1px;
  overflow: hidden;
}

h1 {
  font-family: "Marmelad", sans-serif;
  font-weight: 400;
  font-style: normal;
  letter-spacing: 0px;
  font-size: 1.75em;
}


</style>