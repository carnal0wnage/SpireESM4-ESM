<cfset lcl.image = getDataItem('Image')>
<cfset lcl.form = createWidget("formcreator")>

<cfset lcl.form.startform()>

<cfset lcl.form.addformitem('id', '', true, 'hidden', lcl.image.getid() )>
<cfset lcl.form.addformitem('relocate', 'Relocate', false, 'text', lcl.image.getrelocate() )>

<cfset lcl.options = structnew()>
<cfset lcl.options.options = querynew('label,value')>
<cfset queryaddrow(lcl.options.options)>
<cfset querysetcell(lcl.options.options,'label','')>
<cfset querysetcell(lcl.options.options,'value','1')>
<cfset lcl.form.addformitem('active', 'Active', false, 'checkbox', lcl.Image.getactive(), lcl.options)>
<!--- this is for block admin.  --->
<cfif requestObj.getFormUrlVar("view", "default") EQ "block">
	<cfset lcl.form.addformitem('view', '', false, 'hidden', "block")>
</cfif>
<!---
<cfset lcl.form.addformitem('id', 'id', true, 'hidden', lcl.userinfo.id)>
<cfset lcl.form.addformitem('fname', 'First Name', true, 'text', lcl.userinfo.fname)>
<cfset lcl.form.addformitem('lname', 'Last Name', true, 'text', lcl.userinfo.lname)>
<cfset lcl.form.addformitem('password', 'Password', true, 'password')>
<cfset lcl.activestuff = structnew()>
<cfset lcl.activestuff.options = querynew('value,label')>
<cfset queryaddrow(lcl.activestuff.options)>
<cfset querysetcell(lcl.activestuff.options,'value','1')>
<cfset querysetcell(lcl.activestuff.options,'label','Yes')>
<cfset lcl.form.addformitem('active', 'Active', false, 'checkbox', lcl.userinfo.active, lcl.activestuff)>
<cfset lcl.form.addformitem('activeold', 'Active', false, 'hidden', lcl.userinfo.active)>
<cfset lcl.form.addformitem('company', 'Company', false, 'text', lcl.userinfo.company)>
<cfset lcl.form.addformitem('homephone', 'Home Phone', false, 'text', lcl.userinfo.homephone)>
<cfset lcl.form.addformitem('mobilephone', 'Mobile Phone', false, 'text', lcl.userinfo.mobilephone)>
<cfset lcl.form.addformitem('fax', 'Fax', false, 'text', lcl.userinfo.fax)>
--->
<cfset lcl.form.endform()>

<cfoutput>#lcl.form.showHTML()#</cfoutput>

<script>
	function switchtoedit(id){
		var i = document.getElementById('deleteBtn');
		var j = document.getElementById('uploadBtn');
		if (i) i.style.display="inline";
		if (j) j.style.display="inline";
		document.myForm.id.value = id;	
	}
</script>
