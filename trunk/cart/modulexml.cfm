<cfsavecontent variable="modulexml">
<module name="Cart" label="Cart" menuOrder="125" securityitems="Cart">

	<action name="Start Page" template="onecolumnwnavigation">
		<template name="title" title="label" file="starttitle.cfm"/>
		<template name="mainContent" title="Start Page" file="start.cfm"/>
	</action>

</module>
</cfsavecontent>

<cfset modulexml = xmlparse(modulexml)>



