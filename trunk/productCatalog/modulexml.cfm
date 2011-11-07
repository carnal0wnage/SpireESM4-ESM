<cfsavecontent variable="modulexml">
<module name="ProductCatalog" label="Product Catalog" menuOrder="110" securityitems="Add Product,Edit Product,Delete Product,View Product Groups,Add Product Group,Edit Product Group,Delete Product Group">

	<action name="Start Page" template="twocolumnwnavigation">
		<template name="browseContent" title="Browse" file="browse.cfm"/>
		<template name="browseContent" title="Search" file="search.cfm"/>
		<template name="title" title="Start Page" file="starttitle.cfm"/>
		<template name="mainContent" title="Start Page" file="start.cfm"/>
		<template name="mainContent" title="Recent Site Activity" file="recentactivity.cfm"/>
	</action>

    <action name="Browse" isSecurityItem="0" template="blankpanels">
		<template name="html" title="Browse" file="browse.cfm"/>
		<template name="html" title="Search" file="search.cfm"/>
	</action>

	<!-- Products -->
	<action name="Add Product" onMenu="1" isSecurityItem="1" isform="1" template="twocolumnwnavigation" formsubmit="saveProduct">
		<template name="browseContent" id="browse" title="Browse" file="browse.cfm"/>
		<template name="browseContent" title="Search" file="search.cfm"/>
		<template name="title" title="label" file="titlelabel.cfm"/>
		<template name="title" title="buttons" file="titlebuttons.cfm"/>
		<template name="mainContent" title="Properties" file="properties.cfm"/>
	</action>

	<action name="Edit Product" isform="1" template="twocolumnwnavigation" formsubmit="saveProduct">
		<template name="browseContent" id="browse" title="Browse" file="browse.cfm"/>
		<template name="browseContent" title="Search" file="search.cfm"/>
		<template name="title" title="label" file="titlelabel.cfm"/>
		<template name="title" title="buttons" file="titlebuttons.cfm"/>
		<template name="mainContent" title="Properties" file="properties.cfm"/>
		<template name="mainContent" title="History" file="history.cfm"/>
	</action>

	<action name="Save Product"/>
	<action name="Delete Product" isSecurityItem="1"/>
	<action name="Upload File Action"/>

	<action name="Search" onMenu="0" isSecurityItem="0" template="twocolumnwnavigation">
		<template name="browseContent" title="Browse" file="browse.cfm"/>
		<template name="browseContent" title="Search" file="search.cfm"/>
		<template name="title" title="Search Results" file="searchtitle.cfm"/>
		<template name="mainContent" title="Search Results" file="searchresults.cfm"/>
	</action>
	<!-- / Products -->


	<!-- / client module -->
	<action name="editClientModule" onMenu="0" template="popup-onecol" formSubmit="saveclientmodule">
		<template name="title" title="label" file="clientmodulelabel.cfm"/>
		<template name="title" title="label" file="clientmodulebuttons.cfm"/>
		<template name="mainContent" title="Properties" file="clientmoduleform.cfm"/>
	</action>

	<action name="Upload Image" template="onecolumnwnavigation" fileupload="true" formsubmit="uploadImageAction">
		<template name="title" title="buttons" file="uploadtitle.cfm"/>
		<template name="title" title="buttons" file="uploadbuttons.cfm"/>
		<template name="mainContent" title="Properties" file="uploadform.cfm"/>
	</action>

	<action name="Upload Image Action" />

    <action name="Save Client Module"/>
    <action name="Delete Client Module"/>
	<!-- / client module -->

</module>
</cfsavecontent>

<cfset modulexml = xmlparse(modulexml)>



