<cfset lcl.info = getDataItem('MDL')>

<cfset lcl.form = createWidget("formcreator")>

<cfset lcl.form.startform()>

<cfset lcl.options = structnew()>
<cfset lcl.options.nojs = 1>
<cfset lcl.options.style="width:500px;height:200px;">
<cfset lcl.form.addformitem('specification', 'Specification', false, 'tiny-mce', lcl.info.getSpecification(), lcl.options)>

<cfset lcl.options = structnew()>
<cfset lcl.options.nojs = 1>
<cfset lcl.options.style="width:500px;height:200px;">
<cfset lcl.form.addformitem('review', 'Review', false, 'tiny-mce', lcl.info.getReview(), lcl.options)>

<cfset lcl.options = structnew()>
<cfset lcl.options.nojs = 1>
<cfset lcl.options.style="width:500px;height:200px;">
<cfset lcl.form.addformitem('htmlText', 'Product Content<br>(For the product detail page)', false, 'tiny-mce', lcl.info.getHtmlText(), lcl.options)>
<cfset lcl.form.endform()>

<cfoutput>#lcl.form.showHTML()#</cfoutput>






