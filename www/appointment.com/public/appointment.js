

var action = 1;


$(document).ready(function(e) {

     $('#new').on("click", doSomething);

    $('#cancel').click(function() {
        $('#new').attr({
            type: 'button',
            value: 'NEW'
        });
    });

  

    // $('#searchId').keypress(function(e) {
    //     alert('enter key is pressed.');
    //     if (e.which == 13 || event.keyCode == 13) {
    //         getAppointments();
    //     }
    // });


});


function enterButtonPressed(e) {
  // check if the key pressed is the Enter key
    if (e.which == 13 || event.keyCode == 13) {
        getAppointments();
    }

};



function doSomething() {


    if (action == 1) {
        $('#new').attr({
            type: 'submit',
            value: 'ADD'

        });
        action = 2;
    } else {

        document.getElementById("mainForm").submit();
        action = 1;
    }

}

//  $('#searchParam').keypress("click", doSomething);


function show(toBlock) {
    setDisplay(toBlock, 'block');


}

function hide(toNone) {
    setDisplay(toNone, 'none');
}
function setDisplay(target, str) {
    document.getElementById(target).style.display = str;
}

function getAppointments() {


    var s = document.getElementById('searchId').value;

    $.ajax({
        type: 'POST',
        url: '/cgi-bin/searchAppointment.pl',
        dataType: 'json',
        data: { 'searchValue': s },
        success: function(data) {

            $('#tableBody').empty();
            if (data.length == 0) {
                $('#noVal').append('<h3>No Result Found </h3>');
            }
            else {
                $('#noVal').empty();
            }
            for (var key in data) {


                $('#tableBody').append('<tr>');

                $('#tableBody').append('<td><h4>' + data[key].date + '</h4></td>'
                    + '<td><h4>' + data[key].time + '</h4></td>' + '<td><h4>' + data[key].desc + '</h4></td>');

                $('#tableBody').append('</tr>');


            }

        },
        error: function() {
            alert(" It couldn't connect to database.");
        },
        complete: function() {
        }
    });


}


