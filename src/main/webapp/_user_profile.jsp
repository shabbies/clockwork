<!-- Profile Modal -->
<div class="modal fade" id="profileModal" tabindex="-1" role="dialog" aria-labelledby="profileModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                    
            </div>
            <div class="modal-body">
                
                <div class="col-md-12 modal-job-details">
                    <div class="col-md-4 text-center">
                        <img id="hiring_avatar" src="http://placehold.it/120x120" alt="" class="db-user-pic img-rounded img-responsive"/>
                    </div>
                        
                    <div class="col-md-8">
                        <h4 id="modalName" class="col-md-12"></h4>
                        <strong class="col-md-4"> Contact Number: </strong><h5 id="modalContact"></h5>
                        <h5 id="modalEmail"></h5>
                        <div id="modalRating">
                            <h5>Ratings</h5>
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
        var avatarText = $(this).data('avatar');
        var goodText = $(this).data('good');
        var neutralText = $(this).data('neutral');
        var badText = $(this).data('bad');
        
        $('#modalName').html("<strong>"+nameText+"</strong>");
        if (typeof contactText === 'undefined'){
            $('#modalContact').html("Phone number: Phone number has been hidden");
        } else {
            $('#modalContact').html("Phone number: " + contactText);
        }
        if (typeof emailText === 'undefined'){
            $('#modalEmail').html("Email: Email has been hidden");
        } else {
            $('#modalEmail').html("Email: " + emailText);
        }
        if (avatarText !== null){
            $('#hiring_avatar').attr("src", avatarText); 
        } else {
            $('#hiring_avatar').attr("src", "img/user-placeholder.jpg"); 
        }
        $("#modalGoodRating").html(goodText);
        $("#modalNeutralRating").html(neutralText);
        $("#modalBadRating").html(badText);
        
        $('#profileModal').modal('show');
    });
</script>