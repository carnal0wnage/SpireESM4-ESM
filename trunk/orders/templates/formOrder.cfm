<!---<cfset lcl.Order = getDataItem('Order')>
<cfset lcl.form = createWidget("formcreator")>

<cfset lcl.form.startform()>
<cfdump var=#lcl.Order.getID()#>
<cfset lcl.form.addformitem('id', '', true, 'hidden', lcl.Order.getid() )>
<cfset lcl.form.addformitem('description', 'Description', true, 'text', lcl.Order.getbilling_name() )>

<cfset lcl.form.endform()>

<cfoutput>#lcl.form.showHTML()#</cfoutput>

<script>
	function switchtoedit(id){
		document.getElementById('deleteBtn').style.display="inline";
		document.myForm.id.value = id;	
	}
</script>--->