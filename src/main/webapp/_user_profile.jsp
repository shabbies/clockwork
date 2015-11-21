<!-- Profile Modal -->
<div class="modal fade" id="profileModal" tabindex="-1" role="dialog" aria-labelledby="profileModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                    
            </div>
            <div class="modal-body">
                
                <div class="col-md-12 modal-job-details">
                    <div class="col-md-3 text-center">
                        <img id="hiring_avatar" src="http://placehold.it/120x120" alt="" class="db-user-pic img-rounded img-responsive"/>
                    </div>
                        
                    <div class="col-md-9">
                        <h4 id="modalName" class="col-md-12"></h4>
                        <strong class="col-md-5 user_profile_content"> Contact Number </strong><div id="modalContact" class="col-md-7 user_profile_content"></div>
                        <strong class="col-md-5 user_profile_content"> Email</strong><div id="modalEmail" class="col-md-7 user_profile_content"></div>
                        <strong class="col-md-5 user_profile_content"> Gender</strong><div id="modalGender" class="col-md-7 user_profile_content"></div>
                        <strong class="col-md-5 user_profile_content"> Nationality</strong><div id="modalNationality" class="col-md-7 user_profile_content"></div>
                        <strong class="col-md-5 user_profile_content"> Ratings</strong>
                        <div id="modalRating" class="col-md-7 user_profile_content">
                            <div class="display-inline">
                                <div class="display-inline" id="modalGoodRating"> 0 </div>
                                <img src="/img/good.png" class="listing_ratings"/>
                            </div>
                            <div class="display-inline">
                                <div class="display-inline" id="modalNeutralRating"> 0 </div> 
                                <img src="/img/neutral.png" class="listing_ratings"/>
                            </div>
                            <div class="display-inline">
                                <div class="display-inline" id="modalBadRating"> 0 </div>
                                <img src="/img/bad.png" class="listing_ratings"/>
                            </div>
                        </div>
                        <strong class="col-md-12 user_profile_content text-center">Proficiency Score</strong>
                        <div class="col-md-10 user_profile_content col-md-offset-1">
                            <img src="/img/bad.png" class="listing_ratings col-md-2"/>
                            <small class="col-md-7 text-center">Clean Up</small>
                            <small class="col-md-3" id="score_clean_up">0</small>
                        </div>
                        <div class="col-md-10 user_profile_content col-md-offset-1">
                            <img src="/img/bad.png" class="listing_ratings col-md-2"/>
                            <small class="col-md-7 text-center">Order Taking</small>
                            <small class="col-md-3" id="score_order_taking">0</small>
                        </div>
                        <div class="col-md-10 user_profile_content col-md-offset-1">
                            <img src="/img/bad.png" class="listing_ratings col-md-2"/>
                            <small class="col-md-7 text-center">Barista</small>
                            <small class="col-md-3" id="score_barista">0</small>
                        </div>
                        <div class="col-md-10 user_profile_content col-md-offset-1">
                            <img src="/img/bad.png" class="listing_ratings col-md-2"/>
                            <small class="col-md-7 text-center">Selling</small>
                            <small class="col-md-3" id="score_selling">0</small>
                        </div>
                        <div class="col-md-10 user_profile_content col-md-offset-1">
                            <img src="/img/bad.png" class="listing_ratings col-md-2"/>
                            <small class="col-md-7 text-center">Kitchen</small>
                            <small class="col-md-3" id="score_kitchen">0</small>
                        </div>
                        <div class="col-md-10 user_profile_content col-md-offset-1">
                            <img src="/img/bad.png" class="listing_ratings col-md-2"/>
                            <small class="col-md-7 text-center">Bartender</small>
                            <small class="col-md-3" id="score_bartender">0</small>
                        </div>
                        <div class="col-md-10 user_profile_content col-md-offset-1">
                            <img src="/img/bad.png" class="listing_ratings col-md-2"/>
                            <small class="col-md-7 text-center">Service</small>
                            <small class="col-md-3" id="score_service">0</small>
                        </div>
                        <div class="col-md-10 user_profile_content col-md-offset-1">
                            <img src="/img/bad.png" class="listing_ratings col-md-2"/>
                            <small class="col-md-7 text-center">Cashier</small>
                            <small class="col-md-3" id="score_cashier">0</small>
                        </div>
                    </div>
                </div>
                    
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
            </div>
        </div>
    </div>
</div>

<script>
    $(document).on("click", ".open-profileModal", function() {
        var nameText = $(this).data('name');
        var contactText = $(this).data('contact');
        var emailText = $(this).data('email');
        var genderText = ($(this).data('gender') === "M") ? "Male" : "Female";
        var nationalityText = $(this).data("nationality");
        var avatarText = $(this).data('avatar');
        var goodText = $(this).data('good');
        var neutralText = $(this).data('neutral');
        var badText = $(this).data('bad');
        var score_clean_up = $(this).data("cleanup");
        var score_order_taking = $(this).data("ordertaking");
        var score_barista = $(this).data("barista");
        var score_selling = $(this).data("selling");
        var score_kitchen = $(this).data("kitchen");
        var score_bartender = $(this).data("bartender");
        var score_service = $(this).data("service");
        var score_cashier = $(this).data("cashier");
        
        $('#modalName').html("<strong>"+nameText+"</strong>");
        if (typeof contactText === 'undefined'){
            $('#modalContact').html("[HIDDEN]");
        } else {
            $('#modalContact').html(contactText);
        }
        if (typeof emailText === 'undefined'){
            $('#modalEmail').html("[HIDDEN]");
        } else {
            $('#modalEmail').html(emailText);
        }
        $("#modalGender").html(genderText);
        $("#modalNationality").html(nationalityText);
        if (avatarText !== null){
            $('#hiring_avatar').attr("src", avatarText); 
        } else {
            $('#hiring_avatar').attr("src", "img/user-placeholder.jpg"); 
        }
        $("#modalGoodRating").html(goodText);
        $("#modalNeutralRating").html(neutralText);
        $("#modalBadRating").html(badText);
        $("#score_clean_up").html(score_clean_up);
        $("#score_order_taking").html(score_order_taking);
        $("#score_barista").html(score_barista);
        $("#score_selling").html(score_selling);
        $("#score_kitchen").html(score_kitchen);
        $("#score_bartender").html(score_bartender);
        $("#score_service").html(score_service);
        $("#score_cashier").html(score_cashier);
        
        $('#profileModal').modal('show');
    });
</script>