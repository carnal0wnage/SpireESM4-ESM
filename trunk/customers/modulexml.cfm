<cfsavecontent variable="modulexml">
	<module name="Customers" label="Customers" menuorder="102" topnav="false" securityitems="Add Customer,Edit Customer,Delete Customer">
		<action name="Start Page" template="twocolumnwnavigation">
			<template name="browseContent" title="Browse" file="browse.cfm"/>
			<template name="browseContent" title="Search" file="search.cfm"/>
			<template name="title" title="label" file="starttitle.cfm"/>
			<template name="mainContent" title="Start Page" file="startcontents.cfm"/>
		</action>
		<action name="Add Customer" onMenu="1" isform="1" template="twocolumnwnavigation" formsubmit="saveCustomer">
			<template name="browseContent" id="browse" title="Browse" file="browse.cfm"/>
			<template name="browseContent" title="Search" file="search.cfm"/>
			<template name="title" title="label" file="titleCustomer.cfm"/>
			<template name="title" title="buttons" file="buttonsCustomer.cfm"/>
			<template name="mainContent" title="Properties" file="formCustomer.cfm"/>
		</action>
		<action name="Edit Customer" isform="1" template="twocolumnwnavigation" formsubmit="saveCustomer">
			<template name="browseContent" id="browse" title="Browse" file="browse.cfm"/>
			<template name="browseContent" title="Search" file="search.cfm"/>
			<template name="title" title="label" file="titleCustomer.cfm"/>
			<template name="title" title="buttons" file="buttonsCustomer.cfm"/>
			<template name="mainContent" title="Properties" file="formCustomer.cfm"/>
			<template name="mainContent" title="History" file="history.cfm"/>
		</action>		
		<action name="Search"  onMenu="0" isSecurityItem="1" template="twocolumnwnavigation">
			<template name="browseContent" title="Browse" file="browse.cfm"/>
			<template name="browseContent" title="Search" file="search.cfm"/>
			<template name="title" title="Search Results" file="searchtitle.cfm"/>
			<template name="mainContent" title="Search Results" file="searchresults.cfm"/>
		</action>	
		<action name="browse"/>	
		<action name="deleteCustomer"/>	
		<action name="saveCustomer"/>
	</module>
</cfsavecontent>

<cfset modulexml = xmlparse(modulexml)>
