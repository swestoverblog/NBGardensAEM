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


    //$('body').hide().fadeIn(5000);

$('#submit').click(function() {
    var failure = function(err) {
      //  $(".main").unmask();
        alert("Unable to retrive data "+err);

    };


    //Get the user-defined values to persist in the database
    var myFirst= $('#first').val() ;
    var myLast= $('#last').val() ;
    var myDescription= $('#address').val() ;
    var myQty= $('#qty').val() ;
    var myPrice= $('#price').val() ;
    var myId= $('#prodId').val() ;

    var url = location.pathname.replace(".html", "/_jcr_content.persist.json") + "?name="+ myFirst +"&type="+myLast +"&desc="+myDescription +"&qty="+myQty +"&price="+myPrice +"&id="+myId;

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
    <div class="content">
    <div class="main">
    <h1>Add Product</h1>

    <form name="signup" id="signup">
     <table>
    <tr>
    <td>
    <label for="first">Product Name:</label>
    </td>
     <td>
    <input type="first" id="first" name="first" value="" />
    </td>
    </tr>
    <tr>
    <td>
    <label for="last">Product Type:</label>
    </td>
     <td>
    <input type="last" id="last" name="last" value="" />
    </td>
    </tr>
     <tr>
    <td>
        <label for="address">Description:</label>
    </td>
     <td>
    <input type="address" id="address" name="address" value="" />
    </td>
    </tr>
     <tr>
    <td>
        <label for="qty">Qty:</label>
    </td>
     <td>
    <input type="qty" id="qty" name="qty" value="" />
    </td>
    </tr>
         <tr>
    <td>
    <label for="price">Price:</label>
    </td>
     <td>
    <input type="price" id="price" name="price" value="" />
    </td>
    </tr>
     <tr>
    <td>
    <label for="prodId">Product Id:</label>
    </td>
     <td>
    <input type="prodId" id="prodId" name="prodId" value="" />
    </td>
    </tr>

</table>
            <div>
                <input type="button" value="Add Product"  name="submit" id="submit" value="Submit">
            </div>
        </form>
        </div>
    </div>

</div>
</body>
</html>