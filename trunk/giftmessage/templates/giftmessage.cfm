<cfset lcl.gm = getDataItem('giftmessage')>
<cfset lcl.form = createWidget("formcreator")>

<cfset lcl.form.startform()>
<cfset lcl.form.addcustomformitem(lcl.gm.messagetext)>
<cfset lcl.form.endform()>

<cfoutput>#lcl.form.showHTML()#</cfoutput>
