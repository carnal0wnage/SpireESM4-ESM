<cfoutput>
<input type="submit" value="Send">
<input type="button" value="Cancel" onclick="location.href='../editPage/?id=#requestObj.getFormUrlVar('id')#'">
<input type='hidden' name='pageid' id='pageid' value="#requestObj.getFormUrlVar('id')#">


<script>
	function done(){
		alert('today')
		$('maincontent') = '<input type="button" value="Request for review Sent!" onClick="location.href=\'../editPage/?id=#requestObj.getFormUrlVar('id')#\'">';
	}

</script>
</cfoutput>