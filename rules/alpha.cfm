<cfif arguments.autoFix>
	<cfset arguments.value = reReplaceNoCase( arguments.value, "[^[:alpha:]]", "", "all" )>
</cfif>

<cfif reFindNoCase( "[^[:alpha:]]", arguments.value )>
	<cfif arguments.mutable AND NOT arguments.autoFix>
		<cfset arguments.value = reReplaceNoCase( arguments.value, "[^[:alpha:]]", "", "all" )>
	</cfif>
	<cfset arguments.message = "can only contain letters (A-Z)">
</cfif>

