<cfset lcl.Customer = getDataItem('Customer')>
<cfset lcl.form = createWidget("formcreator")>

<cfset lcl.form.startform()>

<cfset lcl.form.addformitem('id', '', true, 'hidden', lcl.Customer.getid() )>
<cfset lcl.form.addformitem('fname', 'First Name', true, 'text', lcl.Customer.getfname() )>
<cfset lcl.form.addformitem('lname', 'Last Name', true, 'text', lcl.Customer.getlname() )>
<cfset lcl.form.addformitem('username', 'Username', true, 'text', lcl.Customer.getusername() )>
<cfset lcl.form.addformitem('password', 'Password', true, 'password', "" )>

<cfset lcl.options = structnew()>
<cfset lcl.options.options = querynew("value,label")>
<cfset queryaddrow(lcl.options.options)>
<cfset querysetcell(lcl.options.options,"value", "1")>
<cfset querysetcell(lcl.options.options,"label", "Yes")>
<cfset lcl.form.addformitem('active', 'Active', true, 'checkbox', lcl.Customer.getactive(), lcl.options )>
<cfset lcl.form.addformitem('homephone', 'Homephone', true, 'text', lcl.Customer.gethomephone() )>
<cfset lcl.form.addformitem('mobilephone', 'Mobilephone', true, 'text', lcl.Customer.getmobilephone() )>
<cfset lcl.form.addformitem('fax', 'Fax', true, 'text', lcl.Customer.getfax() )>
<cfset lcl.form.addformitem('line1', 'Line1', true, 'text', lcl.Customer.getline1() )>
<cfset lcl.form.addformitem('line2', 'Line2', true, 'text', lcl.Customer.getline2() )>
<cfset lcl.form.addformitem('city', 'City', true, 'text', lcl.Customer.getcity() )>
<cfset lcl.form.addformitem('state', 'State', true, 'text', lcl.Customer.getstate() )>
<cfset lcl.form.addformitem('country', 'Country', true, 'text', lcl.Customer.getcountry() )>
<cfset lcl.form.addformitem('postalcode', 'Postalcode', true, 'text', lcl.Customer.getpostalcode() )>
<cfset lcl.form.addformitem('company', 'Company', true, 'text', lcl.Customer.getcompany() )>
<cfset lcl.form.addformitem('email', 'Email', true, 'text', lcl.Customer.getemail() )>
<cfset lcl.form.addformitem('birthday', 'Birthday', true, 'date', lcl.Customer.getbirthday() )>

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
		document.getElementById('deleteBtn').style.display="inline";
		document.myForm.id.value = id;	
	}
</script>
