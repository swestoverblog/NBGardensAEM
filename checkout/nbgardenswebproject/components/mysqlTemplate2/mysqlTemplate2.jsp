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
  if (confirm("Are you sure you want to add Product to database?") == true) {

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
   myTest();} else {myTest();}
  });

}); // end ready
     function myTest() {
                    location.reload(true);
                }
</script>

</head>
<body bgcolor="#e8e8e8">
<div class="wrapper" align="center">
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
    <input type="first" id="first" name="first" value="" required/>
    </td>
    </tr>
    <tr>
    <td>
    <label for="last">Product Type:</label>
    </td>
     <td>
    <input type="last" id="last" name="last" value="" required/>
    </td>
    </tr>
     <tr>
    <td>
        <label for="address">Description:</label>
    </td>
     <td>
         <input type="address" id="address" name="address" value="" required/>
    </td>
    </tr>
     <tr>
    <td>
        <label for="qty">Qty:</label>
    </td>
     <td>
    <input type="qty" id="qty" name="qty" value="" required/>
    </td>
    </tr>
         <tr>
    <td>
    <label for="price">Price:</label>
    </td>
     <td>
    <input type="price" id="price" name="price" value="" required/>
    </td>
    </tr>
     <tr>
    <td>
    <label for="prodId">Product Id:</label>
    </td>
     <td>
    <input type="prodId" id="prodId" name="prodId" value="" required/>
    </td>
    </tr>

</table>
            <div>
                <input type="submit" value="Add Product"  name="submit" id="submit" value="Submit">
            </div>
        </form>
        </div>
    </div>

</div>
</body>
</html>