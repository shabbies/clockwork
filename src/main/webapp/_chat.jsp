<div class="chat-body col-md-12 chat-body" id="chat_body">
    <!-- One Reply -->
    <!--
    <div class='single-response-panel'>
        <div class="col-md-1 chat-other-profile-panel">
            <img class="chat-other-profile" src='https://s3-ap-southeast-1.amazonaws.com/media.clockworksmu.herokuapp.com/app/public/assets/logos/Tiong+Bahru+Bakery+2.jpg'>
        </div>
        <div class="col-md-11 chat-other-text-panel">
            <div class="col-md-12">
                <strong>Tiong Bahru Bakery</strong>
            </div>
            <div class="col-md-12">
                <div class="col-md-10 chat-text-content">hi</div>
                <div class="chat-text-timestamp col-md-2"> 10:03 PM</div>
                <div class="col-md-10 chat-text-content">how are you guys doing?</div>
                <div class="chat-text-timestamp col-md-2"> 10:03 PM</div>
            </div>
        </div>
    </div>
    -->
    <!-- END ONE REPLY -->

    <!-- One Reply -->
    <!--
    <div class='single-response-panel'>
        <div class="col-md-1 chat-other-profile-panel">
            <img class="chat-other-profile" src='img/user-placeholder.jpg'>
        </div>
        <div class="col-md-11 chat-other-text-panel">
            <div class="col-md-12">
                <strong>Shabbies</strong>
            </div>
            <div class="col-md-12">
                <div class="col-md-10 chat-text-content">hey man</div>
                <div class="chat-text-timestamp col-md-2"> 10:10 PM</div>
                <div class="col-md-10 chat-text-content">so how's the job gonna be like?</div>
                <div class="chat-text-timestamp col-md-2"> 10:11 PM</div>
            </div>
        </div>
    </div>
    -->
    <!-- END ONE REPLY -->
</div>
<div class="chat-body-input-panel col-md-12">
    <input type="text" class="chat-body-input" id="chat_input" placeholder="Type a message"/>
</div>

<script>
    var last_message_id = 0;
    var last_sender_id = null;
    var post_ID = null;
    
    $(document).ready(function(){
        post_ID = getUrlParameter('id');
        $(".chat-body").click(function(e){
           $("#chat_input").focus(); 
        });
        
        $('#chat_input').keypress(function (e) {
            if (e.keyCode === 13) {
                var content = $("#chat_input").val();
                $.ajax({
                    url: "/NewChatMessage",
                    method: "GET",
                    async: true,
                    data: {
                        post_id: post_ID,
                        content: content
                    },
                    success: function(responseString) {
                        if (responseString.toString().indexOf("success") >= 0){
                            refreshChat(post_ID);
                            $(".chat-body").animate({ scrollTop: $(".chat-body")[0].scrollHeight}, 1000);
                            $("#chat_input").val("");
                            $("#chat_input").focus();
                        }
                        $(".no-conversation-text").remove();
                    },
                    error: function(jqXHR, textStatus, errorThrown) {
                        console.log(textStatus, errorThrown);
                    }
                }); 
            }
        });
        
        setInterval(refreshChat(post_ID), 3000);
        
        function refreshChat(postID){
            $.ajax({
                url: "/GetChatMessages",
                method: "GET",
                async: true,
                data: {
                    post_id: postID
                },
                success: function(resultString) {
                    if (resultString.indexOf("[]") < 0) {
                        var results = JSON.parse(resultString);
                        $(results).each(function(){
                            var id = $(this).attr("id");
                            if (last_message_id >= id){
                                return;
                            }
                            last_message_id = id;
                            var sender = $(this).attr("sender");
                            var sender_ID = $(this).attr("senderID");
                            var avatar = $(this).attr("avatar");
                            var content = $(this).attr("content");
                            var date = $(this).attr("timeOnly");
                            if(typeof avatar === "undefined"){
                                avatar = "img/user-placeholder.jpg";
                            }
                            if (last_sender_id !== sender_ID){
                                var $main_div = $("<div>", {class: "single-response-panel"});
                                var $image_div = $("<div>", {class: "col-xs-1 chat-other-profile-panel hidden-xs"});
                                var $image = $("<img>", {class: "chat-other-profile", src: avatar});
                                $image_div.append($image);

                                var $content_div = $("<div>", {class: "col-xs-11 chat-other-text-panel"});
                                var $name_div = $("<div>", {class: "col-md-12"});
                                var $name = $("<strong>");
                                $name.append(sender);
                                $name_div.append($name);

                                var $text_div = $("<div>", {class: "col-md-12 chat-message"});
                                var $text = $("<div>", {class: "col-md-10 chat-text-content"});
                                var $timestamp = $("<div>", {class: "col-md-2 chat-text-timestamp"});

                                $timestamp.append(date);
                                $text.append(content);
                                $text_div.append($text);
                                $text_div.append($timestamp);

                                $content_div.append($name_div);
                                $content_div.append($text_div);

                                $main_div.append($image_div);
                                $main_div.append($content_div);
                                $(".chat-body").append($main_div);
                            } else {
                                var $text = $("<div>", {class: "col-md-10 chat-text-content"});
                                var $timestamp = $("<div>", {class: "col-md-2 chat-text-timestamp"});

                                $timestamp.append(date);
                                $text.append(content);

                                $(".chat-message:last").append($text);
                                $(".chat-message:last").append($timestamp);
                            }
                            last_sender_id = sender_ID;
                        });
                        $(".chat-body").animate({ scrollTop: $(".chat-body")[0].scrollHeight}, 0);
                    } else {
                        var $text = $("<div>", {class: "no-conversation-text"});
                        
                        $text.append("Start a conversation now!");
                        $("#chat_body").empty();
                        $(".chat-body").append($text);
                    }
                },
                error: function(jqXHR, textStatus, errorThrown) {
                    console.log(textStatus, errorThrown);
                }
            }); 
        }
        
        Chat = {
            refreshChat: function(postID) {
                $("#chat_body").empty();
                last_message_id = 0;
                last_sender_id = null;
                post_ID = postID;
                refreshChat(postID);
            }
        }
    });
    
    var getUrlParameter = function getUrlParameter(sParam) {
    var sPageURL = decodeURIComponent(window.location.search.substring(1)),
        sURLVariables = sPageURL.split('&'),
        sParameterName,
        i;

    for (i = 0; i < sURLVariables.length; i++) {
        sParameterName = sURLVariables[i].split('=');

        if (sParameterName[0] === sParam) {
            return sParameterName[1] === undefined ? true : sParameterName[1];
        }
    }
    
    
};
</script>