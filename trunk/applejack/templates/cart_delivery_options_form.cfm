<cfset lcl.info = getDataItem('item')>
<cfif isDataItemSet("zips")>
	<cfset lcl.zips = getDataItem("Zips")>
</cfif>
<cfset lcl.form = createWidget("formcreator")>

<cfset lcl.form.startform()>
<cfset lcl.form.addformitem('id', 'id', true, 'hidden', lcl.info.getId())>

<cfset lcl.titleoptions = structnew()>
<cfset lcl.titleoptions.style="width:300px">
<cfset lcl.form.addformitem('label', 'Title', true, 'text', lcl.info.getLabel(), lcl.titleoptions)>


<cfset lcl.form.addformitem('Cost', 'Cost', true, 'text', lcl.info.getCost())>

<cfset lcl.form.endform()>

<cfoutput>
	#lcl.form.showHTML()#
	<a class="addZip" rel="gid=#lcl.info.getId()#" href="">Add Zip</a><br>
	<cfif isdefined("lcl.zips")>
		<cfloop query="lcl.zips">
			#lcl.zips.zip# <a class="validateDelete" rel="zip=#lcl.zips.zip#&id=#lcl.zips.id#&gid=#lcl.info.getid()#" href="">Remove</a><br>
		</cfloop>
	</cfif>
</cfoutput>

<script>
	$(".validateDelete").click(function(){
		var $this = $(this);
		if (confirm("Are you sure you wish to remove "+/[0-9]{5}/.exec($this.attr("rel"))+" from this delivery option?")){
			ajaxWResponseJsCaller("../removeAJDeliveryZip", $this.attr("rel") );
		} 		
		return false;
	});
	$(".addZip").click(function(){
		var $this = $(this);
		var zip=prompt("Please enter the zip you want to add");
		if (zip!=null && zip!=""){
			ajaxWResponseJsCaller("../addAJDeliveryZip/", $this.attr("rel") + '&zip=' + zip );
		}
		return false;
	});
	function switchtoedit(id){
		var i = document.getElementById('deleteBtn');
		if (i) i.style.display="inline";
		document.myForm.id.value = id;	
	}	
</script>