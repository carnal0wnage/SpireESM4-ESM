<cfsavecontent variable="modulexml">
<module name="Orders" label="Orders" menuOrder="130" topnav="false" securityitems="Update Order,Delete Order">

	<action name="Start Page" template="twocolumnwnavigation">
		<template name="browseContent" title="Browse" file="browse.cfm"/>
		<template name="browseContent" title="Search" file="search.cfm"/>
		<template name="title" title="label" file="starttitle.cfm"/>
		<template name="mainContent" title="Start Page" file="start.cfm"/>
	</action>
	
	<action name="Add Order" onMenu="0" isSecurityItem="1" formsubmit="SaveOrder" template="twocolumnwnavigation">
		<template name="browseContent" id="browse" title="Browse" file="browse.cfm"/>
		<template name="browseContent" title="Search" file="search.cfm"/>
		<template name="title" title="label" file="titlelabel.cfm"/>
	
		<template name="title" title="buttons" file="titlebuttons.cfm"/>
		<template name="mainContent" title="Properties" file="Orderproperties.cfm"/>
		<template name="mainContent" title="Billing Address" file="Orderaddress_Billing.cfm"/>
        <template name="mainContent" title="Shipping Address" file="Orderaddress_Shipping.cfm"/>
	</action>
	
	<action name="Browse"/>
	
	<action name="Search" onMenu="0" isSecurityItem="1" template="twocolumnwnavigation">
		<template name="browseContent" title="Browse" file="browse.cfm"/>
		<template name="browseContent" title="Search" file="search.cfm"/>
		<template name="title" title="Search Results" file="searchtitle.cfm"/>
		<template name="mainContent" title="Search Results" file="searchresults.cfm"/>
	</action>

	<action name="Save Order" method="SaveOrder" onSuccess="startPage/"/>

	<action name="Edit Order" isSecurityItem="1" formsubmit="SaveOrder" template="twocolumnwnavigation">
		<template name="browseContent" id="browse" title="Browse" file="browse.cfm"/>
		<template name="browseContent" title="Search" file="search.cfm"/>
		<template name="title" title="label" file="titlelabel.cfm"/>
	
		<template name="title" title="buttons" file="titlebuttons.cfm"/>
		<template name="mainContent" title="Properties" file="Orderproperties.cfm"/>
        <template name="mainContent" title="Order Items" file="OrderLineItems.cfm"/>
		<template name="mainContent" title="Billing Address" file="Orderaddress_Billing.cfm"/>
        <template name="mainContent" title="Shipping Address" file="Orderaddress_Shipping.cfm"/>
		<template name="mainContent" title="History" file="history.cfm"/>
	</action>

	<action name="Delete Order" method="DeleteOrder" isSecurityItem="1" onSuccess="startPage"/>

</module>
</cfsavecontent>


<cfset modulexml = xmlparse(modulexml)>