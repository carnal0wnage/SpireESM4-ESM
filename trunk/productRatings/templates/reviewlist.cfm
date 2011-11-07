<cfset lcl.list = getDataItem("ratingslist")>
<cfset lcl.taxobj = getDataItem("taxobj")>
<cfif lcl.list.recordcount>
	
	<cfoutput query="lcl.list">
		<div style="border:1px solid ##EBEBEB;padding:0 10px 10px;margin-bottom:5px;">
		<p>
			<cfset lcl.taxitem = lcl.taxobj.getById(lcl.list.ratingtype)>
			Review for type : <strong>#lcl.taxitem.name#</strong>,
			Rated : <strong>#lcl.list.rating#</strong>,
			Active : <strong>#yesnoformat(lcl.list.active)#</strong>
			<input style="float:right;" type="button" value="Edit" onclick="location.href='../editrating/?id=#lcl.list.id#&productid=#requestObj.getFormurlVar("id")#';"><br>
			#lcl.list.ratingtext#
			
		</p>
		</div>
	</cfoutput>
<cfelse>
	<p>There are no ratings for this product.</p>
</cfif>
