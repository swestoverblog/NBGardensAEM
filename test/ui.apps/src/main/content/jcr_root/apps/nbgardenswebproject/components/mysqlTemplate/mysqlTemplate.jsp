<%@include file="/libs/foundation/global.jsp"%>

<html>
<head>
    <link rel="stylesheet" type="text/css" href="//cdn.datatables.net/1.10.4/css/jquery.dataTables.css">
    <script type="text/javascript" language="javascript" src="//code.jquery.com/jquery-1.11.1.min.js"></script>
	<script type="text/javascript" language="javascript" src="//cdn.datatables.net/1.10.4/js/jquery.dataTables.min.js"></script>
<meta charset="UTF-8">
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


    // $('body').hide().fadeIn(5000);

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
     var myId= $('#id').val() ;

    var url = location.pathname.replace(".html", "/_jcr_content.persist.json") + "?first="+ myFirst +"&last="+myLast +"&desc="+myDescription +"&address="+myAddress +"&id="+myId;

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
                     var description = $field.find('Description').text(); // window.alert(description);
                     var qty = $field.find('Qty').text();   

                      var price = $field.find('Price').text();   
                     //window.alert(price);
                    //Set the new data
                    oTable.fnAddData( [
                        id,
                       name,
                        type,

                        description,
                         qty,
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


}); // end ready
</script>

</head>

<body bgcolor="#e8e8e8">
<div class="wrapper">


    <div id="container">
     <form name="custdata" id="custdata">

   <div>
     <select id="custQuery"  >
            <option>All Products</option>
            <option>Customizable Products</option> 
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