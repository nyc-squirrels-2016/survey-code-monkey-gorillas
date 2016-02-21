$(document).ready(function() {

  $('#survey-submit').on("submit", function(e){
    e.preventDefault();
    $("#survey-container").html("");
    var form = this;
    var href = $(form).attr("action")
    var request = $.ajax({
        type:"POST",
        url: href,
        data: $(this).serialize()});
    request.done(function(response){
      $("#survey-container").html(response)
      });
    });

  $('body').on("submit", "#question-submit", function(e){
    e.preventDefault();
    $("#question-container").html("")
    var form = this;
    var href = $(form).attr("action")
    var request = $.ajax({
        type:"POST",
        url: href,
        data: $(this).serialize()});
    request.done(function(response){
      $("#question-container").html(response)
      });
    });

  $('#question-container').on("click", ".delete-button", function(e){
    e.preventDefault();
    $(e.target).parent().remove();
  });

  $('.survey-key').click(function(event) {
    event.preventDefault();
    var request = $.ajax({
      type: "POST",
      url: $(this).attr("href"),
      data: $(this).attr("survey-id")
    });

    request.done(function(response) {

    })

    })

  })

  // $('.survey-key').on('click', function(e){
  //   e.preventDefault();
  //   var survey_id = $(this).data("survey-id");
  //   var request = $.post("/surveys/"+survey_id.toString()+"/tokens")
    //   request.done(function(data){
    //     debugger
    //     var content = $(data).find
    //     $('.key').html('success')
    // });

  // });

// Stuff above is working

  var counter = 2
  $('.add').on("click", function(e){
    e.preventDefault();
    $("#answer-container").append("<p><input type='text' name='answer["+ counter +"]' placeholder='enter response'><a class= 'delete-button'>Remove</a></p>")
    counter++
  });



























});
