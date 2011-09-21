<cfif arguments.autoFix>
	<cfset arguments.value =  reReplaceNoCase( arguments.value, "[^0-9]", "", "all" )>
</cfif>

<cfif NOT isValid( "creditcard", arguments.value )>
	<cfset arguments.value = "">
	<cfset arguments.message = "number does not match card type, please verify">
</cfif>
