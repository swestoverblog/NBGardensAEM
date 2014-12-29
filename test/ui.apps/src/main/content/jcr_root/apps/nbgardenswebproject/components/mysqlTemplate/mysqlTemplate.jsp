<%@include file="/libs/foundation/global.jsp"%>
<html>
<head>
    <link rel="stylesheet" type="text/css" href="//cdn.datatables.net/1.10.4/css/jquery.dataTables.css">
    <script type="text/javascript" language="javascript" src="//code.jquery.com/jquery-1.11.1.min.js"></script>
	<script type="text/javascript" language="javascript" src="//cdn.datatables.net/1.10.4/js/jquery.dataTables.min.js"></script>
<meta charset="UTF-8">
<title>Adobe CQ Persist Page</title>
<style>
#signup .indent label.error {
  margin-left: 0;
}
#signup label.error {
  font-size: 0.8em;
  color: #F00;
  font-weight: bold;
  display: block;
  margin-left: 215px;
}
#signup  input.error, #signup select.error  {
  background: #FFA9B8;
  border: 1px solid red;
}
</style>
<script>
$(document).ready(function() {

       var aDataSet = [
                       ['','','','','',''],
                       ['','','','','','']
                   ];




      $('#dynamic').html( '<table cellpadding="0" cellspacing="0" border="0" class="display" id="example"></table>' );
      $('#example').dataTable( {
          "aaData": aDataSet,
           "bDestroy": true,
          "aoColumns": [
              { "sTitle": "ID" },
              { "sTitle": "Name" },
              { "sTitle": "Type" },
              { "sTitle": "Description", "sClass": "center" },
              { "sTitle": "Qty", "sClass": "center" },
              { "sTitle": "Price", "sClass": "center" }
          ]
      } );


    $('body').hide().fadeIn(5000);

$('#submit').click(function() {
    var failure = function(err) {
      //  $(".main").unmask();
        alert("Unable to retrive data "+err);

    };


    //Get the user-defined values to persist in the database
    var myFirst= $('#first').val() ;
    var myLast= $('#last').val() ;
    var myDescription= $('#description').val() ;
    var myAddress= $('#address').val() ;

    var url = location.pathname.replace(".html", "/_jcr_content.persist.json") + "?first="+ myFirst +"&last="+myLast +"&desc="+myDescription +"&address="+myAddress;

    //$(".main").mask("Saving Data...");

    $.ajax(url, {
        dataType: "text",
        success: function(rawData, status, xhr) {
            var data;
            try {
                data = $.parseJSON(rawData);


                //Set the fields in the forum
                $('#custId').val(data.pk);

            } catch(err) {
                failure(err);
            }
        },
        error: function(xhr, status, err) {
            failure(err);
        }
    });
  });


//Get customer data -- called when the submitget button is clicked
//this method populates the data grid with data retrieved from the //Adobe CQ JCR
$('#submitget').click(function() {
    var failure = function(err) {
          alert("Unable to retrive data "+err);
      };

    //Get the query filter value from drop down control
    var filter=   $('#custQuery').val() ;

    var url = location.pathname.replace(".html", "/_jcr_content.query.json") + "?filter="+ filter;

    $.ajax(url, {
        dataType: "text",
        success: function(rawData, status, xhr) {
            var data;
            try {
                data = $.parseJSON(rawData);


                //Set the fields in the forum
                var myXML = data.xml;

                var loopIndex = 0;

                //Reference the data grid, clear it, and add new records
                //queried from the Adobe CQ JCR


                  var oTable = $('#example').dataTable();
                 oTable.fnClearTable(true);

                 //Loop through this function for each Customer element
                 //in the returned XML
                 $(myXML).find('Product').each(function(){

                    var $field = $(this);
                     var id = $field.find('Id').text();
                    var name = $field.find('Name').text();

                    var type = $field.find('Type').text();
                     var qty = $field.find('Qty').text();   
                    var Description = $field.find('Description').text();

                      var price = $field.find('Price').text();   


                    //Set the new data
                    oTable.fnAddData( [
                        id,
                       name,
                        type,
                         qty,
                        Description,
                    price,]
                    );

                    });

            } catch(err) {
                failure(err);
            }
        },
        error: function(xhr, status, err) {
            failure(err);
        }
    });
  });

}); // end ready
</script>

</head>
<body>
<div class="wrapper">
    <div class="header">
        <p class="logo">Adobe CQ MySQL Customer Persist/Query Application</p>
    </div>
    <div class="content">
    <div class="main">
    <h1>CQ MySQL Persist Example</h1>

    <form name="signup" id="signup">
     <table>
    <tr>
    <td>
    <label for="first">First Name:</label>
    </td>
     <td>
    <input type="first" id="first" name="first" value="" />
    </td>
    </tr>
    <tr>
    <td>
    <label for="last">Last Name:</label>
    </td>
     <td>
    <input type="last" id="last" name="last" value="" />
    </td>
    </tr>
     <tr>
    <td>
    <label for="address">Address:</label>
    </td>
     <td>
    <input type="address" id="address" name="address" value="" />
    </td>
    </tr>
     <tr>
    <td>
   <label for="description">Description:</label>
    </td>
    <td>
    <select id="description"  >
            <option>Active Customer</option>
            <option>Past Customer</option> 
        </select>
    </td>
    </tr>
     <tr>
    <td>
    <label for="custId">Customer Id:</label>
    </td>
     <td>
    <input type="custId" id="custId" name="custId" value="" readonly="readonly"/>
    </td>
    </tr>

</table>
            <div>
                <input type="button" value="Add Customer!"  name="submit" id="submit" value="Submit">
            </div>
        </form>
        </div>
    </div>

    <div id="container">
     <form name="custdata" id="custdata">

    <h1>Query Customer Data from MySQL</h1>
   <div>
     <select id="custQuery"  >
            <option>All Customers</option>
            <option>Active Customer</option>
            <option>Past Customer</option>   
        </select>
    </div>
    <div id="dynamic"></div>
    <div class="spacer"></div>

   <div>
      <input type="button" value="Get Customers!"  name="submitget" id="submitget" value="Submit">
    </div>
   </form>

</div>
</body>
</html>