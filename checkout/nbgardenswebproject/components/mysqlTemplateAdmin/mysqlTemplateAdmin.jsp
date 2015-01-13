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

var test;
   var test2 = null;
    var myFirstPub = null;
    var myLastPub= null;
    var myDescriptionPub= null;
    var myQtyPub= null;
    var myPricePub= null;
    var myIdPub=null;
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

 var table = $('#example').DataTable();

    $('#example tbody').on( 'click', 'tr', function () {
        if ( $(this).hasClass('selected') ) {
            $(this).removeClass('selected');
        }
        else {
            table.$('tr.selected').removeClass('selected');
            $(this).addClass('selected');
                        test = table.row(this).data();
                           test2 = test[0];
    myIdPub=test[0];
    myFirstPub = test[1];
    myLastPub= test[2];
    myDescriptionPub= test[3];
    myQtyPub= test[4];
    myPricePub= test[5];

                                     //window.alert(test2);
        }
    } );
    $('#button').click( function () {
          var myFirst2= $('#first').val() ;//window.alert(myFirst2);
            var myLast2= $('#last').val() ;//window.alert(myLast2);
            var myDescription2= $('#address').val() ;//window.alert(myDescription2);
            var myQty2= $('#qty').val() ;//window.alert(myQty2);
            var myPrice2= $('#price').val() ;//window.alert(myPrice2);
            var myId4= $('#prodId').val() ;//window.alert(myId4);
        if(myFirst2 == "") {}
        else {
            if(myLast2 == "") {}
            else {
                if(myDescription2 == "") {}
                else {
                    if(myQty2 == "") {}
                    else {
                        if(myPrice2 == "") {}
                        else {
                            if(myId4 == "") {}
                            else {

		if(test2==null)
        {}
        else {
    	if (confirm("Are you sure you want to modify the selected row?") == true) {
             myFirst2= $('#first').val() ;//window.alert(myFirst2);
             myLast2= $('#last').val() ;//window.alert(myLast2);
             myDescription2= $('#address').val() ;//window.alert(myDescription2);
             myQty2= $('#qty').val() ;//window.alert(myQty2);
             myPrice2= $('#price').val() ;//window.alert(myPrice2);
             myId4= $('#prodId').val() ;//window.alert(myId4);
            var myID3 = test2; //window.alert(myID3);
            var url3 = location.pathname.replace(".html", "/_jcr_content.persist2.json") + "?name="+myFirst2 +"&type="+myLast2 +"&desc="+myDescription2 +"&qty="+myQty2 +"&price="+myPrice2 +"&id="+myID3 +"&id2="+myId4;
			$.ajax(url3, {
       					 dataType: "text",
       					 success: function(rawData, status, xhr) {
           					 var data;
           					 try {
               				 data = $.parseJSON(rawData);
                			//Set the fields in the forum
							} catch(err) {
               				 failure(err);
            				}
        					},
        				error: function(xhr, status, err) {
            				failure(err);
        					}
    		});
               myTest();
    	} else {

        }} }}}}}}


	});
   $('#button2').click( function () {
       if(test2==null)
        {}
       else {
           document.getElementById("first").value=myFirstPub;
	document.getElementById("last").value=myLastPub;
	document.getElementById("address").value=myDescriptionPub;
	document.getElementById("qty").value=myQtyPub;
	document.getElementById("price").value=myPricePub;
	document.getElementById("prodId").value=myIdPub;
		var mydiv = document.getElementById('newpost');
  if (mydiv.style.display === 'block' || mydiv.style.display === '')
    mydiv.style.display = 'none';
  else
    mydiv.style.display = 'block'
       }
    });
 $('#button3').click( function () {
		if(test2==null)
        {}
        else {
    	if (confirm("Are you sure you want to delted the selected row?") == true) {
			var myID2 = test2;
       		 //window.alert(test2);
            var url2 = location.pathname.replace(".html", "/_jcr_content.persist.json") + "?id="+myID2;
			$.ajax(url2, {
       					 dataType: "text",
       					 success: function(rawData, status, xhr) {
           					 var data;
           					 try {
               				 data = $.parseJSON(rawData);
                			//Set the fields in the forum
							} catch(err) {
               				 failure(err);
            				}
        					},
        				error: function(xhr, status, err) {
            				failure(err);
        					}
    		});
               myTest();
    	} else {

        }}


	});
}); // end ready
                function myTest() {
                    location.reload(true);
                }
</script>

</head>

<body bgcolor="#e8e8e8">
<div class="wrapper">


    <div id="container">
     <form name="custdata" id="custdata">

   <div>
     <select id="custQuery"  style="visibility: hidden" >
            <option>All Products</option>
        </select>
    </div>
    <div id="dynamic"></div>
    <div class="spacer"></div>

   <div>
      <input type="button" value="Delete Selected"  name="submitget" id="button3" value="Submit">
       <input type="button" value="Edit Selected"  name="submitget" id="button2" value="Submit">
    </div>
           <div id="newpost" style="display: none">
<form name="signup" id="signup">
     <table>
    <tr>
    <td>
    <label for="first">Product Name:</label>
    </td>
     <td>
    <input type="first" id="first" name="first"  required/>
    </td>
    </tr>
    <tr>
    <td>
    <label for="last">Product Type:</label>
    </td>
     <td>
    <input type="last" id="last" name="last"  required/>
    </td>
    </tr>
     <tr>
    <td>
        <label for="address">Description:</label>
    </td>
     <td>
    <input type="address" id="address" name="address"  required/>
    </td>
    </tr>
     <tr>
    <td>
        <label for="qty">Qty:</label>
    </td>
     <td>
    <input type="qty" id="qty" name="qty"  required/>
    </td>
    </tr>
         <tr>
    <td>
    <label for="price">Price:</label>
    </td>
     <td>
    <input type="price" id="price" name="price"  required/>
    </td>
    </tr>
     <tr>
    <td>
    <label for="prodId">Product Id:</label>
    </td>
     <td>
    <input type="prodId" id="prodId" name="prodId"  required/>
    </td>
    </tr>

</table>
            <div>
                <input type="submit" value="Update"  name="submit" id="button" value="Submit">
            </div>
               </form></div>

         </form>
</div></div>
</body>
</html> 