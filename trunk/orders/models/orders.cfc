<cfcomponent name="orders Model" output="false" extends="resources.abstractmodel">

	<cffunction name="init">
		<cfargument name="requestObj" required="true">
		<cfargument name="userObj" required="true">
		<cfset variables.requestObj = arguments.requestObj>
		<cfset variables.userobj = arguments.userobj>
		<cfset setTableMetaData('{	
			"tableName":"Orders",
			"fields":{
				"id":{"type":"varchar"},
				"userid":{"type":"varchar"},
				"orderStatus":{"type":"varchar"},
				"orderTotal":{"type":"real"},
				"itemsTotal":{"type":"int"},
				"billing_name":{"type":"varchar"},
				"billing_line1":{"type":"varchar"},
				"billing_line2":{"type":"varchar"},
				"billing_city":{"type":"varchar"},
				"billing_state":{"type":"varchar"},
				"billing_postalcode":{"type":"varchar"},
				"billing_email":{"type":"varchar"},
				"delivery_name":{"type":"varchar"},
				"delivery_line1":{"type":"varchar"},
				"delivery_line2":{"type":"varchar"},
				"delivery_city":{"type":"varchar"},
				"delivery_state":{"type":"varchar"},
				"delivery_postalcode":{"type":"varchar"},
				"shipping_quoteId":{"type":"varchar"},
				"created":{"type":"date"},
				"modified":{"type":"date"}
			}
		}')>
		<cfreturn this>
	</cffunction>

	<cffunction name="getOrders" output="false">
    	<cfargument name="statuses" required="no">
		<cfset var orders = "">
        <cfquery name="orders" datasource="#variables.requestObj.getvar('dsn')#" result = "m">
			SELECT *
			FROM orders
			WHERE orderstatus in (<cfqueryparam value="#arguments.statuses#" list="yes">)
          	order by orderstatus, created DESC
		</cfquery>

		<cfreturn orders/>
	</cffunction>

	<cffunction name="getOrderItems" output="false">
    	<cfargument name="id" required="yes">
        <cfset var orderitems="">
        <cfquery name="orderitems" datasource="#variables.requestObj.getvar('dsn')#">
			SELECT    	orderItems.id,  orderItems.quantity, orderItems.price, orderItems.individualPrice,
            		  	orderItems.title name
			FROM      	orderItems 
            WHERE 		orderid = <cfqueryparam value="#arguments.id#" cfsqltype="cf_sql_varchar">
         </cfquery>
        <cfreturn orderitems/>
    </cffunction>

	<cffunction name="getOrderLineItems" output="false">
    	<cfargument name="id" required="yes">
        <cfset var orderlineitems="">
        <cfquery name="orderlineitems" datasource="#variables.requestObj.getvar('dsn')#">
			SELECT     	name, label, total
            FROM       	orderLineItems
            WHERE 		orderid = <cfqueryparam value="#arguments.id#" cfsqltype="cf_sql_varchar">
            ORDER BY 	sortorder
         </cfquery>
        <cfreturn orderlineitems/>
    </cffunction>
	   
	<cffunction name="getShippingMethod" output="false">
    	<cfargument name="id" required="yes">
        <cfset var shipmethod="">
        <cfquery name="shipmethod" datasource="#variables.requestObj.getvar('dsn')#">
			SELECT     	optionlabel
            FROM 		cartShippingQuotes
            WHERE 		id = (SELECT shipping_QuoteID from Orders where ID = <cfqueryparam value="#arguments.id#" cfsqltype="cf_sql_varchar">)
         </cfquery>
        <cfreturn shipmethod/>
    </cffunction>

	<cffunction name="getPaymentMethod" output="false">
    	<cfargument name="id" required="yes">
        <cfset var paymethod="">
        <cfquery name="paymethod" datasource="#variables.requestObj.getvar('dsn')#">
			SELECT     	created, paymentamount, paymentdetails
            FROM 		orderPayments
            WHERE 		orderid = <cfqueryparam value="#arguments.id#" cfsqltype="cf_sql_varchar">
         </cfquery>
        <cfreturn paymethod/>
    </cffunction>
    
    <cffunction name="search" output="false">
		<cfargument name="search">
		<cfargument name="field">
	
		<cfset var orders = "">
		<cfset var searchlist = "billing_name,orderTotal,itemsTotal,orderStatus">
	
		<cfquery name="orders" datasource="#variables.requestObj.getvar('dsn')#" result="m">
			SELECT *
			FROM orders 
			WHERE 1=1
			AND 
				( 1=0
					<cfif isdefined("arguments.field") and #arguments.field# neq "">
						<cfloop list="#arguments.field#" index="word">
							OR #word# = <cfqueryparam value="#search#" cfsqltype="cf_sql_varchar">
						</cfloop>
					<cfelse>
						<cfloop list="#searchlist#" index="word">
							OR #word# LIKE <cfqueryparam value="%#search#%" cfsqltype="cf_sql_varchar">
						</cfloop>
					</cfif>
					
				)
		</cfquery>
	
		<cfreturn orders/>
	</cffunction>

	<cffunction name="validateSave">		
		<cfset var lcl = structnew()>
		<cfset var requestvars = variables.itemData>
		<cfset var mylocal = structnew()>

		<cfset super.validateSave()>

		<cfreturn vdtr/>
	</cffunction>


</cfcomponent>