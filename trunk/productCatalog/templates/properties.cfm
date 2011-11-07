<cfset lcl.info = getDataItem('mdl')>
<cfset lcl.taxobj = getDataItem('taxobj')>
<cfset lcl.form = createWidget("formcreator")>

<cfset lcl.options = structnew()>

<cfset lcl.form.startform()>
<cfset lcl.form.addformitem('id', 'id', true, 'hidden', lcl.info.getId())>
<cfset lcl.options = structnew()>
<cfset lcl.options.style="width:400px;">
<cfset lcl.form.addformitem('title', 'Title', true, 'text', lcl.info.getTitle(),lcl.options)>

<cfset lcl.options = structnew()>
<cfset lcl.options.style="width:400px;">
<cfset lcl.form.addformitem('urlname', 'URL Name', true, 'text', lcl.info.getUrlname(),lcl.options)>

<cfset lcl.options = structnew()>
<cfset lcl.options.style="width:400px;height:40px;">
<cfset lcl.form.addformitem('description', 'Description', true, 'tiny-mce', lcl.info.getDescription(), lcl.options)>

<cfset lcl.options = structnew()>
<cfset lcl.options.style="width:100px;">
<cfset lcl.form.addformitem('sizedescription', 'Size Description', true, 'text', lcl.info.getSizeDescription(), lcl.options)>

<cfset lcl.options = structnew()>
<cfset lcl.options.style="width:30px;">
<cfset lcl.form.addformitem('unitspercase', 'Units Per Case', true, 'text', lcl.info.getUnitspercase(), lcl.options)>

<cfset lcl.options = structnew()>
<cfset lcl.options.style="width:30px;">
<cfset lcl.form.addformitem('unitsperpack', 'Units Per Pack', true, 'text', lcl.info.getUnitsperpack(), lcl.options)>

<cfset lcl.options = structnew()>
<cfset lcl.options.style="width:300px;">
<cfset lcl.form.addformitem('sub_region1', 'Sub Region 1', true, 'text', lcl.info.getsub_region1(), lcl.options)>

<cfset lcl.options = structnew()>
<cfset lcl.options.style="width:300px;">
<cfset lcl.form.addformitem('sub_region2', 'Sub Region 2', true, 'text', lcl.info.getsub_region2(), lcl.options)>


<cfset lcl.options = structnew()>
<cfset lcl.options.options = lcl.taxobj.getByTaxonomyId("product_categories")>
<cfset lcl.options.valueskey="id">
<cfset lcl.options.labelskey="name">
<cfset lcl.options.addBlank = 1>
<cfset lcl.options.BlankText = 'Choose a Product Category'>
<cfset lcl.form.addformitem('product_categoriesTaxonomy', 'Product Category', false, 'select', lcl.info.getProduct_CategoriesTaxonomy(), lcl.options)>

<cfset lcl.options = structnew()>
<cfset lcl.options.options = lcl.taxobj.getByTaxonomyId("region")>
<cfset lcl.options.valueskey="id">
<cfset lcl.options.labelskey="name">
<cfset lcl.options.addBlank = 1>
<cfset lcl.options.BlankText = 'Choose a Region'>
<cfset lcl.form.addformitem('regionTaxonomy', 'Region', false, 'select', lcl.info.getRegionTaxonomy(), lcl.options)>

<cfset lcl.options = structnew()>
<cfset lcl.options.options = lcl.taxobj.getByTaxonomyId("country")>
<cfset lcl.options.valueskey="id">
<cfset lcl.options.labelskey="name">
<cfset lcl.options.addBlank = 1>
<cfset lcl.options.BlankText = 'Choose a Country of Origin'>
<cfset lcl.form.addformitem('countrytaxonomy', 'Country', false, 'select', lcl.info.getCountryTaxonomy(), lcl.options)>

<cfset lcl.options = structnew()>
<cfset lcl.options.options = lcl.taxobj.getByTaxonomyId("classification")>
<cfset lcl.options.valueskey="id">
<cfset lcl.options.labelskey="name">
<cfset lcl.options.addBlank = 1>
<cfset lcl.options.BlankText = 'Choose a Classification'>
<cfset lcl.form.addformitem('classificationTaxonomy', 'Classification', false, 'select', lcl.info.getClassificationTaxonomy(), lcl.options)>


<cfset lcl.options = structnew()>
<cfset lcl.options.options = lcl.taxobj.getByTaxonomyId("colors")>
<cfset lcl.options.valueskey="id">
<cfset lcl.options.labelskey="name">
<cfset lcl.options.addBlank = 1>
<cfset lcl.options.BlankText = 'Choose a Color'>
<cfset lcl.form.addformitem('colorTaxonomy', 'Color', false, 'select', lcl.info.getColorTaxonomy(), lcl.options)>

<cfset lcl.options = structnew()>
<cfset lcl.options.options = lcl.taxobj.getByTaxonomyId("grape")>
<cfset lcl.options.valueskey="id">
<cfset lcl.options.labelskey="name">
<cfset lcl.options.addBlank = 1>
<cfset lcl.options.BlankText = 'Choose a Grape'>
<cfset lcl.form.addformitem('colorTaxonomy', 'Grape', false, 'select', lcl.info.getGrapeTaxonomy(), lcl.options)>

<cfset lcl.options = structnew()>
<cfset lcl.options.options = querynew('label,value')>
<cfset queryaddrow(lcl.options.options)>
<cfset querysetcell(lcl.options.options, 'label', '')>
<cfset querysetcell(lcl.options.options, 'value', '1')>
<cfset lcl.form.addformitem('active', 'Active', false, 'checkbox', lcl.info.getActive(), lcl.options)>

<!--- 
<cfset lcl.options = structnew()>
<cfset lcl.options.options = getDataItem('assetslist') >
<cfset lcl.options.valueskey = 'id'>
<cfset lcl.options.labelskey = 'name'>
<cfset lcl.options.addBlank = 1>
<cfset lcl.options.BlankText = 'Choose an Asset for the Product Detail Page'>
<cfset lcl.form.addformitem('assetid', 'Asset', false, 'select',lcl.info.getAssetid(), lcl.options)>
 --->

<cfset lcl.form.endform()>
<cfoutput>#lcl.form.showHTML()#</cfoutput>

<script>
	function switchtoedit(id){
		var i = document.getElementById('deleteBtn');
		var ii = document.getElementById('uploadBtn');
		if (i) i.style.display="inline";
		if (ii) ii.style.display="inline";
		document.myForm.id.value = id;	
	}
</script>